$info = (Get-Content "info.json") | ConvertFrom-Json
$info.version += 0.1
$info.date = (Get-Date)
$info | ConvertTo-Json | Out-File "info.json" -Encoding utf8

& git add info.json
& git commit -m "Set version to $($info.version)"
& git tag -a "v$($info.version)" -m "Tag v$($info.version)"
& git push
& git push --tags
