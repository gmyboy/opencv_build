#
#从远程仓库下载OpenCV相关依赖库
#本地fork，并创建分支
#

RED='\033[0;31m'
Green='\033[0;33m'
NC='\033[0m'

# http://www.runoob.com/linux/linux-comm-set.html
# set指令能设置所使用shell的执行方式，可依照不同的需求来做设置
# -e 　若指令传回值不等于0，则立即退出shell。
set -e

#remote_opencv=https://github.com/gmyboy/opencv.git
#remote_opencv_contrib=https://github.com/gmyboy/opencv_contrib.git
# use mirror
remote_opencv=http://192.168.10.14:3000/gmy/opencv.git
version_opencv=4.7.0
remote_opencv_contrib=http://192.168.10.14:3000/gmy/opencv_contrib.git
version_opencv_contrib=4.7.0
local_opencv=opencv
local_opencv_contrib=opencv_contrib

git --version

function pull_repo() {
    REMOTE_REPO=$1
    LOCAL_WORKSPACE=$2
    TAG_NAME=$3
    if [ -z $REMOTE_REPO -o -z $LOCAL_WORKSPACE ]; then
        echo "invalid call init.sh '$REMOTE_REPO' '$LOCAL_WORKSPACE'"
    elif [ ! -d $LOCAL_WORKSPACE ]; then
        git clone $REMOTE_REPO $LOCAL_WORKSPACE
        cd $LOCAL_WORKSPACE
        git checkout -b compile/$TAG_NAME $TAG_NAME
        cd -
    else
        cd $LOCAL_WORKSPACE
        git fetch --all --tags
        cd -
    fi
}

echo "------------------------------"
echo -e "${RED}[*] pull OpenCV [${version_opencv}] from ($remote_opencv) ${NC}"
echo "------------------------------"
pull_repo ${remote_opencv} ${local_opencv} ${version_opencv}

#patch xfeature2d
cd ${local_opencv}
mkdir -p .cache/xfeatures2d
cp -r ../patch/xfeatures2d/boostdesc .cache/xfeatures2d/
cp -r ../patch/xfeatures2d/vgg .cache/xfeatures2d/
#patch tbb
mkdir -p .cache/tbb
cp -r ../patch/tbb/* .cache/tbb
#patch ade
mkdir -p .cache/ade
cp -r ../patch/ade/* .cache/ade
#patch data
mkdir -p .cache/data
cp -r ../patch/data/8afa57abc8229d611c4937165d20e2a2d9fc5a12-face_landmark_model.dat .cache/data/7505c44ca4eb54b4ab1e4777cb96ac05-face_landmark_model.dat
cd -

echo "------------------------------"
echo -e "${RED}[*] pull OpenCV_contrib [${version_opencv_contrib}] from ($remote_opencv_contrib) ${NC}"
echo "------------------------------"
pull_repo ${remote_opencv_contrib} ${local_opencv_contrib} ${version_opencv_contrib}

echo "----------------------"
echo -e "${RED}[*] Finish init OpenCV ${NC}"
echo "----------------------"
