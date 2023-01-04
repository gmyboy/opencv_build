### opencv构建步骤

1.初始化项目源码库:OpenCV OpenCV_contrib 设置版本:version_opencv and version_opencv_contrib
```
./init.sh
```

2.设置预构建参数 
- default or ""：默认配置
- calib3d：包含calib3d的轻量级配置，用于(ImageMatch-ORB)
- min：最小化编译，只包含core

```
./config.sh [min|calib3d|default or ""]
```

3.开始构建
```
./compile-android.sh [armeabi-v7a|arm64-v8a|x86|x86_64|""(build all as default)]
```

4.常见问题
```
-- xfeatures2d/boostdesc: Download: boostdesc_bgm.i
-- xfeatures2d/boostdesc: Download: boostdesc_bgm_bi.i
-- xfeatures2d/boostdesc: Download: boostdesc_bgm_hd.i
-- xfeatures2d/boostdesc: Download: boostdesc_binboost_064.i
-- xfeatures2d/boostdesc: Download: boostdesc_binboost_128.i
-- xfeatures2d/boostdesc: Download: boostdesc_binboost_256.i
-- xfeatures2d/boostdesc: Download: boostdesc_lbgm.i
-- xfeatures2d/vgg: Download: vgg_generated_48.i
-- xfeatures2d/vgg: Download: vgg_generated_64.i
-- xfeatures2d/vgg: Download: vgg_generated_80.i
-- xfeatures2d/vgg: Download: vgg_generated_120.i
```

解决
```
1.get ipaddress of "raw.githubusercontent.com" with https://www.ipaddress.com/  then:
sudo vim /etc/hosts
add "IP" raw.githubusercontent.com
```
