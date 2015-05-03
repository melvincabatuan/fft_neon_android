LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE    := fftinterface
LOCAL_C_INCLUDES :=\
	$(LOCAL_PATH)/code/inc
LOCAL_SRC_FILES := \
	code/src/com_example_fftdemo_testfft.cpp\
	code/src/test_suite_fft_int16.c\
	code/src/NE10_fft_int16.c\
	code/src/NE10_fft_int16.c.neon.c\
	code/src/fft_fixed_point.c\
#-g �����һϵ����Ŀ����˲���ʹ��arm_neon-hͷ�ļ�, -mfloat-abi=softfp -mfpu=neon ʹ��arm_neon.h����  
LOCAL_CFLAGS:= -g -mfloat-abi=softfp -mfpu=neon -march=armv7-a  -mtune=cortex-a8 
LOCAL_LDLIBS:=-lz -llog -ldl
TARGET_ARCH_ABI := armeabi-v7a
LOCAL_ARM_MODE := arm


ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
	LOCAL_ARM_NEON:=true
	#LOCAL_CFLAGS := -DHAVE_NEON=1
	LOCAL_SRC_FILES += code/src/NE10_fft_int16.s.neon.s
	
endif
LOCAL_STATIC_LIBRARIES := cpufeatures

include $(BUILD_SHARED_LIBRARY)
$(call import-module,cpufeatures)