Param(
        [Parameter(Mandatory = $true,      Position = 0,  HelpMessage = 'Name of your machine')]
        [String]$ComputerName,
        [Parameter(Mandatory = $true,      Position = 1,  HelpMessage = 'Name of your service')]
        [String]$ServiceName
)

$service = Get-Service -Name $ServiceName  -ComputerName $ComputerName

if($service)
{
    Write-Host 'Status of' $ServiceName 'for machine ' $ComputerName 'is' $service.Status

    if($service.Status -eq 'Running')
    {
      Write-Host 'Is already running'
    }
    else
    {

        Write-Host 'Starting service...'
        $service.Start()
        Start-Sleep -s 2
        $service = Get-Service -Name $ServiceName  -ComputerName $ComputerName
        Write-Host $service.Status 'is now' $service.Status
    }
}
else
{
    Write-Host 'The service doesnt exist in this machine'
}