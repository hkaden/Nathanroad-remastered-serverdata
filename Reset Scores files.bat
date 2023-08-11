@REM "%%~ni" = 檔案名
@REM "%%~xi" = 副檔名
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%" & set "MS=%dt:~15,3%"

ren "scores.json" "scores %YYYY%%MM%%DD%_%HH%%Min%%Sec%.json"