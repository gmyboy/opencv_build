#!/usr/bin/env bash
# https://docs.opencv.org/master/db/d05/tutorial_config_reference.html
# OpenCV build type
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_SHARED_LIBS=ON"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_ANDROID_PROJECTS=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_ANDROID_EXAMPLES=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DANDROID_PROJECTS_BUILD_TYPE=GRADLE"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_ANDROID_SERVICE=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_FAT_JAVA_LIB=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_JAVA=ON"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_DOCS=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_EXAMPLES=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_PACKAGE=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_TESTS=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_PERF_TESTS=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_WITH_DEBUG_INFO=OFF"
# install examples or docs, default all is OFF
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DINSTALL_TESTS=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DINSTALL_C_EXAMPLES=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DINSTALL_BIN_EXAMPLES=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DINSTALL_PYTHON_EXAMPLES=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DINSTALL_ANDROID_EXAMPLES=OFF"
# build options
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_WITH_DYNAMIC_IPP=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_CUDA_STUBS=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DOPENCV_ENABLE_NONFREE=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DCV_TRACE=ON"
# build components list
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_aruco=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_besegm=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_calib3d=ON"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_core=ON"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_ccalib=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_dnn=ON"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_dpm=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_features2d=ON"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_flann=ON"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_face=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_gapi=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_highgui=ON"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_imgcodecs=ON"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_imgproc=ON"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_ittnotify=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_java=ON"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_java_bindings_generator=ON"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_ml=ON"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_objdetect=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_photo=ON"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_python2=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_python3=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_python_bindings_generator=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_apps=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_js=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_rgbd=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_saliency=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_stereo=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_structured_light=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_stitching=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_text=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_ts=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_tracking=ON"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_video=ON"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_videoio=ON"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_videostab=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_opencv_world=ON"
# build 3rd party
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_ZLIB=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_TIFF=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_JASPER=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_JPEG=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_PNG=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_OPENEXR=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_WEBP=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_TBB=ON"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_IPP_IW=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DBUILD_ITT=OFF"
# image reading and writing
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_PNG=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_JPEG=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_TIFF=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_WEBP=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_OPENJPEG=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_JASPER=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_OPENEXR=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_GDAL=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_GDCM=OFF"
# video reading and writing
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_V4L=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_FFMPEG=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_GSTREAMER=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_MSMF=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_DSHOW=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_AVFOUNDATION=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_VIDEO_ENABLE_PLUGINS=OFF"
# other backends
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_1394=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_OPENNNI=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_OPENNNI2=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_PVAPI=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_ARAVIS=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_XIMEA=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_XINE=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_ANDROID_MEDIANDK=OFF"
# parallel processing
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_PTHREADS_PF=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_TBB=ON"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_OPENMP=ON"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_HPX=OFF"
# GUI backends
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_GTK=ON"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_WIN32UI=ON"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_QT=OFF"
# with optional 3rd party components
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_ARITH_DEC=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_ARITH_ENC=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_CUDA=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_CUBLAS=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_CUFFT=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_IPP=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_IPP_A=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_MATLAB=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_NVCUVID=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_OPENGL=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_OPENVX=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_PROTOBUF=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_VULKAN=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_VA_INTEL=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DOPENCV_DNN_OPENCL=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_CAROTENE=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_DIRECTX=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_HALIDE=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_INF_ENGINE=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_OPENCL=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_OPENCLAMDFFT=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_OPENCLAMDBLAS=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_OPENCL_SVM=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_QUIRC=OFF"
export COMMON_CV_CFG_FLAGS="$COMMON_CV_CFG_FLAGS -DWITH_VTK=OFF"