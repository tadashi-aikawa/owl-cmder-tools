@echo off
setlocal enabledelayedexpansion

set PX=%~1
(
    echo [Batch]
    echo AdvCanvas=0
    echo AdvNoEnlarge=1
    echo AdvResample=1
    echo AdvResize=1
    echo AdvResizeOpt=1
    echo AdvResizeRatio=1
    echo AdvResizeL=%PX%
    echo AdvSaveOldDate=1
    echo UseAdvanced=1
    echo\
    echo [PNG]
    echo SavePNGTransp=0
    echo SavePNGAlpha=0
    echo PngWndColor=1
    echo PngOut=0
    echo CompressionLevel=6
    echo\
    echo [JPEG]
    echo KeepCom=1
    echo KeepExif=1
    echo KeepIptc=1
    echo KeepQuality=1
    echo KeepXmp=1
    echo Save Progressive=1
    echo Save Quality=95
) >"%Temp%\i_view64.ini"

set /A ARGI=1
for %%f in (%*) do (
    if !ARGI! GTR 1 (
        "C:\Program Files\IrfanView\i_view64.exe" %%f /ini="%Temp%" /advancedbatch /convert=%%f
    )
    set /A ARGI=ARGI+1
)

del "%Temp%\i_view64.ini"
