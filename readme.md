### IRDetector构建步骤

> abi 参数可选armeabi-v7a|arm64-v8a|x86|x86_64|""(build all as default)

1.初始化项目依赖库:OpenCV OpenCV_contrib
```
./init.sh
```

2.配置OpenCV参数 

- default：默认配置
- calib3d：包含calib3d的轻量级配置，用于(ImageMatch-ORB)
- min：最小化编译，只包含core

```
./config.sh calib3d
```

3.构建OpenCV
```
cd contrib
./compile-android.sh arm64-v8a
```

4.check *.so、include
```
cd ../src/main/jni/opencv/prebuild
cd ../src/main/jni/opencv/include
```

5.修改OpenCV、OpenCV_contrib的版本
```
vi init-android-opencv.sh
branch=4.0.0
```

6.常见问题
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
