$title = (Invoke-RestMethod https://randomuser.me/api/ -ContentType 'application/json').results.user.username
$info = (Get-Content "info.json") | ConvertFrom-Json
$info.title = $title
$info.version += 0.1
$info.date = (Get-Date)
$info | ConvertTo-Json | Out-File "info.json" -Encoding utf8

& git add info.json
& git commit -m "Set version to $($info.version)"
& git tag -a "v$($info.version)" -m "Tag v$($info.version) - $title"
& git push
& git push --tags

New-Object PSObject -Property @{
  name = $info.title
  tag_name = $info.version
} |
  ConvertTo-Json |
  Invoke-RestMethod -Method POST https://api.github.com/repos/blachniet/rel-tester/releases
