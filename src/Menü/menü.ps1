#----------------------------------------------------------------------------------------------------------
# Author: Flavio Conte, Timon Wagner
# Funktion des Skripts: Menügeführte Funktionen ausführen
# Datum: 02.06.2023
# Version: 1.3
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
    Write-Host "2. Erstellen & Löschen der AD-Gruppen für alle Klassen"
    Write-Host "3. Zuweisung der Klassen zu den Benutzern"
    Write-Host "4. Benutzerkonten löschen"
    Write-Host "5. Benutzerkonten deaktivieren"
    Write-Host "6. Benutzerverwaltung"
    Write-Host "7. Benutzerübersicht"
    Write-Host "8. XML zu einem CSV konvertieren"
    Write-Host "9. Benutzerinformationen loggen"
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
            Write-Host "Führe Erstellen der AD-Accounts für alle Lernenden aus"
            . 'C:\github\PS-AD_CoWa\src\AD_Klassen&Benutzer\create_user_accounts.ps1'
        }
        '2' {
            Write-Host "Führe Erstellen & Löschen der AD-Gruppen für alle Klassen aus"
            . 'C:\github\PS-AD_CoWa\src\AD_Klassen&Benutzer\create_class_groups.ps1'
        }
        '3' {
            Write-Host "Führe Zuweisung der Klassen zu den Benutzern aus"
            . 'C:\github\PS-AD_CoWa\src\AD_Klassen&Benutzer\assign_groups.ps1'
        }
        '4' {
            Write-Host "Führe Benutzerkonten löschen aus"
            . 'C:\github\PS-AD_CoWa\src\AD_Klassen&Benutzer\delete_user_accounts.ps1'
        }
        '5' {
            Write-Host "Führe Benutzerkonten deaktivieren aus"
            . 'C:\github\PS-AD_CoWa\src\AD_Klassen&Benutzer\deactivate_user_accounts.ps1'
        }
        '6' {
            Write-Host "Führe Benutzerverwaltung aus"
            . 'C:\github\PS-AD_CoWa\src\AD_Klassen&Benutzer\manage_user.ps1'
        }
        '7' {
            Write-Host "Führe Benutzerübersicht aus"
            . 'C:\github\PS-AD_CoWa\src\Log_Infos\user_overview.ps1'
        }
        '8' {
            Write-Host "XML zu einem CSV konvertieren"
            . 'C:\github\PS-AD_CoWa\src\XMLtoCSV\xml_to_csv.ps1'
        }
        '9' {
            Write-Host "Führe Benutzerinformationen loggen aus"
            . 'C:\github\PS-AD_CoWa\src\Log_Infos\log_user_info.ps1'
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
    $option = Read-Host -Prompt "Wählen Sie eine Option aus dem Menü (1-9, Q zum Beenden):"

    Execute-Option -Option $option
    if ($option -eq 'Q') {
        break
    }
}
