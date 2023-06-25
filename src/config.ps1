#----------------------------------------------------------------------------------------------------------
# Author: Flavio Conte, Timon Wagner
# Funktion des Skripts: Konfigurationseinstellungen für das AD-Projekt bereitstellen
# Datum: 10.06.2023
# Version: 1.6
# Bemerkungen: Dieses Config-File enthält verschiedene Konfigurationseinstellungen wie Pfade, Namen von 
# Organisationseinheiten (OUs) und andere benutzerdefinierte Einstellungen.
#----------------------------------------------------------------------------------------------------------

# Konfigurationsdatei für Menüskript

# Pfade zu den einzelnen Skripten

$createUserAccountsScript = "C:\github\PS-AD_CoWa\src\create_user_accounts.ps1"
$manageGroupScript = "C:\github\PS-AD_CoWa\src\manage_group.ps1"
$logUserInfoScript = "C:\github\PS-AD_CoWa\src\log_user_info.ps1"
$userOverviewScript = "C:\github\PS-AD_CoWa\src\user_overview.ps1"
$manageUserScript = "C:\github\PS-AD_CoWa\src\manage_user.ps1"
$deactivateUserAccountsScript = "C:\github\PS-AD_CoWa\src\deactivate_user_accounts.ps1"
$deleteUserScript = "C:\github\PS-AD_CoWa\src\delete_user.ps1"
$assignClassScript = "C:\github\PS-AD_CoWa\src\manage_class.ps1"

# Exportiere die Skriptpfade in eine Hashtable

$scriptPaths = @{
    '1' = @{
        'Path' = $createUserAccountsScript
        'Description' = "Skript zum Erstellen der AD-Accounts für alle Lernenden"
    }
    '2' = @{
        'Path' = $manageGroupScript
        'Description' = "Skript zur Gruppenverwaltung"
    }
    '3' = @{
        'Path' = $logUserInfoScript
        'Description' = "Skript zur Protokollierung der Benutzerinformationen"
    }
    '4' = @{
        'Path' = $userOverviewScript
        'Description' = "Skript zur Anzeige einer detaillierten Übersicht über alle AD-Benutzer"
    }
    '5' = @{
        'Path' = $manageUserScript
        'Description' = "Skript zur Benutzerverwaltung"
    }
    '6' = @{
        'Path' = $deactivateUserAccountsScript
        'Description' = "Skript zum Deaktivieren von Benutzerkonten"
    }
    '7' = @{
        'Path' = $deleteUserScript
        'Description' = "Skript zum Löschen von Benutzerkonten"
    }
    '8' = @{
        'Path' = $assignClassScript
        'Description' = "Skript zur Klassenzuweisung"
    }
}

# Pfad zu den Logdateien
$logFilePath1 = "C:\github\PS-AD_CoWa\logfiles\statistik_user.log"
$logFilePath2 = "C:\github\PS-AD_CoWa\logfiles\taegliches_protokoll.log"
$logFilePath3 = "C:\github\PS-AD_CoWa\logfiles\user_overview.log"


