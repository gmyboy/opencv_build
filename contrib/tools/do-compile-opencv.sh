#!/usr/bin/env bash

#
# 开始构建OpenCV(单个CPU)
#

RED='\033[0;31m'
Green='\033[0;33m'
NC='\033[0m' # No Color

#--------------------
echo "--------------------"
echo "${RED}[*]check env $1 ${NC}"
echo "--------------------"

#--------------------
# common defines
CV_ARCH=$1
CV_BUILD_OPT=$2
CV_REAL_OUTPUT_PATH=$3

echo "CV_ARCH=$CV_ARCH"
echo "CV_BUILD_OPT=$CV_BUILD_OPT"
echo "CV_REAL_OUTPUT_PATH=$CV_REAL_OUTPUT_PATH"

if [ -z "$CV_ARCH" ]; then
    echo "You must specific an architecture 'arm64, armv7a, x86, x86_64...'."
    exit 1
fi

CV_BUILD_ROOT=`pwd`
CV_ANDROID_PLATFORM=android-21

CV_BUILD_NAME=
CV_SOURCE=
CV_CROSS_PREFIX=

CV_CFG_FLAGS=
CV_EXTRA_LDFLAGS=
CV_DEP_LIBS=

CV_MODULE_DIRS="dnn gapi highgui ml objdetect photo stitching video calib3d features2d flann videoio imgcodecs imgproc core"
CV_ASSEMBLER_SUB_DIRS=

CV_EXTRA_MODULES_PATH=

CV_STANDALONE_TOOLCHAIN_FLAGS=
CV_STANDALONE_TOOLCHAIN_NAME=
CV_STANDALONE_TOOLCHAIN_ARCH=arm
CV_STANDALONE_TOOLCHAIN_CLANG=clang

CV_SO_SIMPLE_NAME=opencv
CV_SO_NAME=lib${CV_SO_SIMPLE_NAME}.so

CV_PREFIX_SHARE=

#--------------------
echo ""
echo "--------------"
echo "${RED}[*]make OpenCV params ${NC}"
echo "--------------"

UNAME_S=$(uname -s)
UNAME_SM=$(uname -sm)

# OS specific support (must be 'true' or 'false').
linux=false
cygwin=false
msys=false
darwin=false
nonstop=false
case "`uname`" in
  Linux* )
    linux=true
    ;;
  CYGWIN* )
    cygwin=true
    ;;
  Darwin* )
    darwin=true
    ;;
  MINGW* )
    msys=true
    ;;
  NONSTOP* )
    nonstop=true
    ;;
esac

if [ "$cygwin" = "true" -o "$msys" = "true" ] ; then
    export ANDROID_NDK=C:/android/android-sdk-windows/ndk/20.0.5594570
    export ANDROID_CMAKE=C:/android/android-sdk-windows/cmake/3.10.2.4988404
fi

echo "BUILD PLATFORM = $UNAME_SM"
echo "ANDROID_NDK = $ANDROID_NDK"
echo "ANDROID_CMAKE = $ANDROID_CMAKE"

if [ -z "$ANDROID_NDK" ]; then
    echo "You must define ANDROID_NDK before starting."
    echo "They must point to your NDK directories."
    echo ""
    exit 1
fi
NDK_REL=$(grep -o '^Pkg\.Revision.*=[0-9]*.*' ${ANDROID_NDK}/source.properties 2>/dev/null | sed 's/[[:space:]]*//g' | cut -d "=" -f 2)

echo "NDK_REL = $NDK_REL"

case "$NDK_REL" in
    13*|14*|15*|16*|17*|18*|19*|20*|21*)
        if test -d ${ANDROID_NDK}/toolchains/arm-linux-androideabi-4.9
        then
            echo "NDK VERSION = r$NDK_REL"
        else
            echo "You need the NDK r16b r17c 18b 19 20 21"
            echo "https://developer.android.com/ndk/downloads/"
            exit 1
        fi
    ;;
    *)
        echo "You need the NDK r16b r17c 18b 19 20 21"
        echo "https://developer.android.com/ndk/downloads/"
        exit 1
    ;;
esac
if [ -z "$ANDROID_CMAKE" ]; then
    echo "You must define ANDROID_CMAKE before starting."
    echo "They must point to your ninja directories."
    echo ""
    exit 1
fi

#----- armv7a begin -----
if [ "$CV_ARCH" = "armv7a" ]; then
    CV_BUILD_NAME=opencv-armv7a
    CV_SOURCE=${CV_BUILD_ROOT}/build/${CV_BUILD_NAME}
    CV_EXTRA_MODULES_PATH=${CV_BUILD_ROOT}/build/opencv_contrib-armv7a

    CV_CROSS_PREFIX=arm-linux-androideabi
    CV_STANDALONE_TOOLCHAIN_NAME=arm-linux-android-${CV_STANDALONE_TOOLCHAIN_CLANG}

    CV_EXTRA_LDFLAGS="$CV_EXTRA_LDFLAGS -Wl,--fix-cortex-a8"

    CV_ASSEMBLER_SUB_DIRS="arm"

    CV_PREFIX_SHARE="armeabi-v7a"
elif [ "$CV_ARCH" = "armv5" ]; then
    CV_BUILD_NAME=opencv-armv5
    CV_SOURCE=${CV_BUILD_ROOT}/build/${CV_BUILD_NAME}
    CV_EXTRA_MODULES_PATH=${CV_BUILD_ROOT}/build/opencv_contrib-armv5

    CV_CROSS_PREFIX=arm-linux-androideabi
    CV_STANDALONE_TOOLCHAIN_NAME=arm-linux-android-${CV_STANDALONE_TOOLCHAIN_CLANG}

    CV_EXTRA_LDFLAGS="$CV_EXTRA_LDFLAGS"

    CV_ASSEMBLER_SUB_DIRS="arm"

    CV_PREFIX_SHARE="armeabi"
elif [ "$CV_ARCH" = "x86" ]; then
    CV_BUILD_NAME=opencv-x86
    CV_SOURCE=${CV_BUILD_ROOT}/build/${CV_BUILD_NAME}
    CV_EXTRA_MODULES_PATH=${CV_BUILD_ROOT}/build/opencv_contrib-x86

    CV_CROSS_PREFIX=i686-linux-android
    CV_STANDALONE_TOOLCHAIN_NAME=i686-linux-android-${CV_STANDALONE_TOOLCHAIN_CLANG}

    CV_EXTRA_LDFLAGS="$CV_EXTRA_LDFLAGS"

    CV_ASSEMBLER_SUB_DIRS="x86"

    CV_PREFIX_SHARE="x86"
elif [ "$CV_ARCH" = "x86_64" ]; then
    CV_ANDROID_PLATFORM=android-21

    CV_BUILD_NAME=opencv-x86_64
    CV_SOURCE=${CV_BUILD_ROOT}/build/${CV_BUILD_NAME}
    CV_EXTRA_MODULES_PATH=${CV_BUILD_ROOT}/build/opencv_contrib-x86_64

    CV_CROSS_PREFIX=x86_64-linux-android
    CV_STANDALONE_TOOLCHAIN_NAME=x86_64-linux-android-${CV_STANDALONE_TOOLCHAIN_CLANG}

    # https://blog.csdn.net/cjf_iceking/article/details/25825569
    # 其中Wl表示将紧跟其后的参数，传递给连接器ld。Bsymbolic表示强制采用本地的全局变量定义，
    # 这样就不会出现动态链接库的全局变量定义被应用程序/动态链接库中的同名定义给覆盖了！
    CV_EXTRA_LDFLAGS="$CV_EXTRA_LDFLAGS -Wl,-Bsymbolic"

    CV_ASSEMBLER_SUB_DIRS="x86"

    CV_PREFIX_SHARE="x86_64"
elif [ "$CV_ARCH" = "arm64" ]; then
    CV_ANDROID_PLATFORM=android-21

    CV_BUILD_NAME=opencv-arm64
    CV_SOURCE=${CV_BUILD_ROOT}/build/${CV_BUILD_NAME}
    CV_EXTRA_MODULES_PATH=${CV_BUILD_ROOT}/build/opencv_contrib-arm64

    CV_CROSS_PREFIX=aarch64-linux-android
    CV_STANDALONE_TOOLCHAIN_NAME=aarch64-linux-android-${CV_STANDALONE_TOOLCHAIN_CLANG}
    
    CV_EXTRA_LDFLAGS="$CV_EXTRA_LDFLAGS"

    CV_ASSEMBLER_SUB_DIRS="aarch64 neon"

    CV_PREFIX_SHARE="arm64-v8a"
else
    echo "unknown architecture $CV_ARCH";
    exit 1
fi

if [ ! -d $CV_SOURCE ]; then
    echo ""
    echo "!! ERROR"
    echo "!! Can not find OpenCV directory for $CV_BUILD_NAME"
    echo "!! Run 'sh init-android-opencv.sh' first"
    echo ""
    exit 1
fi


#--------------------
echo ""
echo "-------------------"
echo "${RED}[*]make NDK standalone toolchain ${NC}"
echo "-------------------"

CV_TOOLCHAIN_PATH=${CV_BUILD_ROOT}/build/toolchain
CV_SYSROOT=${CV_TOOLCHAIN_PATH}/sysroot

CV_STANDALONE_TOOLCHAIN_FLAGS="$CV_STANDALONE_TOOLCHAIN_FLAGS --install-dir=$CV_TOOLCHAIN_PATH"

${ANDROID_NDK}/build/tools/make-standalone-toolchain.sh \
${CV_STANDALONE_TOOLCHAIN_FLAGS} \
--verbose \
--toolchain=${CV_STANDALONE_TOOLCHAIN_NAME} \
--abis=${CV_ANDROID_PLATFORM} \
--force

#--------------------
echo ""
echo "-----------------"
echo "${RED}[*]config OpenCV make flag ${NC}"
echo "-----------------"

export PATH=${CV_TOOLCHAIN_PATH}/bin:$PATH
export CLANG=${CV_CROSS_PREFIX}-clang
export CXX=${CV_CROSS_PREFIX}-clang++
export LD=${CV_CROSS_PREFIX}-ld
export AR=${CV_CROSS_PREFIX}-ar
export STRIP=${CV_CROSS_PREFIX}-strip

# https://blog.csdn.net/m0_37170593/article/details/78892913
# example: --extra-cflags=-I/xxxx/include
# example: --extra-ldflags=-L/usr/local/x264-x86/lib
# --extra-cflags=ECFLAGS   add ECFLAGS to CFLAGS []
# --extra-ldflags=ELDFLAGS add ELDFLAGS to LDFLAGS []
# -Wall 允许发出Gcc提供的所有有用的报警信息
# -O3Gcc 可以对代码进行优化，它通过编译选项“-On”来控制优化代码的生成，其中n是一个代表优化级别的整数。
# 对于不同版本的Gcc来讲，n的取值范围及其对应的优化效果可能并不完全相同，比较典型的范围是从0变化到2或3。
# -pipe                   Use pipes between commands, when possible# -pipe 使用管道
# -ffast-math             Allow aggressive, lossy floating-point optimizations
# -Werror	              把所有的告警信息转化为错误信息，并在告警发生时终止编译过程
# -Wa,<arg>               Pass the comma separated arguments in <arg> to the assembler
# -fPIC https://blog.csdn.net/a_ran/article/details/41943749
# -std=c99 https://blog.csdn.net/u012075739/article/details/26516007/
CV_CFLAGS="-O3 -fPIC -Wall -pipe \
    -std=c99 \
    -ffast-math \
    -fstrict-aliasing -Werror=strict-aliasing \
    -Wa,--noexecstack \
    -DANDROID -DNDEBUG"

# OpenCV cmake options
CV_CFG_FLAGS="$CV_CFG_FLAGS -GNinja"
if [ "$cygwin" = "true" -o "$msys" = "true" ] ; then
    CV_CFG_FLAGS="$CV_CFG_FLAGS -DCMAKE_MAKE_PROGRAM='${ANDROID_CMAKE}/bin/ninja.exe'"
else
    CV_CFG_FLAGS="$CV_CFG_FLAGS -DCMAKE_MAKE_PROGRAM='${ANDROID_CMAKE}/bin/ninja'"
fi
if [ -d "$CV_EXTRA_MODULES_PATH/modules" ]; then
    CV_CFG_FLAGS="$CV_CFG_FLAGS -DOPENCV_EXTRA_MODULES_PATH=$CV_EXTRA_MODULES_PATH/modules"
fi

CV_CFG_FLAGS="$CV_CFG_FLAGS -DCMAKE_BUILD_TYPE=Release"
CV_CFG_FLAGS="$CV_CFG_FLAGS -DCMAKE_TOOLCHAIN_FILE='${ANDROID_NDK}/build/cmake/android.toolchain.cmake'"
CV_CFG_FLAGS="$CV_CFG_FLAGS -DCMAKE_INSTALL_PREFIX='${CV_SOURCE}/build'"
CV_CFG_FLAGS="$CV_CFG_FLAGS -DCMAKE_PREFIX_PATH='${CV_SOURCE}/build'"
CV_CFG_FLAGS="$CV_CFG_FLAGS -DANDROID_NDK='${ANDROID_NDK}'"
CV_CFG_FLAGS="$CV_CFG_FLAGS -DANDROID_NATIVE_API_LEVEL=${CV_ANDROID_PLATFORM}"
CV_CFG_FLAGS="$CV_CFG_FLAGS -DANDROID_ABI=${CV_PREFIX_SHARE}"
CV_CFG_FLAGS="$CV_CFG_FLAGS -DANDROID_STL=c++_shared"

# with opencv config module
export COMMON_CV_CFG_FLAGS=
. ${CV_BUILD_ROOT}/config/module.sh

CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS $CV_CFG_FLAGS"

echo ""
echo "---------------------------"
echo "${RED}[*]compile OpenCV ${NC}"
echo "---------------------------"
echo "CV_CFLAGS = $CV_CFLAGS"
echo "CV_CFG_FLAGS = $CV_CFG_FLAGS"

if [ ! -d "${CV_SOURCE}/build" ]; then
    mkdir -p ${CV_SOURCE}/build
fi
rm -rf ${CV_SOURCE}/build/*
cd ${CV_SOURCE}/build

cmake ${CV_SOURCE} ${CV_CFG_FLAGS}
ninja clean
ninja install

echo ""
echo "-------------------"
echo "${RED}[*] link .a/.o file to single share(.so) ${NC}"
echo "-------------------"

CV_LINK_C_OBJ_FILES=
CV_LINK_ASM_OBJ_FILES=
# add opencv module
for MODULE_DIR in ${CV_MODULE_DIRS}
do
    C_OBJ_FILES="sdk/native/staticlibs/$CV_PREFIX_SHARE/libopencv_$MODULE_DIR.a"
    if [ -e "$C_OBJ_FILES" ]; then
        echo "link $C_OBJ_FILES"
        CV_LINK_C_OBJ_FILES="$CV_LINK_C_OBJ_FILES $C_OBJ_FILES"
    fi
done

# add 3rdparty module
CV_3RDPARTY_FILES=sdk/native/3rdparty/libs/${CV_PREFIX_SHARE}
if ls ${CV_3RDPARTY_FILES} 1> /dev/null 2>&1; then
    echo "link $CV_3RDPARTY_FILES/*.a"
    CV_LINK_C_OBJ_FILES="$CV_LINK_C_OBJ_FILES $CV_3RDPARTY_FILES/*.a"
fi

echo ""
echo "CV_LINK_C_OBJ_FILES = $CV_LINK_C_OBJ_FILES"
echo "CV_LINK_ASM_OBJ_FILES = $CV_LINK_ASM_OBJ_FILES"
echo "CV_DEP_LIBS = $CV_DEP_LIBS"
echo "CV_SO = ${CV_SOURCE}/build/sdk/native/libs/${CV_PREFIX_SHARE}/${CV_SO_NAME}"
echo "CV_ANDROID_PLATFORM = $CV_ANDROID_PLATFORM"
echo "Use Compiler: ${CLANG}"
echo ""

if [ ! -d "${CV_SOURCE}/build/sdk/native/libs/${CV_PREFIX_SHARE}" ]; then
    mkdir -p ${CV_SOURCE}/build/sdk/native/libs/${CV_PREFIX_SHARE}
fi

${CXX} -ldl -lm -llog -ljnigraphics -lz -shared -Wl, --sysroot=${CV_SYSROOT} \
    -Wl,-soname,${CV_SO_NAME} \
    -o ${CV_SOURCE}/build/sdk/native/libs/${CV_PREFIX_SHARE}/${CV_SO_NAME} \
    -Wl,--whole-archive ${CV_LINK_C_OBJ_FILES} \
    -Wl,--no-whole-archive \

${STRIP} --strip-unneeded \
    ${CV_SOURCE}/build/sdk/native/libs/${CV_PREFIX_SHARE}/${CV_SO_NAME}

if [ ! -d "$CV_REAL_OUTPUT_PATH/prebuild" ]; then
    mkdir -p ${CV_REAL_OUTPUT_PATH}/prebuild
fi
rm -rf ${CV_REAL_OUTPUT_PATH}/include
rm -rf ${CV_REAL_OUTPUT_PATH}/prebuild/${CV_PREFIX_SHARE}
cp -r ${CV_SOURCE}/build/sdk/native/jni/include ${CV_REAL_OUTPUT_PATH}/include
cp -r ${CV_SOURCE}/build/sdk/native/libs/${CV_PREFIX_SHARE} ${CV_REAL_OUTPUT_PATH}/prebuild/${CV_PREFIX_SHARE}
