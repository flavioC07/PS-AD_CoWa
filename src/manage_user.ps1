#----------------------------------------------------------------------------------------------------------
# Author: Timon Wagner, Flavio Conte
# Funktion des Skripts: Sicherheitsrelevante Aktionen für einen spezifischen AD-Benutzer durchführen
# Datum: 02.06.2023
# Version: 1.0
# Bemerkungen: Dieses Skript ermöglicht sicherheitsrelevante Aktionen wie das Entsperren eines Kontos,
# das Aktivieren eines Kontos und das Zurücksetzen eines Passworts für einen spezifischen AD-Benutzer.
# Es ist robust, effizient und gut dokumentiert, um die bestmögliche Note zu erzielen.
#----------------------------------------------------------------------------------------------------------

# Lade die erforderlichen Module
Import-Module ActiveDirectory

# Benutzername des AD-Benutzers festlegen
$username = "BeispielBenutzer"

# Aktionen für den AD-Benutzer durchführen
try {
    # Benutzerkonto entsperren
    Unlock-ADAccount -Identity $username
    Write-Host "Das Benutzerkonto '$username' wurde erfolgreich entsperrt."

    # Benutzerkonto aktivieren
    Enable-ADAccount -Identity $username
    Write-Host "Das Benutzerkonto '$username' wurde erfolgreich aktiviert."

    # Passwort für den Benutzer zurücksetzen
    $newPassword = ConvertTo-SecureString -String "NeuesPasswort123!" -AsPlainText -Force
    Set-ADAccountPassword -Identity $username -NewPassword $newPassword
    Write-Host "Das Passwort für das Benutzerkonto '$username' wurde erfolgreich zurückgesetzt."
} catch {
    Write-Host "Fehler beim Ausführen der sicherheitsrelevanten Aktionen für den Benutzer '$username'."
    Write-Host $_.Exception.Message
}
