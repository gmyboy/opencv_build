#
# 构建OpenCV(可选CPU)
#

RED='\033[0;31m'
Green='\033[0;33m'
NC='\033[0m' # No Color
# -e 若指令传回值不等于0，则立即退出shell。
set -e
# 执行指令后，会先显示该指令及所下的参数。
# set +x

ROOT_PATH=$(pwd)

# OS specific support (must be 'true' or 'false').
UNAME_S=$(uname -s)
UNAME_SM=$(uname -sm)
linux=false
cygwin=false
msys=false
darwin=false
nonstop=false
case "$(uname)" in
Linux*)
    linux=true
    ;;
CYGWIN*)
    cygwin=true
    ;;
Darwin*)
    darwin=true
    ;;
MINGW*)
    msys=true
    ;;
NONSTOP*)
    nonstop=true
    ;;
esac
echo "PLATFORM = $UNAME_SM"

# environment params
PYTHON_BINARY=E:/python/Python38/python.exe #build opencv_android needed
export ANDROID_NDK_HOME=$ANDROID_HOME\\ndk\\21.2.6472646
ANDROID_CMAKE=$ANDROID_HOME\\cmake\\3.10.2.4988404
ANDROID_PLATFORM=21
echo "ANDROID_SDK = $ANDROID_HOME"
echo "ANDROID_NDK_HOME = $ANDROID_NDK_HOME"
echo "ANDROID_CMAKE = $ANDROID_CMAKE"
echo "ANDROID_PLATFORM = $ANDROID_PLATFORM"

ACT_ARCHS_ALL="armeabi-v7a arm64-v8a x86 x86_64"

if [ "$cygwin" = "true" -o "$msys" = "true" ]; then
    CMAKE_BINARY=${ANDROID_CMAKE}\\bin\\cmake.exe
    NINJA_BINARY=${ANDROID_CMAKE}\\bin\\ninja.exe
else
    CMAKE_BINARY=${ANDROID_CMAKE}\\bin\\cmake
    NINJA_BINARY=${ANDROID_CMAKE}\\bin\\ninja
fi

function compile() {
    ABI=$1
    if [ -z "$ABI" ]; then
        echo "You must specific an architecture in '${ACT_ARCHS_ALL}'."
        exit 1
    fi

    # mk output dir
    CV_SOURCE=${ROOT_PATH}\\opencv
    CV_CONTRIB_SOURCE=${ROOT_PATH}\\opencv_contrib
    OUTPUT_PATH=$2

    CFLAGS="-O3 -Wall \
    -Wa,--noexecstack"

    CFG_FLAGS="-GNinja"
    CFG_FLAGS="$CFG_FLAGS -DCMAKE_MAKE_PROGRAM='${NINJA_BINARY}'"
    CFG_FLAGS="$CFG_FLAGS -DPYTHON_EXECUTABLE='${PYTHON_BINARY}'"
    CFG_FLAGS="$CFG_FLAGS -DPYTHON2_EXECUTABLE='${PYTHON_BINARY}'"
    CFG_FLAGS="$CFG_FLAGS -DPYTHON3_EXECUTABLE='${PYTHON_BINARY}'"

    if [ -d "${CV_CONTRIB_SOURCE}\\modules" ]; then
        CFG_FLAGS="$CFG_FLAGS -DOPENCV_EXTRA_MODULES_PATH=${CV_CONTRIB_SOURCE}\\modules"
    fi

    CFG_FLAGS="$CFG_FLAGS -DCMAKE_BUILD_TYPE=Release"
    CFG_FLAGS="$CFG_FLAGS -DCMAKE_TOOLCHAIN_FILE='${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake'"
    # CFG_FLAGS="$CFG_FLAGS -DCMAKE_INSTALL_PREFIX='${OUTPUT_PATH}'"
    CFG_FLAGS="$CFG_FLAGS -DANDROID_NDK='${ANDROID_NDK_HOME}'"
    CFG_FLAGS="$CFG_FLAGS -DANDROID_SDK_ROOT='${ANDROID_HOME}'"
    CFG_FLAGS="$CFG_FLAGS -DANDROID_NATIVE_API_LEVEL=${ANDROID_PLATFORM}"
    CFG_FLAGS="$CFG_FLAGS -DANDROID_ARM_NEON=ON"
    CFG_FLAGS="$CFG_FLAGS -DANDROID_ABI=${ABI}"
    CFG_FLAGS="$CFG_FLAGS -DANDROID_STL=c++_shared"
    # CFG_FLAGS="$CFG_FLAGS -DCMAKE_C_FLAGS_RELEASE='${CFLAGS}'"
    # CFG_FLAGS="$CFG_FLAGS -DCMAKE_CXX_FLAGS_RELEASE='${CFLAGS}'"

    # with user config module
    export COMMON_CV_CFG_FLAGS=
    . ${ROOT_PATH}\\config\\module.sh
    CFG_FLAGS="$CFG_FLAGS ${COMMON_CV_CFG_FLAGS}"

    echo ""
    echo "---------------------------"
    echo "${RED}[*]compile OpenCV ${NC}"
    echo "---------------------------"
    echo "CFLAGS = $CFLAGS"
    echo "CFG_FLAGS = $CFG_FLAGS"

    if [ ! -d "${OUTPUT_PATH}" ]; then
        mkdir -p ${OUTPUT_PATH}
    fi
    cd ${OUTPUT_PATH}

    ${CMAKE_BINARY} ${CV_SOURCE} ${CFG_FLAGS}
    ${NINJA_BINARY} clean
    ${NINJA_BINARY} install

    cd -
}

echo_archs() {
    echo "--------------"
    echo -e "${RED}[*] check archs ${NC}"
    echo "-------------"
    echo "ALL_ARCHS = $ACT_ARCHS_ALL"
    echo "ACT_ARCHS = $*"
    echo ""
}

echo_usage() {
    echo "Usage:"
    echo "  compile-android.sh armeabi-v7a|arm64-v8a|x86|x86_64|''"
    echo "  compile-android.sh clean"
    exit 1
}

echo_nextstep_help() {
    echo "--------------"
    echo -e "${RED}[*] Finished ${NC}"
    echo "--------------"
}

# select target abi from command
case "$1" in
"")
    echo_archs ${ACT_ARCHS_ALL}
    OUTPUT_PATH=${ROOT_PATH}\\build
    if [ -d "${OUTPUT_PATH}" ]; then
        rm -rf ${OUTPUT_PATH}
    fi
    mkdir -p ${OUTPUT_PATH}
    for ARCH in ${ACT_ARCHS_ALL}; do
        echo "$ARCH $TARGET_EXTRA"
        compile ${ARCH} ${OUTPUT_PATH}
    done
    echo_nextstep_help
    ;;
armeabi-v7a | arm64-v8a | x86 | x86_64)
    OUTPUT_PATH=${ROOT_PATH}\\build
    if [ -d "${OUTPUT_PATH}" ]; then
        rm -rf ${OUTPUT_PATH}
    fi
    mkdir -p ${OUTPUT_PATH}
    echo_archs $1
    compile $1 ${OUTPUT_PATH}
    echo_nextstep_help
    ;;
clean)
    rm -rf build/*
    ;;
* | -help | -h)
    echo_usage
    exit 1
    ;;
esac
