param([ValidateSet('edit','view')][string]$Mode='edit')
$entryName=if ($Mode -eq 'view') { 'asciiView.html' } else { 'asciiEdit.html' }
$entryPath=Join-Path $PSScriptRoot $entryName
if (-not (Test-Path -LiteralPath $entryPath)) { & (Join-Path $PSScriptRoot 'build.ps1') }
if (-not (Test-Path -LiteralPath $entryPath)) { throw "AsciiDoc entry point not found: $entryPath" }
$resolvedPath=(Resolve-Path -LiteralPath $entryPath).Path
$fileUri=[System.Uri]::new($resolvedPath).AbsoluteUri
Start-Process -FilePath $fileUri
