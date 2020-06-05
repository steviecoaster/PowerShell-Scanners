# Description

This scanner returns Certificates installed on a machine from specified location and store. Requires PowerShell v3 or higher.

## Parameters

```powershell
-Scope
```

Target either the CurrentUser or LocalMachine scope. Defaults to LocalMachine

```powershell
-Store
```

The specific store to retrieve certificates from. Defaults to TrustedPeople

```powershell
-AllProperties
```

Returns all properties of each certificate found

## Author

Stephen Valdinger
