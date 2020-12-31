### IRDetector构建步骤

> abi 参数可选all|armv7a(default)|arm64|x86|x86_64

1.初始化项目依赖库OpenCV OpenCV_contrib
```
./init-android-opencv.sh arm64
```

2.配置OpenCV参数 

- default：默认配置
- lite：轻量级,包含人脸识别等基本库
- lite-calib3d：包含calib3d的轻量级配置，用于ImageMatch(ORB)
- min：最小化编译，只包含core

```
./init-config.sh lite
```

3.构建OpenCV
```
cd contrib
./compile-opencv.sh arm64
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
