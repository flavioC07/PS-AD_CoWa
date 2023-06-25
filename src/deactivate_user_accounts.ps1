#----------------------------------------------------------------------------------------------------------
# Author: Flavio Conte, Timon Wagner
# Funktion des Skripts: Deaktivierung von AD-Benutzerkonten
# Datum: 02.06.2023
# Version: 1.0
# Bemerkungen: Dieses Skript ermöglicht die Deaktivierung von Benutzerkonten in Active Directory.
#----------------------------------------------------------------------------------------------------------

# Importieren des Active Directory Moduls
Import-Module ActiveDirectory

# Funktion zum Deaktivieren des Kontos
function Disable-UserAccount {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Username
    )

    # Deaktivieren des Kontos
    try {
        Disable-ADAccount -Identity $Username
        Write-Host "Das Konto '$Username' wurde erfolgreich deaktiviert."
    }
    catch {
        Write-Host "Fehler beim Deaktivieren des Kontos '$Username'. $_" -ForegroundColor Red
    }
}

# Funktion zum Anzeigen des Hauptmenüs
function Show-MainMenu {
    Clear-Host
    Write-Host "============================================================"
    Write-Host "               Deaktivierung von AD-Benutzerkonten"
    Write-Host "============================================================"
    Write-Host "Hauptmenü"
    Write-Host "1. Alle Benutzerkonten deaktivieren"
    Write-Host "2. Einzelnes Benutzerkonto deaktivieren"
    Write-Host "Q. Beenden"
    Write-Host "============================================================"
    Write-Host
}

# Funktion zum Ausführen der ausgewählten Option
function Execute-Option {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Option
    )

    switch ($Option) {
        '1' {
            $confirm = Read-Host "Sind Sie sicher, dass Sie ALLE Benutzerkonten deaktivieren möchten? (J/N)"
            if ($confirm -eq "J") {
                $allUsers = Get-ADUser -Filter * | Select-Object -ExpandProperty SamAccountName
                $allUsers | ForEach-Object {
                    Disable-UserAccount -Username $_
                }
            }
            else {
                Write-Host "Deaktivierung aller Benutzerkonten abgebrochen."
            }
        }
        '2' {
            $username = Read-Host "Geben Sie den Benutzernamen ein"
            Disable-UserAccount -Username $username
        }
        'Q' {
            Write-Host "Zurück zum Hauptmenü"
        }
        default {
            Write-Host "Ungültige Option"
        }
    }

    Write-Host "Drücken Sie eine beliebige Taste, um fortzufahren..."
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyUp')
}

# Hauptprogramm
do {
    Show-MainMenu
    $option = Read-Host "Geben Sie die Option ein"

    Execute-Option -Option $option

    Write-Host "Drücken Sie eine beliebige Taste, um fortzufahren..."
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyUp')
} while ($option -ne 'Q')
