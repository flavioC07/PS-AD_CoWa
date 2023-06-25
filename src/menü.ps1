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
    Write-Host "1. Erstellen der AD-Accounts für alle Lernenden"
    Write-Host "2. Gruppenverwaltung"
    Write-Host "3. Protokollierung der Benutzerinformationen"
    Write-Host "4. Benutzerübersicht"
    Write-Host "5. Benutzerverwaltung"
    Write-Host "6. Benutzerkonten deaktivieren"
    Write-Host "7. Benutzerkonten löschen"
    Write-Host "8. Klassenverwaltung"
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
            Write-Host "Führe Erstellen/Deaktivieren der AD-Accounts für alle Lernenden aus"
            . 'C:\github\PS-AD_CoWa\src\create_user_accounts.ps1'
        }
        '2' {
            Write-Host "Führe Gruppenverwaltung aus"
            . 'C:\github\PS-AD_CoWa\src\manage_group.ps1'
        }
        '3' {
            Write-Host "Führe Protokollierung der Benutzerinformationen aus"
            . 'C:\github\PS-AD_CoWa\src\log_user_info.ps1'
        }
        '4' {
            Write-Host "Führe Benutzerübersicht aus"
            . 'C:\github\PS-AD_CoWa\src\user_overview.ps1'
        }
        '5' {
            Write-Host "Führe Benutzerverwaltung aus"
            . 'C:\github\PS-AD_CoWa\src\manage_user.ps1'
        }
        '6' {
            Write-Host "Führe Benutzerkonten deaktivieren aus"
            . 'C:\github\PS-AD_CoWa\src\deactivate_user_accounts.ps1'
        }
        '7' {
            Write-Host "Führe Benutzerkonten löschen aus"
            $deleteOption = Read-Host "Möchten Sie alle Benutzer löschen (A) oder einen bestimmten Benutzer (B)?" -Prompt

            switch ($deleteOption) {
                'A' {
                    Write-Host "Lösche alle Benutzer"
                    # Code zum Löschen aller Benutzer hier
                }
                'B' {
                    $username = Read-Host "Geben Sie den Benutzernamen (Vorname_Nachname) des zu löschenden Benutzers ein:" -Prompt
                    Write-Host "Lösche Benutzer '$username'"
                    # Code zum Löschen des spezifischen Benutzers hier
                }
                default {
                    Write-Host "Ungültige Option. Kein Benutzer wird gelöscht."
                }
            }
        }
        '8' {
            Write-Host "Führe Klassenzuweisung aus"
            . 'C:\github\PS-AD_CoWa\src\assign_groups.ps1'
        }
        'Q' {
            Write-Host "Das Skript wird beendet."
            return
        }
        default {
            Write-Host "Ungültige Option. Bitte wählen Sie eine gültige Option aus."
        }
    }
}

# Hauptmenü aufrufen
while ($true) {
    Show-MainMenu
    $option = Read-Host "Wählen Sie eine Option aus dem Menü (1-8, Q zum Beenden):" -Prompt
    Execute-Option -Option $option
    if ($option -eq 'Q') {
        break
    }
}
