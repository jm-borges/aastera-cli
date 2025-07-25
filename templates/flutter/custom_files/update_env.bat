@echo off
set "script_dir=%~dp0"
cd /d "%script_dir%"

echo Cleaning build...
call flutter clean

echo Deleting env.g.dart...
if exist "%script_dir%\lib\env\env.g.dart" (
    del "%script_dir%\lib\env\env.g.dart"
)

echo Running build runner...
call dart run build_runner build --delete-conflicting-outputs

echo Environment variables updated.
