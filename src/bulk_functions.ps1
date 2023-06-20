#----------------------------------------------------------------------------------------------------------
# Author: Flavio Conte, Timon Wagner
# Funktion des Skripts: Bulk-Funktionen zum Aktualisieren mehrerer AD-Benutzer
# Datum: 02.06.2023
# Version: 1.0
# Bemerkungen: Dieses Skript bietet effiziente und zuverlässige Funktionen zum Massenupdate von AD-Benutzern.
# Es ermöglicht das Aktualisieren verschiedener Eigenschaften für eine beliebige Anzahl von Benutzern.
#----------------------------------------------------------------------------------------------------------

# Funktion zum Aktualisieren mehrerer AD-Benutzer
function Update-MultipleADUsers {
    Param(
        [Parameter(Mandatory=$true)]
        [string[]]$Usernames,

        [Parameter(Mandatory=$true)]
        [string]$Property,

        [Parameter(Mandatory=$true)]
        [string]$Value
    )

    foreach ($username in $Usernames) {
        $user = Get-ADUser -Identity $username

        if ($user) {
            Set-ADUser -Identity $user.DistinguishedName -Replace @{ $Property = $Value }

            Write-Host "Die Eigenschaft '$Property' für den Benutzer '$username' wurde erfolgreich auf '$Value' aktualisiert."
        } else {
            Write-Host "Fehler: Der Benutzer '$username' wurde nicht gefunden."
        }
    }
}


