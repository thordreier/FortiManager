function Connect-FortiManager
{
    <#
        .SYNOPSIS
            Connect to FortiManager

        .DESCRIPTION
            Connect to FortiManager

        .PARAMETER Uri
            xxx

        .PARAMETER Credential
            xxx

            xxx

        .PARAMETER Username
            xxx

        .PARAMETER Password
            xxx

        .PARAMETER Session
            xxx

        .EXAMPLE
            xxx
    #>

    [CmdletBinding(DefaultParameterSetName='Default')]
    [OutputType([PSCustomObject])]
    param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string]
        $Uri,

        [Parameter(ParameterSetName='Credential', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
        [pscredential]
        $Credential,

        [Parameter(ParameterSetName='UserPass', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
        [string]
        $Username,

        [Parameter(ParameterSetName='UserPass', Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
        [string]
        $Password,

        [Parameter()]
        [string]
        $Session = 'Default'
    )

    Write-Verbose -Message "Begin (ErrorActionPreference: $ErrorActionPreference)"
    $origErrorActionPreference = $ErrorActionPreference
    $origErrorActionPreferenceGlobal = $global:ErrorActionPreference

    try
    {
        # Stop and catch all errors. Local ErrorAction isn't propagate when calling functions in other modules
        $global:ErrorActionPreference = $ErrorActionPreference = 'Stop'

        # Non-boilerplate stuff starts here

        # FIXXXME - should this be moved out - so it is run when module is imported?
        if (-not $script:SessionList)
        {
            Write-Verbose -Message 'Creating session list'
            $script:SessionList = @{}
        }

        if ($Uri -notmatch ':') {$Uri = "https://${Uri}"}
        $Uri = $Uri -replace '/$'

        if (-not ($Credential -or $Username -or $Password))
        {
            $Credential = Get-Credential -Message 'FortiManager'
        }

        if ($Credential)
        {
            $Username = $Credential.UserName
            $Password = $Credential.GetNetworkCredential().Password
        }

        $script:SessionList[$Session] = @{
            Uri     = "$Uri/jsonrpc"
        }

        $data = @{
            user   = $Username
            passwd = $Password
        }

        Write-Verbose -Message "Connecting to FortiManager API at <$($Uri)> with username <$($Username)>"
        $response = Invoke-FortiManagerRequest -Uri /sys/login/user -Method exec -Data $data -FullResponse -Session $Session
        $script:SessionList[$Session]['Token'] = $response.session

        # Non-boilerplate stuff ends here
    }
    catch
    {
        $null = $script:SessionList.Remove($Session)

        # If error was encountered inside this function then stop processing
        # But still respect the ErrorAction that comes when calling this function
        # And also return the line number where the original error occured
        $msg = $_.ToString() + "`r`n" + $_.InvocationInfo.PositionMessage.ToString()
        Write-Verbose -Message "Encountered an error: $msg"
        Write-Error -ErrorAction $origErrorActionPreference -Exception $_.Exception -Message $msg
    }
    finally
    {
        # Clean up ErrorAction
        $global:ErrorActionPreference = $origErrorActionPreferenceGlobal
    }

    Write-Verbose -Message 'End'
}
