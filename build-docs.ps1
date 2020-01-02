
<#
.SYNOPSIS
    Builds documentation-as-code samples into static HTML output

.NOTES
    Author           : Jasper Siegmund - @jsiegmund

.LINK
    http://www.github.com/jsiegmund/documentation-as-code
#>

param (
  [Switch]$SkipImages = $false
)

# Set variables
$scriptsPath = $PSScriptRoot
$pandocExePath = "pandoc.exe"
$plantumlExePath = "plantuml.exe"
$diagramsOutputFolder = "$scriptsPath/source"

$markdownFiles = Get-ChildItem "source/*.md" -Recurse
Write-Host "Converting $($markdownFiles.Count) Markdown *.md files to reStructuredText .rst files." -ForegroundColor Yellow

# Run pandoc for every .md file and convert it in-place to .rst
$markdownFiles | ForEach-Object {
  $fileFullName = $_.FullName
  $fileOutputName = $fileFullName.Replace(".md", ".rst")

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
if (-not $SkipImages.IsPresent) {

  $plantumlFiles = Get-ChildItem "source/diagrams/*.puml"
  Write-Host "Converting $($plantumlFiles.Count) Plant-UML .puml files to images." -ForegroundColor Yellow

  # Run plantuml for every .puml file found in the diagrams folder
  $plantumlFiles | ForEach-Object {
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