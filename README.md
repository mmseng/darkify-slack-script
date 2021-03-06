# darkify-slack-script

**Update: This no longer works as of Slack v4.0.0.** Other workarounds are available. Check https://www.reddit.com/r/Slack/

A PowerShell script to do the heavy lifting of modifying Slack files to hack in a custom theme. Only for the Slack desktop app for Windows. Makes it much less tedious to darkify Slack on multiple machines, or to re-darkify Slack after Slack updates and reverts your customizations.
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
The BAT file doesn't support using the parameters described below, but you could like... edit it and stuff.

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

## Notes
This script should work for new versions of Slack as it programmatically figures out where the current files to be modified are for the latest version. However if slack were to change the formatting of these files or otherwise break things that the original source repo relies on, this script will break too.

I have no intention of monitoring or updating this repo, especially because Slack has officially committed to bringing an official dark mode to Slack soon (https://9to5mac.com/2019/03/11/slack-dark-mode-available-ios-android/). Feel free to fork and/or modify it yourself.

## Disclaimer
I take no responsibility if you hose your system using this code. Use at your own risk.

## Credits and sources
The original Javascript and CSS code used to modify the Slack files was taken from https://github.com/Nockiro/slack-black-theme/, which appears to be a more updated fork of https://github.com/widget-/slack-black-theme/

The CSS code is still hosted on the Nockiro repo and is simply referenced in the JS code. The JS code and bits of CSS for customizing the theme were taken from the readme/instructions in that repo and rehosted here for use by the script, because they're not actually in hosted files on the source repo.
