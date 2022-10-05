[cmdletbinding()]
param(
    [string] $RepoOwner,
    [string] $GroupName,
    [string] $Labels
)

$groups = gh api "/orgs/$RepoOwner/actions/runner-groups | ConvertFrom-Json

$groupId = ($groups.runner_groups | Where-Object { $_.Name -eq $GroupName}).id

$runners = @()
$runners += (gh api "/orgs/$RepoOwner/actions/runner-groups/$groupId/runners" | ConvertFrom-Json).runners
$runners = @{hosts = $runners} | ConvertTo-Json -Compress -Depth 5

Write-Host "::set-output name=runners::$runners"