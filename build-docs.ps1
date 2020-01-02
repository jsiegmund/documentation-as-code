
<#
.SYNOPSIS
    Builds documentation-as-code samples into static HTML output

.NOTES
    Author           : Jasper Siegmund - @jsiegmund

.LINK
    http://www.github.com/jsiegmund/documentation-as-code
#>

param (
  [Switch]$ExcludeImages = $false
)

# Set variables
$scriptsPath = $PSScriptRoot
$pandocExePath = "pandoc.exe"
$plantumlExePath = "plantuml.exe"
$diagramsOutputFolder = "$scriptsPath/source"

Write-Host "Converting Markdown *.md files to reStructuredText .rst files." -ForegroundColor Yellow

# Run pandoc for every .md file and convert it in-place to .rst
Get-ChildItem "source/*.md" | ForEach-Object {
  $fileFullName = $_.FullName
  $fileOutputName = "source/$($_.BaseName).rst"

  $pandocArgs = @(
    "--from ""gfm""",
    "--to rst",
    "--output ""$fileOutputName""",
    "$fileFullName"
  )

  # Starts the actual pandoc process
  Start-Process $pandocExePath -ArgumentList $pandocArgs -NoNewWindow -Wait
}

# Image generation might be excluded to optimize build time when diagrams didn't change
if (-not $ExcludeImages.IsPresent) {

  Write-Host "Generating image files from .puml C4 diagrams." -ForegroundColor Yellow

  # Run plantuml for every .puml file found in the diagrams folder
  Get-ChildItem "source/diagrams/*.puml" | ForEach-Object {
    $fileFullName = $_.FullName

    $plantumlArgs = @(    
      "$fileFullName",
      "-o $diagramsOutputFolder/images/diagrams"
    )

    # Starts the actual pandoc process
    Start-Process $plantumlExePath -ArgumentList $plantumlArgs -NoNewWindow -Wait
  }
}

Write-Host "Kicking off Sphinx build process." -ForegroundColor Yellow

# Start the make process which uses Sphynx to convert RST to HTML
Start-Process "$scriptsPath\make.bat" -ArgumentList "html" -NoNewWindow -Wait

Write-Host "Build process done." -ForegroundColor Green