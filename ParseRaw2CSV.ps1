param ([Parameter(Mandatory=$true)][string]$file)

[System.IO.StreamReader]$sr = [System.IO.File]::Open("$PSScriptRoot\$file", [System.IO.FileMode]::Open)
while (-not $sr.EndOfStream){
    
    $line = $sr.ReadLine()
   
    if (($line.Length -ge "Report: ".Length) -and ($line.Substring(0, "Report: ".Length) -eq "Report: "))  # New item
    {
        $line = $line.Substring($line.IndexOf(":") + 2);  # Remove "Report: "

        # Reporting agency and its ID #
        $RptAgency = $line.Substring($line.IndexOf("/") + 1);
        $RptAgencyCrashID = $line.Substring(0, $line.IndexOf("/"));

        # Advance 2 lines, skipping over the injury level icon's alt text
        $line = $sr.ReadLine()
        $line = $sr.ReadLine()

        # Lines 3-4: Injury level
        # Probably should have some error checking here to make sure we really are where we think we are, the "Injury Level" line
        $line = $sr.ReadLine()  # For now, just assume it and read next line
        $InjuryLevel = $line;
        $line = $sr.ReadLine()
        
        # Lines 5-6: Date and time (maybe reformat this to a more universal format, say "yyyy-mm-dd hh24:mi:ss"?)
        $line = $sr.ReadLine()
        $DateTime = $line;
        $line = $sr.ReadLine()
        
        # Lines 7-9: Location (concatonate two lines of data using comma)
        $line = $sr.ReadLine()
        $Location = $line
        $line = $sr.ReadLine()
        $Location = $Location + ", " + $line
        $line = $sr.ReadLine()

        # Lines 10-11: Type of crash
        $line = $sr.ReadLine()
        $CrashType = $line;
        $line = $sr.ReadLine()
        
        # Lines 12-13: Maine DOT Crash ID
        $line = $sr.ReadLine()
        $MeDOTCrashID = $line;
        $line = $sr.ReadLine()
        
        Echo "$RptAgency`t$RptAgencyCrashID`t$MeDOTCrashID`t$DateTime`t$Location`t$CrashType`t$InjuryLevel"
        #Echo $line
    }
}
$sr.Close()
