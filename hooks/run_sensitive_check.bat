@echo off
REM Try default Git Bash first
if exist "%ProgramFiles%\Git\bin\bash.exe" (
    "%ProgramFiles%\Git\bin\bash.exe" hooks/sensitive_check.sh %*
    exit /b %ERRORLEVEL%
)

REM Try user-local Git Bash next
if exist "%LOCALAPPDATA%\Programs\Git\bin\bash.exe" (
    "%LOCALAPPDATA%\Programs\Git\bin\bash.exe" hooks/sensitive_check.sh %*
    exit /b %ERRORLEVEL%
)

echo "❌ Could not find Git Bash. Please install Git for Windows or add bash to PATH."
exit /b 1
