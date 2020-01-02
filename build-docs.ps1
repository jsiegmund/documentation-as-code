
<#
.SYNOPSIS
    Builds documentation-as-code samples into static HTML output

.NOTES
    Author           : Jasper Siegmund - @jsiegmund

.LINK
    http://www.github.com/jsiegmund/documentation-as-code
#>

# Set variables
$scriptsPath = $PSScriptRoot
$pandocExePath = "pandoc.exe"

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

# Start the make process which uses Sphynx to convert RST to HTML
Start-Process "$scriptsPath\make.bat" -ArgumentList "html" -NoNewWindow -Wait