# -------------------------------------------------------------
# Author: Flavio Conte, Timon Wagner
# Datum: 18.06.2022
# Version: 1.0
# Funktionsbeschreibung: XML zu CSV konvertieren
# Parameter: -
# Bemerkungen:
# -------------------------------------------------------------




$xmlFile = "C:\github\PS-AD_CoWa\Data\schueler.xml"
$csvFile = "C:\github\PS-AD_CoWa\Data\schueler.csv"

function xmlToCsv {
    # XML auslesen
    [xml] $SchuelerXML = Get-Content -Path $xmlFile
   

    # CSV-Headers hinzufuegen
    $headers = $SchuelerXML.Objs.Obj.MS.S.N.GetValue(0) -replace '\.', '_'
    $SchuelerXML.Objs.Obj.MS.S.N.GetValue(0) | Out-File -Encoding utf8 -FilePath $csvFile
   

    # anzahl zeilen zählen (default = 0)
    $total  = 0
    foreach ($line in $SchuelerXML.Objs.Obj.MS.S.InnerXML) {
        $total += 1
    }

    # momentane zeile (default = 1)
    $current = 1
    # Liste in die CSV-Datei schreiben
    # Hinweis: XML hat bereits ein CSV Format
    foreach ($line in $SchuelerXML.Objs.Obj.MS.S.InnerXML) {
        # in jeder Linie, Umlaute ersetzen
        $line = $line -ireplace 'ä', 'ae' -ireplace 'ö', 'oe' -ireplace 'ü', 'ue' -ireplace 'è', 'e' -ireplace 'é', 'e' -replace '\.', '_'
        # Jede Linie der Datei hinzufuegen
        $line | Out-File -Encoding utf8 -FilePath $csvFile -Append
        
        # momentane zeile
        $current += 1
    }
    
}

# CSV-Datei erstellen
xmlToCsv