# FortiManager

Text in this document is automatically created - don't change it manually

## Index

[Connect-FortiManager](#Connect-FortiManager)<br>
[Invoke-FortiManagerRequest](#Invoke-FortiManagerRequest)<br>

## Functions

<a name="Connect-FortiManager"></a>
### Connect-FortiManager

```

NAME
    Connect-FortiManager
    
SYNOPSIS
    Connect to FortiManager
    
    
SYNTAX
    Connect-FortiManager [-Uri] <String> [-Session <String>] [<CommonParameters>]
    
    Connect-FortiManager [-Uri] <String> -Credential <PSCredential> [-Session <String>] [<CommonParameters>]
    
    Connect-FortiManager [-Uri] <String> -Username <String> -Password <String> [-Session <String>] [<CommonParameters>]
    
    
DESCRIPTION
    Connect to FortiManager
    

PARAMETERS
    -Uri <String>
        xxx
        
    -Credential <PSCredential>
        xxx
        
        xxx
        
    -Username <String>
        xxx
        
    -Password <String>
        xxx
        
    -Session <String>
        xxx
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see 
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216). 
    
    -------------------------- EXAMPLE 1 --------------------------
    
    PS C:\>xxx
    
    
    
    
    
    
REMARKS
    To see the examples, type: "get-help Connect-FortiManager -examples".
    For more information, type: "get-help Connect-FortiManager -detailed".
    For technical information, type: "get-help Connect-FortiManager -full".

```

<a name="Invoke-FortiManagerRequest"></a>
### Invoke-FortiManagerRequest

```
NAME
    Invoke-FortiManagerRequest
    
SYNOPSIS
    Invoke API request against FortiManager
    
    
SYNTAX
    Invoke-FortiManagerRequest [-Uri] <String> [[-Method] <String>] [[-Data] <Object>] [-FullResponse] [-IgnoreOk] [[-Session] <String>] [<CommonParameters>]
    
    
DESCRIPTION
    Invoke API request against FortiManager
    

PARAMETERS
    -Uri <String>
        xxx
        
    -Method <String>
        xxx
        
    -Data <Object>
        xxx
        
    -FullResponse [<SwitchParameter>]
        xxx
        
    -IgnoreOk [<SwitchParameter>]
        xxx
        
    -Session <String>
        xxx
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see 
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216). 
    
    -------------------------- EXAMPLE 1 --------------------------
    
    PS C:\>Invoke-FortiManagerRequest -Uri fortimanager.domain.tld
    
    
    
    
    
    
REMARKS
    To see the examples, type: "get-help Invoke-FortiManagerRequest -examples".
    For more information, type: "get-help Invoke-FortiManagerRequest -detailed".
    For technical information, type: "get-help Invoke-FortiManagerRequest -full".

```



