$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageName  = 'insync'
$url32        = 'https://d2t3ff60b2tol4.cloudfront.net/builds/Insync-3.7.5.50350.exe'
$checksum32   = '14fdf271f83070f3f12d6b65b884260e69940466ef174c9110ceee9f9347d203'

$packageArgs = @{
  packageName   = $packagename
  fileType      = 'exe'
  url           = $url32
  softwareName  = 'Insync'
  checksum      = $checksum32
  checksumType  = 'sha256'
  silentArgs   = '/S'
}

Install-ChocolateyPackage @packageArgs
