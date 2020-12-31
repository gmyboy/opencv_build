#!/usr/bin/env bash

#
# 构建OpenCV(可选CPU)
#

RED='\033[0;31m'
Green='\033[0;33m'
NC='\033[0m' # No Color

COMPILE_ROOT=`pwd`

TARGET_OUTPUT_PATH=android
# 指定输出目录play(android)
OUTPUT_DIR=${COMPILE_ROOT}/../src/main/jni/opencv

TARGET=$1
TARGET_EXTRA=release

# -e 若指令传回值不等于0，则立即退出shell。
set -e
# 执行指令后，会先显示该指令及所下的参数。
# set +x

ACT_ARCHS_ALL="armv7a arm64 x86 x86_64"

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
    echo "  compile-opencv.sh armv7a|arm64|x86|x86_64"
    echo "  compile-opencv.sh all"
    echo "  compile-opencv.sh clean"
    exit 1
}

echo_nextstep_help() {
    echo "--------------"
    echo -e "${RED}[*] Finished ${NC}"
    echo "--------------"
}

case "$TARGET" in
    "")
        echo_archs armv7a
        sh tools/do-compile-opencv.sh armv7a release ${OUTPUT_DIR} ${TARGET_OUTPUT_PATH}
        echo_nextstep_help
    ;;
    armv7a|arm64|x86|x86_64)
        echo_archs ${TARGET} ${TARGET_EXTRA}
        sh tools/do-compile-opencv.sh ${TARGET} ${TARGET_EXTRA} ${OUTPUT_DIR} ${TARGET_OUTPUT_PATH}
        echo_nextstep_help
    ;;
    all)
        echo "prepare all"
        echo_archs ${ACT_ARCHS_ALL}
        for ARCH in ${ACT_ARCHS_ALL}
        do
            echo "$ARCH $TARGET_EXTRA"
            sh tools/do-compile-opencv.sh ${ARCH} ${TARGET_EXTRA} ${OUTPUT_DIR} ${TARGET_OUTPUT_PATH}
        done
        echo_nextstep_help
    ;;
    clean)
        echo "prepare clean"
        echo_archs ACT_ARCHS_ALL
        rm -rf build/opencv*
	rm -rf build/toolchain
        echo_nextstep_help
    ;;
    check)
        echo_archs ACT_ARCHS_ALL
    ;;
    *)
        echo_usage
        exit 1
    ;;
esac
