@echo off
:: Kiểm tra ffmpeg đã có chưa
where ffmpeg >nul 2>nul
if %ERRORLEVEL%==0 (
    echo FFmpeg đã được cài đặt trên hệ thống.
    pause
    exit /b 0
)

:: Nếu chưa có, hướng dẫn tải và giải nén ffmpeg
set "FFMPEG_URL=https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-essentials.zip"
set "FFMPEG_ZIP=ffmpeg-release-essentials.zip"
set "FFMPEG_DIR=ffmpeg-bin"

if not exist %FFMPEG_ZIP% (
    echo Dang tai ffmpeg tu: %FFMPEG_URL%
    powershell -Command "Invoke-WebRequest -Uri %FFMPEG_URL% -OutFile %FFMPEG_ZIP%"
)

if not exist %FFMPEG_DIR% mkdir %FFMPEG_DIR%

:: Giai nen ffmpeg
powershell -Command "Expand-Archive -Path '%FFMPEG_ZIP%' -DestinationPath '%FFMPEG_DIR%' -Force"

:: Huong dan them ffmpeg vao PATH
setlocal enabledelayedexpansion
for /d %%i in (%FFMPEG_DIR%\ffmpeg-*) do set "FFMPEG_EXTRACT=%%i\bin"
endlocal & set "FFMPEG_EXTRACT=%FFMPEG_EXTRACT%"

if exist "%FFMPEG_EXTRACT%\ffmpeg.exe" (
    echo.
    echo FFmpeg da duoc giai nen vao: %FFMPEG_EXTRACT%
    echo.
    echo Hay them duong dan sau vao bien moi truong PATH cua ban:
    echo   %FFMPEG_EXTRACT%
    echo.
    echo Hoac copy file ffmpeg.exe vao thu muc du an hoac C:\Windows.
) else (
    echo Loi: Khong tim thay ffmpeg.exe sau khi giai nen!
)
pause 