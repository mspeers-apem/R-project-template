@REM Runs all trend scripts in order using parameters specified in config file.
@REM To use this, open the terminal and run "scripts/run_all.bat" from the project root directory.
@REM You might need to change the path to Rscript.exe in the script below if you have a different version of R installed, or if you installed R in a different location.
@REM You will need to change the path to each script to the correct location your machine.

@echo off

set R_SCRIPT="C:\Program Files\R\R-4.6.0\bin\Rscript.exe"

echo Running model fitting...
%R_SCRIPT% "C:\Users\M.Speers\OneDrive - Apem Limited\Documents\Misc Code\template\scripts\1_model_fitting.R" > logs/1_model_fitting.log 2>&1
if errorlevel 1 goto :error

echo Running model plotting ...
%R_SCRIPT% "C:\Users\M.Speers\OneDrive - Apem Limited\Documents\Misc Code\template\scripts\2_model_plotting.R" > logs/2_model_plotting.log 2>&1
if errorlevel 1 goto :error

echo All scripts completed successfully.
pause
exit /b 0

:error
echo Script failed with error code %errorlevel%.
pause
exit /b %errorlevel%