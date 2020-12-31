#!/usr/bin/env bash

#
#从远程仓库下载OpenCV相关依赖库
#本地fork，并创建分支
#

RED='\033[0;31m'
Green='\033[0;33m'
NC='\033[0m'

TARGET=$1

#remote_opencv=https://github.com/opencv/opencv.git
# use mirror
remote_opencv=http://192.168.10.14:3000/gmy/opencv.git
remote_opencv_contrib=http://192.168.10.14:3000/gmy/opencv_contrib.git
branch=3.4.11
local_opencv=../opencv
local_opencv_contrib=../opencv_contrib
TOOLS=contrib/tools

# http://www.runoob.com/linux/linux-comm-set.html
# set指令能设置所使用shell的执行方式，可依照不同的需求来做设置
# -e 　若指令传回值不等于0，则立即退出shell。
set -e
git --version

function pull_repository()
{
    echo "------------------------------"
    echo -e "${RED}[*] pull OpenCV ($remote_opencv) ${NC}"
    echo "------------------------------"

    sh ${TOOLS}/pull-repo-base.sh ${remote_opencv_contrib} ${local_opencv_contrib}
    sh ${TOOLS}/pull-repo-base.sh ${remote_opencv} ${local_opencv}
}

function pull_fork()
{
    echo ""
    echo "--------------------"
    echo -e "${RED}[*] pull OpenCV fork opencv-$1 ${NC}"
    echo "--------------------"

    if [[ -d contrib/build/opencv_contrib-$1 ]]; then
        rm -rf contrib/build/opencv_contrib-$1
    fi

    if [[ -d contrib/build/opencv-$1 ]]; then
        rm -rf contrib/build/opencv-$1
    fi

    sh ${TOOLS}/pull-repo-ref.sh ${remote_opencv_contrib} contrib/build/opencv_contrib-$1 ${local_opencv_contrib}
    cd contrib/build/opencv_contrib-$1
    git checkout -b build_tools ${branch}
    cd -

    sh ${TOOLS}/pull-repo-ref.sh ${remote_opencv} contrib/build/opencv-$1 ${local_opencv}
    cd contrib/build/opencv-$1
    git checkout -b build_tools ${branch}
    cd -
}

echo_usage() {
    echo "Usage:"
    echo "  init-android-opencv.sh all|armv7a|arm64|x86|x86_64"
    echo "  init-android-opencv.sh clean"
    exit 1
}

case "$TARGET" in
    all)
        pull_repository
        pull_fork "armv7a"
        pull_fork "arm64"
        pull_fork "x86"
        pull_fork "x86_64"
        echo "init complete"
    ;;
    armv7a)
        pull_repository
         pull_fork "armv7a"
         echo "init complete"
    ;;
    arm64)
        pull_repository
        pull_fork "arm64"
        echo "init complete"
    ;;
    x86)
        pull_repository
        pull_fork "x86"
        echo "init complete"
    ;;
    x86_64)
        pull_repository
        pull_fork "x86_64"
        echo "init complete"
    ;;
    clean)
        ACT_ARCHS_ALL="armv7a arm64 x86 x86_64"
        for ARCH in ${ACT_ARCHS_ALL}
        do
            if [[ -d build/opencv-${ARCH} ]]; then
                echo "rm contrib/build/opencv-$ARCH"
                rm -rf contrib/build/opencv-${ARCH}
            fi
        done
        echo "clean complete"
    ;;
    *)
        echo_usage
        exit 1
    ;;
esac

echo "----------------------"
echo -e "${RED}[*] Finish about OpenCV ${NC}"
echo "----------------------"


