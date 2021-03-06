
@ECHO OFF
ECHO Dependency compilation starting...

:: Target  = CMAKE Build Dir
:: lib     = Post-combine lib dir
:: include = Headers for all included libs

RMDIR /s /q target >NUL
RMDIR /s /q install >NUL

MD target >NUL
MD install\lib >NUL
MD install\include\freetype >NUL
MD install\include\libzip >NUL
MD install\include\zlib >NUL
MD install\include\glfw >NUL
MD install\include\json >NUL

CD target

ECHO Running cmake.

cmake -D CMAKE_INSTALL_PREFIX=./install .. >NUL
COPY zlib\zconf.h ..\zlib\zconf.h >NUL

ECHO Configuration complete.
ECHO Compiling...

devenv rocket-deps.sln /build Release

ECHO Compiling complete.
ECHO Gathering...

@call ..\combine_static_libraries.cmd librocket-deps

CD ..

XCOPY /S /Y /Q /H freetype2\include\* install\include\
XCOPY /S /Y /Q /H target\freetype2\include\* install\include\
XCOPY /S /Y /Q /H glfw\include\* install\include\glfw\
XCOPY /S /Y /Q /H json\single_include\nlohmann\* install\include\json\
XCOPY /S /Y /Q /H libzip\lib\*.h install\include\libzip\
XCOPY /S /Y /Q /H zlib\*.h install\include\zlib\

XCOPY /S /Y /Q /H target\librocket-deps.lib install\lib\

ECHO Dependency compilation complete!
