@echo off
setlocal

REM 查找 Vulkan SDK 路径
if defined VULKAN_SDK (
    echo Vulkan SDK found at %VULKAN_SDK%
) else (
    echo Vulkan SDK not found in environment variables.
    echo Trying to locate Vulkan SDK...
    for /f "tokens=3" %%i in ('reg query "HKCU\Environment" /v VULKAN_SDK 2^>nul') do (
        set "VULKAN_SDK=%%i"
    )
    if defined VULKAN_SDK (
        echo Vulkan SDK found at %VULKAN_SDK%
    ) else (
        echo Vulkan SDK not found in registry.
        goto :EOF
    )
)

REM 设置 glslangValidator 路径
set GLSLANG_VALIDATOR=%VULKAN_SDK%\Bin\glslangValidator.exe

REM 检查 glslangValidator 是否存在
if exist "%GLSLANG_VALIDATOR%" (
    echo glslangValidator found at %GLSLANG_VALIDATOR%
) else (
    echo glslangValidator not found.
    goto :EOF
)

REM 设置顶点着色器文件
set VERTEX_SHADER_FILE=./assert/shaders/base.vert
set OUTPUT_FILE=base_vert.spv
REM 编译顶点着色器
"%GLSLANG_VALIDATOR%" -V %VERTEX_SHADER_FILE% -o %OUTPUT_FILE%

REM 设置片段着色器文件
set FRAGMENT_SHADER_FILE=./assert/shaders/base.frag
set OUTPUT_FILE=base_frag.spv
REM 编译片段着色器
"%GLSLANG_VALIDATOR%" -V %FRAGMENT_SHADER_FILE% -o %OUTPUT_FILE%

REM 检查编译是否成功
if exist %OUTPUT_FILE% (
    echo Compilation succeeded, output: %OUTPUT_FILE%
) else (
    echo Compilation failed.
)

endlocal
pause