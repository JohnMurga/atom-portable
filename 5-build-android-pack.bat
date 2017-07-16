@echo off
REM Copyright 2014-2017 John de Murga - Licensed under the GPLv2

echo ----------------------------
echo Downloading Android packages
echo ----------------------------

set WGET=cscript /nologo tools\wget.js

IF NOT EXIST ".\\downloads\\android.zip" (
    %WGET% "http://dl.google.com/android/repository/sdk-tools-windows-3859397.zip" ".\\downloads\\android.zip"
) else (
    echo Android download already present
)

set JAVA_HOME=%~dp0\packages\java
set PATH=%PATH%;%JAVA_HOME%\bin;%JAVA_HOME%\jre\bin

where /q java
IF ERRORLEVEL 1 (
    ECHO ERROR - Please run the Java pack creation script before this one
    EXIT /B
)

echo ------------------------
echo Extracting Android tools
echo ------------------------

rmdir /S /Q .\packages\android 2> nul
mkdir .\packages\android

set UN7ZIP=%~dp0\tools\7Zip\7z.exe x -y

%UN7ZIP% %~dp0\downloads\android.zip -o.\packages\android > nul

echo ----------------------
echo Installing Android SDK
echo ----------------------

set ANDROID_HOME=%~dp0\packages\android
set ANDROID_SDK_HOME=%~dp0\packages\android

mkdir %ANDROID_HOME%\licenses
<nul set /p =8933bad161af4178b1185d1a37fbf41ea5269c55> %ANDROID_HOME%\licenses\android-sdk-license

:: Why don't "cmd /k" or "start /w /b" work ?
start "Installing Android SDK, will close when done ..." /W cmd /c "%ANDROID_HOME%\tools\bin\sdkmanager.bat "build-tools;26.0.0" "extras;android;m2repository" "extras;google;m2repository" "patcher;v4" "platform-tools" "platforms;android-26" > android-sdk-log.txt 2>&1"

echo call %~dp0\..\atom\App\setPaths.bat> %ANDROID_HOME%\android-studio.bat
echo start "" android-studio\bin\studio.exe>> %ANDROID_HOME%\android-studio.bat

keytool -genkeypair -alias androiddebugkey -keypass android -keystore %ANDROID_SDK_HOME%\.android\debug.keystore -storepass android -dname "CN=Android Debug,O=Android,C=US" -validity 9999

echo ---------------------------
echo Creating Android Addon pack
echo ---------------------------

set PACK=%~dp0\tools\7Zip\7z.exe a -t7z -mx -m0=lzma -mlc=8 -myx=9 -mmc=1000000 -mfb=273 -md=128m -ms=on

%PACK% .\packages\AtomPortable-Part5-AndroidSDK.7z -r .\packages\android -x!atom\Data -x!_home\.vimrc -x!go
