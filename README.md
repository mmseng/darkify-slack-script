# darkify-slack-script
A PowerShell script to do the heavy lifting of modifying Slack files to hack in a custom theme.
Uses code from existing repo: https://github.com/Nockiro/slack-black-theme/

## Instructions:
1) Download darkify-slack-script.ps1
2) Run it.
3) Grats, you're done.

## Running the script:
Most likely PowerShell script execution is disabled on your system. Get around that temporarily by downloading darkify-slack-script.bat to the same directory where you downloaded darkify-slack-script.ps1, and running the BAT file instead. Or just run darkify-slack-script.ps1 using the following syntax:
```
cd c:\dir-where-script-is
powershell -executionpolicy bypass -file ".\darkify-slack-script.ps1"
```
## Script options
There's a couple parameters you can pass to the script.

### -theme
You can use the `-theme` parameter to choose one of the themes originally provided by the repos that host the source CSS.
```
.\darkify-slack-script.ps1 -theme "one-dark"
```
Theme options:
- "default"
- "one-dark"
- "low-contrast"
- "navy"
- "hot-dog-stand"

Using any other values will probably throw an error. These themes just pull from the .txt files in this repo. You can easily customize the color values on your own. See the source repo linked above for more details.

### -revert
The script makes a backup of the two files it modifies. If you've run the script successfully once, then you can revert the changes.
```
.\darkify-slack-script.ps1 -revert
```

### -debug
Pass this switch parameter to see some debug output
```
.\darkify-slack-script.ps1 -debug
```
