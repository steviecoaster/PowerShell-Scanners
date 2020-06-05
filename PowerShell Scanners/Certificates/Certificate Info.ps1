<#
    .SYNOPSIS
    Returns certificates from given location
    
    .DESCRIPTION
    Returns all certificates from specified scope and store
    
    .PARAMETER Scope
    Look for CurrentUser or LocalMachine scoped certificates
    
    .PARAMETER Store
    The store to search for certificates

    .PARAMETER AllProperties
    Returns all properties of a certificate
    
    .EXAMPLE
    Get-CertificateFromProvider -Scope CurrentUser -Store My

    .EXAMPLE
    Get-CertificateFromProvider -Scope LocalMachine -Store TrustedPeople
    
    .NOTES
    Requires PowerShell Version 3.0 or higher
    #>
    [cmdletBinding()]
    param(
        [Parameter(Mandatory=$true,Position=0)]
        [ValidateSet('CurrentUser','LocalMachine')]
        [String]
        $Scope,

        [parameter(Mandatory=$true,Position=1)]
        [ArgumentCompleter(
            {
                param($Command,$Parameter,$WordToComplete,$CommandAst,$FakeBoundParams)
                $r = (Get-ChildItem Cert:\CurrentUser).Name | Sort-Object
                

                If($WordToComplete){
                   @($r) -match "^$WordToComplete"
                }

                Else {
                    $r
                }
            }
        )]
        [String]
        $Store,

        [parameter(Position=2)]
        [switch]
        $AllProperties
    )

    process {

        if($PSVersionTable.PSVersion.Major -lt 3){
            throw "Requires PowerShell 3.0 or higher"
        }

        if(!$AllProperties){
        Get-ChildItem "Cert:\$($Scope)\$($Store)" | Select-object Thumbprint,Subject,DnsNameList,Issuer,SerialNumber,NotAfter,NotBefore
        } else {
            Get-ChildItem "Cert:\$($Scope)\$($Store)" | Select-object *
        }
    }