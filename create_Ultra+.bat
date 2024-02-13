@echo off

set VERSION=9.2-fork

unrealpak .\zz_UltraPlus_v%VERSION%_P.pak -create=.\responsefile-pak.txt
unrealpak .\zz_UltraPlus_v%VERSION%_RTSkylight_P.pak -create=.\responsefile-rtskylight.txt

pause
