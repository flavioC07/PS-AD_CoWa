#----------------------------------------------------------------------------------------------------------
# Autor: Timon Wagner
# Funktion des Skripts: Konfigurationen, z.B. Pfade bereitstellen, Namen der OU's benennen
# Datum: 02.06.2023
# Version: 1.0
# Bemerkungen:
#----------------------------------------------------------------------------------------------------------
$config = @{
    SchuelerCsv  = "C:\tmp\PSProjekt\schueler.csv"
    InitPw       = "bztf.001"
    OUPath       = "OU=BZTF,DC=bztf,DC=local"
    OULernende   = "Lernende"
    OUKlasse     = "Klassengruppen"
    LogFileUser  = "C:\tmp\users.log"
    LogFileGroup = "C:\tmp\groups.log"
    ClassFolder  = "C:\BZTF\Klassen"
}