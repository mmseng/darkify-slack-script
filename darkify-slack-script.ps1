# Source repo for this script
#https://github.com/mmseng/darkify-slack-script

# Original(?) source repo for the Slack file customizations and theme CSS
# https://github.com/widget-/slack-black-theme/issues/89

# Original(?) source hasn't been updated recently and has issues with theming threads
# https://github.com/widget-/slack-black-theme/issues/89

# More updated fork
# https://github.com/Nockiro/slack-black-theme/

# Officially coming to desktop soon
#https://9to5mac.com/2019/03/11/slack-dark-mode-available-ios-android/

# but I can't wait, so here goes...

# Params
param(
	[switch]$revert,
	[string]$theme = "default",
	[switch]$debug
)

# Turn debug output on or off
function debug($msg) {
	if($debug) {
		write-host $msg
	}
}

# Get the latest app version directory name
function getVerString($baseDir) {
	$latestVer = 'unknown'
	
	# Get list of directories in $baseDir
	$dirs = get-childitem -path $baseDir -directory
	
	# Capture only directories which match "app-#.#.#"
	$vers = @()
	$regex = 'app\-(\d\.\d\.\d)'
	foreach($dir in $dirs) {
		debug $dir
		if($dir -match $regex) {
			$vers += [Version]$matches[1]
		}
	}	
	debug $vers
	
	# Fake list of version for testing
	#$vers = @("1.1.1", "3.5.7", "3.7.5", "4.5.1", "0.4")
	
	# Get latest version
	$latestVer = $vers[0]
	foreach($ver in $vers) {
		if($ver -ge $latestVer) {
			$latestVer = $ver
		}
	}	
	debug $latestVer
	
	return 'app-' + $latestVer
}

# Build path to files to be edited
$homepath = $env:homepath
$baseDir = 'c:' + $homepath + '\AppData\Local\slack'
$ver = getVerString $baseDir
$fileDir = 'resources\app.asar.unpacked\src\static'
$dir = $baseDir + '\' + $ver + '\' + $fileDir
debug $dir

# List of files to be edited
$files = @(
	"index.js",
	"ssb-interop.js"
)
debug $files

$filePaths = @()
foreach($file in $files) {
	$filePaths += $dir + '\' + $file
}
debug $filePaths

if($revert) {
	# Copy backups back to original files
	foreach($file in $files) {
		$filePath = $dir + '\' + $file
		$backupFilePath = $dir + '\' + $file + '-bak'
		if(test-path $backupFilePath -pathtype leaf) {
			copy-item $backupFilePath -destination $filePath
		}
	}
}
else {
	# Backup files to be edited
	foreach($file in $files) {
		$filePath = $dir + '\' + $file
		$backupFilePath = $dir + '\' + $file + '-bak'
		copy-item $filePath -destination $backupFilePath
	}
	
	# Get theme string
	$repoURL = "https://raw.githubusercontent.com/mmseng/darkify-slack-script/master/"
	$themeURL = $repoURL + "theme-$theme.txt"
	$themeString = wget $themeURL
	debug $themeString
	
	# Get JS code
	$jsURL = $repoURL + "code-to-inject.js"
	$js = wget $jsURL
	debug $js
	
	# Replace theme string in js with chosen theme string
	$regex = '( {6}\-\-primary(.*\s){5})'
	$jsNew = $js -replace $regex,$themeString
	debug $jsNew

	# Modify files
	foreach($file in $files) {
		$filePath = $dir + '\' + $file
		add-content -path $filePath -value $jsNew
	}
}









