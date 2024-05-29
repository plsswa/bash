@echo off
REM Change directory to the location of your Python script
cd /d "C:\Users\psamaras\OneDrive - London Stock Exchange Group\Work\SERVICE_MANAGEMENT\ExchangeEventTimeline"

REM Execute the Python script
python.exe day_update.py

REM Check if the Python script executed successfully
IF %ERRORLEVEL% NEQ 0 (
    echo Python script execution failed
    exit /b %ERRORLEVEL%
)

REM Copy the file from location A to location B
copy C:\TimeLineAutoSave\HeatMapForExchangeOPCycles_to_server_V1.0.xlsx "C:\Users\psamaras\OneDrive - London Stock Exchange Group\Work\SERVICE_MANAGEMENT\ExchangeEventTimeline"

REM Check if the copy operation was successful
IF %ERRORLEVEL% NEQ 0 (
    echo File copy failed
    exit /b %ERRORLEVEL%
)

echo Script executed and file copied successfully

pause
