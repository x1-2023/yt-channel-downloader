@echo off
setlocal
if exist "ffmpeg-bin" (
    for /d %%i in (ffmpeg-bin\ffmpeg-*) do set "FFMPEG_EXTRACT=%%i\bin"
    set "PATH=%FFMPEG_EXTRACT%;%PATH%"
)
py main.py
pause 