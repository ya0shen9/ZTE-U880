
# Discard inherited values and use our own instead.

ifeq (1,1)
PRODUCT_PACKAGES := \
    AccountAndSyncSettings \
    DeskClock \
    AlarmProvider \
    Bluetooth \
    Calculator \
    Camera \
    CertInstaller \
    DrmProvider \
    Email \
    Provision \
    QuickSearchBox \
    Settings \
    Superuser \
    Sync \
    SystemUI \
    Updater \
    SyncProvider \
    CalendarProvider \
    BladeParts \

else
PRODUCT_PACKAGES := \
	AccountAndSyncSettings \
	DeskClock \
    AlarmProvider \
	Bluetooth \
	Calculator \
    Calendar \
	Camera \
    CertInstaller \
    DrmProvider \
	Email \
	LatinIME \
	Launcher2 \
	Mms \
	Music \
    Protips \
	QuickSearchBox \
	Settings \
    Sync \
    Updater \
    CalendarProvider \
    SyncProvider \
	LiveWallpapers \
	LiveWallpapersPicker \
	MagicSmokeWallpapers \
	VisualizationWallpapers \
	Fallback \
	ApiDemos \
	Development \
	SdkSetup \
	NotePad \
	Stk \
	SoundRecorder \
	SystemUI \
	libext4_utils \
	make_ext4fs \
	setup_fs \
	OtaUpdater \

endif

#liuhao removed, use PicFolder.apk 
#    Gallery3D \
#    Protips \


#include vendor/device/zte/optional_packages.mk
include device/zte/Mu880/optional_packages.mk

$(call inherit-product, $(SRC_TARGET_DIR)/product/core.mk)

#include the ringtones.
#include frameworks/base/data/sounds/AudioPackage2.mk

# Get a full list of languages.
$(call inherit-product, build/target/product/languages_full.mk)

# # Get the TTS language packs
$(call inherit-product-if-exists, external/svox/pico/lang/all_pico_languages.mk)

# Overrides

#DEVICE_PACKAGE_OVERLAYS := vendor/device/zte/overlay
DEVICE_PACKAGE_OVERLAYS := device/device/zte/overlay

PRODUCT_COPY_FILES += \
	vendor/device/zte/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml \
	vendor/device/zte/prebuilt/common/etc/cpufreqd.conf:system/etc/cpufreqd.conf \
        vendor/device/zte/prebuilt/common/etc/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
        vendor/device/zte/proprietary/etc/permissions/hw-features.xml:system/etc/permissions/hw-features.xml

#add google app backup tool
PRODUCT_COPY_FILES += \
    vendor/device/zte/prebuilt/common/bin/backuptool.sh:system/bin/backuptool.sh \


#liuhao add gtalk lib
PRODUCT_COPY_FILES += \
    packages/apps/GoogleApp/lib/libmicrobes_jni.so:/system/lib/libmicrobes_jni.so \
    packages/apps/GoogleApp/lib/libtalk_jni.so:/system/lib/libtalk_jni.so


# u880 product name
PRODUCT_MODEL := u880
PRODUCT_BRAND := ZTE
PRODUCT_NAME := zte_u880 
PRODUCT_DEVICE := u880
PRODUCT_MANUFACTURER := ZTE

BUILD_NUMBER := $(TARGET_BUILD_VARIANT).LeWa.$(shell date +%Y%m%d.%H%M%S)

# u880 only use two language for lewa branch
PRODUCT_LOCALES := zh_CN en_US zh_TW

# Blade uses high-density artwork where available
PRODUCT_LOCALES += hdpi


# Bring in all audio files
#include frameworks/base/data/sounds/AllAudio.mk
#include lewa/frameworks/base/data/sounds/LewaAudio.mk

# Default ringtone
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.ringtone=Champagne_Edition.ogg \
    ro.config.notification_sound=regulus.ogg \
    ro.config.alarm_alert=Alarm_Beep_03.ogg

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.timezone=Asia/Shanghai \
    media.stagefright.enable-player=true \
    media.stagefright.enable-meta=true \
    media.stagefright.enable-scan=true \
    media.stagefright.enable-http=true \
    ro.build.sw_internal_version=U880V1.0.1B11 \
    ro.build.sw_internal_time=$(shell date +%Y%m%d%H) \
    apps.setting.product.release=LeWa_ROM_$(PRODUCT_MODEL)_$(shell date +%y.%m.%d.%H) \
    ro.sf.lcd_density=240 \
    ro.build.sw_release_time=$(shell date +%s) \
    ro.product.customize=U880 \
    ro.product.internal_model=U880 \
    ro.product.td-network=true \
    ro.product.network=TD \
    ro.telephony.call_ring.multiple=false \
    ro.telephony.call_ring.absent=true


PRODUCT_PROPERTY_OVERRIDES += \
    mobiledata.interfaces=ccinet0 \
    ro.light.temp.settings=true

#If true, the window manager will do its own custom freezing and general
#management of the screen during rotation.
#confilct with busybox and skia of CM 7.2 version
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.rotationanimation=false

# added by george,for swapper
PRODUCT_PROPERTY_OVERRIDES += \
	ro.lewa.swapper.flash_swappiness=99 \
	ro.lewa.swapper.sd_swappiness=60

#add by shenqi for crach report
PRODUCT_PROPERTY_OVERRIDES += \
    ro.error.receiver.system.apps=com.lewa.fc \
    ro.error.receiver.default=com.lewa.fc

#universal setting
PRODUCT_PACKAGES += \
    LewaLauncher \
    libmarvell/u880-dsp \
    Pacman \
    screenshot \
    CMScreenshot

#    CMParts \
    
#PRODUCT_PACKAGES += \
#    LewaFc \
#    LewaPush \
#    LewaFeedback \
#    ThirdCrop

# add by wangfan 2012-06-28
#PRODUCT_PACKAGES += \
#    LewaSearch

PRODUCT_COPY_FILES += \
    packages/apps/GoogleApp/etc/permissions/features.xml:/system/etc/permissions/features.xml \
    packages/apps/GoogleApp/etc/permissions/com.google.android.maps.xml:/system/etc/permissions/com.google.android.maps.xml \
    packages/apps/GoogleApp/framework/com.google.android.maps.jar:/system/framework/com.google.android.maps.jar \
    packages/apps/GoogleApp/lib/libvoicesearch.so:/system/lib/libvoicesearch.so \


#removed google app
ifeq (1,0)
PRODUCT_COPY_FILES += \
    packages/apps/GoogleApp/app/GoogleServicesFramework.apk:/system/app/GoogleServicesFramework.apk \
    packages/apps/GoogleApp/app/GoogleContactsSyncAdapter.apk:/system/app/GoogleContactsSyncAdapter.apk \
    packages/apps/GoogleApp/app/GoogleCalendarSyncAdapter.apk:/system/app/GoogleCalendarSyncAdapter.apk \
    packages/apps/GoogleApp/app/GoogleBackupTransport.apk:/system/app/GoogleBackupTransport.apk \
    packages/apps/GoogleApp/app/NetworkLocation.apk:/system/app/NetworkLocation.apk
endif


# default IME
#ifeq (1,0)
#PRODUCT_COPY_FILES += \
#	packages/apps/ThirdCrop/app/BaiduIME.apk:/system/app/BaiduIME.apk \
#	packages/apps/ThirdCrop/app/BaiduIME/libinputcore-2.so:/system/lib/libinputcore-2.so \
#	packages/apps/ThirdCrop/app/BaiduIME/libkpencore.so:/system/lib/libkpencore.so
#else
#PRODUCT_PACKAGES += LatinIME
#endif

#charge pic
PRODUCT_COPY_FILES += \
    device/zte/Mu880/res/images/charge0001.png:system/res/images/charge0001.png \
    device/zte/Mu880/res/images/charge0007.png:system/res/images/charge0007.png \
    device/zte/Mu880/res/images/charge0014.png:system/res/images/charge0014.png \
    device/zte/Mu880/res/images/charge0021.png:system/res/images/charge0021.png \
    device/zte/Mu880/res/images/charge0028.png:system/res/images/charge0028.png \
    device/zte/Mu880/res/images/charge0035.png:system/res/images/charge0035.png \
    device/zte/Mu880/res/images/charge0042.png:system/res/images/charge0042.png \
    device/zte/Mu880/res/images/chargefinish.png:system/res/images/chargefinish.png \
    device/zte/Mu880/res/images/nothing.png:system/res/images/nothing.png \


# All the blobs necessary for u880
#
# Copy DS specific prebuilt files
#
PRODUCT_COPY_FILES +=  \
    device/zte/Mu880/prebuilt/hdpi/media/bootanimation.zip:system/media/bootanimation.zip

# copy default lockscreen theme by shenqi 2011-12-29

#PRODUCT_COPY_FILES += \
#    lewa/frameworks/lockscreen/WVGA/lockscreen.zip:/system/media/lockscreen.zip \
#    lewa/frameworks/theme/WVGA/default.lwt:/system/media/default.lwt

#common.mk
PRODUCT_COPY_FILES += \
    device/zte/Mu880/prebuilt/common/etc/resolv.conf:system/etc/resolv.conf \
    device/zte/Mu880/prebuilt/common/etc/sysctl.conf:system/etc/sysctl.conf \
    device/zte/Mu880/prebuilt/common/etc/terminfo/l/linux:system/etc/terminfo/l/linux \
    device/zte/Mu880/prebuilt/common/etc/terminfo/u/unknown:system/etc/terminfo/u/unknown \
    device/zte/Mu880/prebuilt/common/etc/profile:system/etc/profile \
    device/zte/Mu880/prebuilt/common/etc/init.local.rc:system/etc/init.local.rc \
    device/zte/Mu880/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    device/zte/Mu880/prebuilt/common/etc/init.d/01sysctl:system/etc/init.d/01sysctl \
    device/zte/Mu880/prebuilt/common/etc/init.d/03firstboot:system/etc/init.d/03firstboot \
    device/zte/Mu880/prebuilt/common/etc/init.d/04modules:system/etc/init.d/04modules \
    device/zte/Mu880/prebuilt/common/etc/init.d/05mountsd:system/etc/init.d/05mountsd \
    device/zte/Mu880/prebuilt/common/etc/init.d/06mountdl:system/etc/init.d/06mountdl \
    device/zte/Mu880/prebuilt/common/etc/init.d/20userinit:system/etc/init.d/20userinit \
    device/zte/Mu880/prebuilt/common/etc/init.d/52sensor:system/etc/init.d/52sensor \
    device/zte/Mu880/prebuilt/common/etc/init.d/52sensor:system/bin/52sensor \


#    vendor/device/zte/prebuilt/common/bin/backuptool.sh:system/bin/backuptool.sh \
#    vendor/device/zte/prebuilt/common/bin/modelid_cfg.sh:system/bin/modelid_cfg.sh \
#    vendor/device/zte/prebuilt/common/bin/verify_cache_partition_size.sh:system/bin/verify_cache_partition_size.sh \
#    vendor/device/zte/prebuilt/common/bin/handle_compcache:system/bin/handle_compcache \
#    vendor/device/zte/prebuilt/common/bin/compcache:system/bin/compcache \
#    vendor/device/zte/prebuilt/common/bin/fix_permissions:system/bin/fix_permissions \
#    vendor/device/zte/prebuilt/common/bin/sysinit:system/bin/sysinit \


#    vendor/device/zte/prebuilt/common/xbin/htop:system/xbin/htop \
#    vendor/device/zte/prebuilt/common/xbin/irssi:system/xbin/irssi \
#    vendor/device/zte/prebuilt/common/xbin/powertop:system/xbin/powertop \
#    vendor/device/zte/prebuilt/common/xbin/openvpn-up.sh:system/xbin/openvpn-up.sh

PRODUCT_COPY_FILES += \
    device/zte/Mu880/prebuilt/common/etc/init.d/10apps2sd:system/etc/init.d/10apps2sd

# added by george,lewa,20111026
## auto swap
ifeq (1,0)
PRODUCT_COPY_FILES += \
    device/zte/Mu880/prebuilt/common/etc/init.d/07swap:system/etc/init.d/07swap \
    device/zte/Mu880/prebuilt/common/etc/swap.conf:system/etc/swap.conf
endif

# added by liuhao,lewa,remove /system/swap.img
PRODUCT_COPY_FILES += \
    device/zte/Mu880/prebuilt/common/etc/init.d/51clean:system/etc/init.d/51clean

# Woody Guo @ 2012/05/28
PRODUCT_COPY_FILES += \
    device/zte/Mu880/prebuilt/common/etc/init.partner.sh:system/etc/init.partner.sh


## gk's app2sd and data2ext script
#u880 can not support init.d
#PRODUCT_COPY_FILES += \
#    vendor/device/zte/prebuilt/common/etc/init.d/geno:system/etc/init.d/geno \
#    vendor/device/zte/prebuilt/common/misc/1-app2sd.sh:system/misc/1-app2sd.sh \
#    vendor/device/zte/prebuilt/common/misc/2-data2ext.sh:system/misc/2-data2ext.sh

# end added by george

# commented by lewa,shenqi
#PRODUCT_COPY_FILES +=  \
#   vendor/device/zte/proprietary/RomManager.apk:system/app/RomManager.apk 

# Enable SIP+VoIP on all targets
#PRODUCT_COPY_FILES += \
#    frameworks/base/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml


# call ZTE u880 vendor blobs
$(call inherit-product, device/zte/Mu880/u880-vendor-blobs.mk)
