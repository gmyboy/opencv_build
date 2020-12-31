#!/usr/bin/env bash

#
# 从远程库克隆代码到本地
#

REMOTE_REPO=$1
LOCAL_WORKSPACE=$2

if [ -z $REMOTE_REPO -o -z $LOCAL_WORKSPACE ]; then
    echo "invalid call pull-repo.sh '$REMOTE_REPO' '$LOCAL_WORKSPACE'"
elif [ ! -d $LOCAL_WORKSPACE ]; then
    git clone $REMOTE_REPO $LOCAL_WORKSPACE
else
    cd $LOCAL_WORKSPACE
    git fetch --all --tags
    cd -
fi