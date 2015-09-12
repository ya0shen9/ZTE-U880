ifeq (1,1)
PRODUCT_PACKAGES +=  \
	tcpdump \
	iperf \
	iwconfig \
	iwlist \
	iwpriv \
	iwspy \
	iwgetid \
	iwevent \
	hciconfig \
	hcitool \
	macadd \
	amixer \
	aplay \
	ipv6-network-manager \
	mlan2040coex \
	mlanconfig \
	mlanevent.exe \
	rfkill \
	uaputl.exe \
	uical_test 

#add for phonelocation
PRODUCT_PACKAGES += libphoneloc_jni


else
PRODUCT_PACKAGES +=  \
	FileManager \
	HDMISetting \
	FMRadio \
	FMTransmitter \
	procrank \
	MBBMSPlayer \
	libmbbmslog \
	testif228 \
	testmbbms \
	orientationd \
	geomagneticd \
	amixer \
	aplay \
	rfkill \
	iperf \
	uaputl.exe \
	mlanevent.exe \
	mlan2040coex \
	mlanconfig \
	kexec.exe \
	wireless_tool \
	iwconfig \
	iwlist \
	iwpriv \
	iwspy \
	iwgetid \
	iwevent \
	ifrename \
	sdptool \
	hciconfig \
	hcitool \
	l2ping \
	hciattach \
	rfcomm \
	avinfo \
	macadd \
	PowerSetting \
	Organ \
	mlan2040coex \
	mlanconfig \
	mlanevent.exe \
	uaputl.exe \
	NetworkInfo \
	UsbSetting \
	libPowerSetting \
	libGLESv1_CM_MRVL \
	libGLESv2_MRVL \
	libEGL_MRVL \
	uical_test \
	avinfo \
	hcitool \
	l2ping \
	rfcomm \
	gralloc.mrvl \
	WapiCertMgmt \
	libnfc \
	libnfc_ndef \
	libnfc_jni \
	Nfc \
	Tag \
	com.android.nfc_extras \
	com.android.nfc_extras.xml \
	CallSetting \
	ipv6-network-manager \
	logtools \
	libmtelif \
	liblsm_gsd4t.so \
	csr_gps.conf \
	sirfgps.conf \
	AGPS_CA_CMCC.pem \
	tcpdump \
	simal
endif

#include vendor/marvell/u880/cpufreqd/cpufreq_modules.mk
include device/zte/Mu880/cpufreqd/cpufreq_modules.mk
