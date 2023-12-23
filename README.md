# MeDOTCrashData
A tool (and possibly more in the future) to work with the Maine DOT crash data available online.

## Parsing screen scraped data

The [Maine DOT crash data query tool](https://mdotapps.maine.gov/MaineCrashPublic/Home) provides crash data from 2003 to the present in two ways: As a set of configurable graphs, and as points on a map. While the interface is fairly friendly, there is no way to actually download the dataset directly for import into other reporting tools.

To overcome this limitation, I followed a two-step process:
1. Using the map interface, copied/pasted the text of each data point into a text file, then
2. Wrote and used the PowerShell script [ParseRaw2CSV.ps1](https://github.com/JohnBrooking/MeDOTCrashData/blob/main/ParseRaw2CSV.ps1) to convert the text file to a CSV file.

### Input format

Each screen-scraped item in the raw text file looks like this:
>
>Report: 23-014402/PORTLAND POLICE DEPARTMENT  
>Property Damage Only  
>Injury Level  
>Property Damage Only  
>Date/Time  
>3/24/2023  4:46 PM  
>Location  
>PARK AV  
>Int of PARK AV ST JOHN ST, PORTLAND  
>Type Of Crash  
>Rear End / Sideswipe  
>MDOT ID  
>2023-9370
>

Leave at last one blank line between each item.

### Output format

The output file is a tab-separated "CSV" file (kind of a misnomer, since it uses tabs instead of commas, but okay), where each item is on one line, in the following column order:

| Reporting Agency | Rpt Agency Crash ID | MEDOT Crash ID | Date/Item | Location | Crash Type | Injury Level |
| --- | --- | --- | --- | --- | --- | --- |
| PORTLAND POLICE DEPARTMENT | 23-014402 | 2023-9370 | 3/24/2023  4:46 PM | PARK AV, Int of PARK AV ST JOHN ST, PORTLAND | Rear End / Sideswipe | Property Damage Only |

Note that the column header names are not actually part of the conversion script output, but the [Header.csv](https://github.com/JohnBrooking/MeDOTCrashData/blob/main/Data/Headers.csv) file in this repository provides them, so they can be copied to the top of a spreadsheet or wherever they are needed.

### Script invocation

Run the [ParseRaw2CSV.ps1](https://github.com/JohnBrooking/MeDOTCrashData/blob/main/ParseRaw2CSV.ps1) script on a Windows Powershell command line, as follows:

`.\ParseRaw2CSV.ps1 -file "YourFile.txt"`

Put the input file in the script directory, and specify only the file name, not the path. The script automatically looks for the file in the same directory as the script itself.

Note also that you will probably need to run the script as administrator.

---
_Last modified 12/23/2023_
