#!/usr/bin/env bash

#
# 设置配置项
#

RED='\033[0;31m'
Green='\033[0;33m'
NC='\033[0m' # No Color

CV_TARGET=$1

echo "----------------------------"
echo -e "${RED}[*] start config opencv module ${NC}"
echo "----------------------------"

# http://www.runoob.com/linux/linux-shell-test.html
# -f 文件名	如果文件存在且为普通文件则为真
if [ -f 'contrib/config/module.sh' ]; then
    rm contrib/config/module.sh
fi

case "$CV_TARGET" in
    min)
        cp contrib/config/module-min.sh contrib/config/module.sh
        cat contrib/config/module.sh
        echo ""
        echo "config complete with min"
    ;;
    lite)
        cp contrib/config/module-lite.sh contrib/config/module.sh
        cat contrib/config/module.sh
        echo ""
        echo "config complete with lite"
    ;;
    lite-calib3d)
        cp contrib/config/module-lite-calib3d.sh contrib/config/module.sh
        cat contrib/config/module.sh
        echo ""
        echo "config complete with lite-calib3d"
    ;;
    default)
        cp contrib/config/module-default.sh contrib/config/module.sh
        cat contrib/config/module.sh
        echo ""
        echo "config complete with default"
    ;;
    clean)
        rm -rf contrib/config/module.sh
        echo "clean complete"
    ;;
    *)
        echo_usage
        exit 1
    ;;
esac

echo "------------------------------"
echo -e "${RED}[*] Finish config opencv module ${NC}"
echo "------------------------------"
