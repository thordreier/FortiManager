function Invoke-FortiManagerRequest
{
    <#
        .SYNOPSIS
            Invoke API request against FortiManager

        .DESCRIPTION
            Invoke API request against FortiManager

        .PARAMETER Uri
            xxx

        .PARAMETER Method
            xxx

        .PARAMETER Data
            xxx

        .PARAMETER FullResponse
            xxx

        .PARAMETER IgnoreOk
            xxx

        .PARAMETER Session
            xxx

        .EXAMPLE
            Invoke-FortiManagerRequest -Uri fortimanager.domain.tld
    #>

    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [string]
        $Uri,

        [Parameter()]
        [string]
        $Method = 'get',

        [Parameter()]
        [object]
        $Data,

        [Parameter()]
        [switch]
        $FullResponse,

        [Parameter()]
        [switch]
        $IgnoreOk,

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

        if (-not ($s = $script:SessionList[$Session]))
        {
            throw "Session <$Session> not found, please use Connect-FortiManager first"
        }

        $body = @{
            method = $Method
            params = @(
                @{
                    url = $Uri
                }
            )
        }

        if ($Data)
        {
            $body['params'][0]['data'] = $Data
        }

        if ($s['Token'])
        {
            $body['session'] = $s['Token']
        }

        $restSplat = @{
            Uri         = $s['Uri']
            Method      = 'Post'
            Body        = $body | ConvertTo-Json -Depth 20 -Compress
            ContentType = 'application/json'
        }

        try
        {
            $response = Invoke-RestMethod @restSplat
            if ($response.result[0].status.message -eq 'OK' -or $IgnoreOk)
            {
                # Return
                if ($FullResponse)
                {
                    $response
                }
                else
                {
                    $response.result[0].data
                }
            }
            else
            {
                $response | ConvertTo-Json -Depth 9 | Write-Verbose
                throw ('Error occurred getting data from FortiManager: Code {0}, {1}' -f $response.result[0].status.code, $response.result[0].status.message)
            }
        }
        catch
        {
            throw $_
        }

        # Non-boilerplate stuff ends here
    }
    catch
    {
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
