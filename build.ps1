$ErrorActionPreference='Stop'
$repoRoot=$PSScriptRoot
$templatePath=Join-Path $repoRoot 'src\asciiApp.template.html'
if (-not (Test-Path -LiteralPath $templatePath)) { throw "Shared app template not found: $templatePath" }
$template=Get-Content -LiteralPath $templatePath -Raw
$marker="const mode='__APP_MODE__';"
if (-not $template.Contains($marker)) { throw 'The shared template is missing the app mode marker.' }
foreach ($mode in @('view','edit')) {
  $content=$template.Replace($marker,"const mode='$mode';")
  $outputName='asciiEdit.html'
  if ($mode -eq 'view') { $outputName='asciiView.html' }
  $outputPath=Join-Path $repoRoot $outputName
  Set-Content -LiteralPath $outputPath -Value $content -Encoding utf8
}
Write-Host 'Built asciiView.html and asciiEdit.html from the shared template.'
