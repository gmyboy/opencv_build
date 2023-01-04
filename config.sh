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
if [ -f 'config/module.sh' ]; then
    rm config/module.sh
fi

echo_usage() {
    echo "Usage:"
    echo "  config.sh min|calib3d|default"
    exit 1
}

case "$CV_TARGET" in
min)
    cp config/module-min.sh config/module.sh
    cat config/module.sh
    echo ""
    echo "config complete with min"
    ;;
calib3d)
    cp config/module-calib3d.sh config/module.sh
    cat config/module.sh
    echo ""
    echo "config complete with calib3d"
    ;;
default)
    cp config/module-default.sh config/module.sh
    cat config/module.sh
    echo ""
    echo "config complete with default"
    ;;
*|-h|-help)
    echo_usage
    exit 1
    ;;
esac

echo "------------------------------"
echo -e "${RED}[*] Finish config opencv module ${NC}"
echo "------------------------------"
