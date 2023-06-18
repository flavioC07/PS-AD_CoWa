#----------------------------------------------------------------------------------------------------------
# Author: Timon Wagner, Flavio Conte
# Funktion des Skripts: Konfigurationseinstellungen für das AD-Projekt bereitstellen
# Datum: 10.06.2023
# Version: 1.6
# Bemerkungen: Dieses Config-File enthält verschiedene Konfigurationseinstellungen wie Pfade, Namen von 
# Organisationseinheiten (OUs) und andere benutzerdefinierte Einstellungen.
#----------------------------------------------------------------------------------------------------------

# Pfad zum XML-File für die Erstellung/Deaktivierung der AD-Accounts
$accountXMLFile = "C:\github\PS-AD_CoWa\Data\schueler.xml"

# Pfade zu den Logfiles
$logFilesPath = "C:\github\PS-AD_CoWa\logfiles"

# Name der Haupt-OU für die Lernenden
$studentsOUName = "Lernende"

# Name der Haupt-OU für die Klassen
$classesOUName = "Klassen"

# Name der Haupt-OU für die AD-Gruppen
$groupsOUName = "Gruppen"

# Prefix für die Benutzernamen der Lernenden
$studentUsernamePrefix = "Lernender"

# Prefix für die Benutzernamen der AD-Gruppen
$groupPrefix = "Gruppe"

# Maximale Länge des Benutzernamens
$maxUsernameLength = 20

# Maximale Anzahl von Anmeldeversuchen für ein Benutzerkonto
$maxLoginAttempts = 5

# Anzahl der Tage, nach denen ein Passwort abläuft
$passwordExpirationDays = 90

# Standard-Passwortrichtlinie
$passwordPolicy = "Buchstaben123!"

# Funktion zum Laden der Konfigurationseinstellungen
function Load-ConfigSettings {
    $configSettings = @{
        AccountXMLFile = $accountXMLFile
        LogFilesPath = $logFilesPath
        StudentsOUName = $studentsOUName
        ClassesOUName = $classesOUName
        GroupsOUName = $groupsOUName
        StudentUsernamePrefix = $studentUsernamePrefix
        GroupPrefix = $groupPrefix
        MaxUsernameLength = $maxUsernameLength
        MaxLoginAttempts = $maxLoginAttempts
        PasswordExpirationDays = $passwordExpirationDays
        PasswordPolicy = $passwordPolicy
    }
    return $configSettings
}

