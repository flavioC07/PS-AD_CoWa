#----------------------------------------------------------------------------------------------------------
# Author: Flavio Conte, Timon Wagner
# Funktion des Skripts: Menügeführte Funktionen ausführen
# Datum: 02.06.2023
# Version: 1.0
# Bemerkungen: Dieses Skript ermöglicht es, verschiedene Skripts auszuführen.
#----------------------------------------------------------------------------------------------------------

# Funktion zum Anzeigen des Hauptmenüs
function Show-MainMenu {
    Clear-Host
    Write-Host "============================================================"
    Write-Host "                  Unser Projekt Menü"
    Write-Host "============================================================"
    Write-Host "Hauptmenü"
    Write-Host "1. Bulk-Funktionen zum Aktualisieren mehrerer AD-Benutzer"
    Write-Host "2. Erstellen der AD-Accounts für alle Lernenden"
    Write-Host "3. Gruppenverwaltung"
    Write-Host "4. Protokollierung der Benutzerinformationen"
    Write-Host "5. Benutzerübersicht"
    Write-Host "6. Benutzerverwaltung"
    Write-Host "7. Benutzerkonten deaktivieren"
    Write-Host "8. Benutzerkonten löschen"
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
            Write-Host "Führe Bulk-Funktionen zum Aktualisieren mehrerer AD-Benutzer aus"
            . 'C:\github\PS-AD_CoWa\src\bulk_functions.ps1'
        }
        '2' {
            Write-Host "Führe Erstellen/Deaktivieren der AD-Accounts für alle Lernenden aus"
            . 'C:\github\PS-AD_CoWa\src\create_user_accounts.ps1'
        }
        '3' {
            Write-Host "Führe Gruppenverwaltung aus"
            . 'C:\github\PS-AD_CoWa\src\manage_group.ps1'
        }
        '4' {
            Write-Host "Führe Protokollierung der Benutzerinformationen aus"
            . 'C:\github\PS-AD_CoWa\src\log_user_info.ps1'
        }
        '5' {
            Write-Host "Führe Benutzerübersicht aus"
            . 'C:\github\PS-AD_CoWa\src\user_overview.ps1'
        }
        '6' {
            Write-Host "Führe Benutzerverwaltung aus"
            . 'C:\github\PS-AD_CoWa\src\manage_user.ps1'
        }
        '7' {
            Write-Host "Führe Benutzerkonten deaktivieren aus"
            . 'C:\github\PS-AD_CoWa\src\deactivate_user_accounts.ps1'
        }
        '8' {
            Write-Host "Führe Benutzerkonten löschen aus"
            . 'C:\github\PS-AD_CoWa\src\delete_user_accounts.ps1'
        }
        'Q' {
            Write-Host "Beende das Skript"
            return
        }
        default {
            Write-Host "Ungültige Option"
        }
    }
}

# Hauptprogramm
do {
    Show-MainMenu
    $option = Read-Host "Geben Sie die Option ein"

    Execute-Option -Option $option

    Write-Host "Drücken Sie eine beliebige Taste, um fortzufahren..."
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyUp')
} while ($option -ne 'Q')
