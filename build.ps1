
<#
.SYNOPSIS
    Builds 'ros2cs'
.DESCRIPTION
    This script runs colcon build
.PARAMETER with_tests
    build with tests
.PARAMETER standalone
    standalone build
#>
Param (
    [Parameter(Mandatory=$false)][switch]$with_tests=$false,
    [Parameter(Mandatory=$false)][switch]$standalone=$false
)

$msg="Build started."
$tests_switch=0
if($with_tests) {
    $msg+=" (with tests)"
    $tests_switch=1
}
$standalone_switch=0
if($standalone) {
    $msg+=" (standalone)"
    $standalone_switch=1
}

Write-Host $msg -ForegroundColor Green
$python_exe = python -c "import sys; print(sys.executable)"
$cmake_args = " -DSTANDALONE_BUILD:int=$standalone_switch", " -DCMAKE_BUILD_TYPE=Release", " -DBUILD_TESTING:int=$tests_switch", " -DPython3_EXECUTABLE=$python_exe", " --no-warn-unused-cli"
colcon build --merge-install --event-handlers console_direct+ --cmake-args $cmake_args
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
