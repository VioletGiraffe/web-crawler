TEMPLATE = app
TARGET   = web-crawler

CONFIG += console
CONFIG += c++14

QT = core

mac* | linux*{
	CONFIG(release, debug|release):CONFIG += Release
	CONFIG(debug, debug|release):CONFIG += Debug
}

contains(QT_ARCH, x86_64) {
	ARCHITECTURE = x64
} else {
	ARCHITECTURE = x86
}

exists(../local_settings.pri){
	include(../local_settings.pri)
}

Release:OUTPUT_DIR=release/$${ARCHITECTURE}
Debug:OUTPUT_DIR=debug/$${ARCHITECTURE}

DESTDIR  = ../bin/$${OUTPUT_DIR}
OBJECTS_DIR = ../build/$${OUTPUT_DIR}/$${TARGET}
MOC_DIR     = ../build/$${OUTPUT_DIR}/$${TARGET}
UI_DIR      = ../build/$${OUTPUT_DIR}/$${TARGET}
RCC_DIR     = ../build/$${OUTPUT_DIR}/$${TARGET}

INCLUDEPATH += \
	$$PWD/src/ \
	../cpputils \
	../cpp-template-utils \
	../libcurl-cpp/src \
	$${VCPKG_INSTALLS_PATH}/include

LIBS += -L../bin/$${OUTPUT_DIR} -lcurl_cpp -lcpputils

Debug:LIBS += -L$${VCPKG_INSTALLS_PATH}/Debug/lib
Release:LIBS += -L$${VCPKG_INSTALLS_PATH}/lib
LIBS += -llibcurl

win*{
	QMAKE_CXXFLAGS += /MP /wd4251
	QMAKE_CXXFLAGS_WARN_ON = /W4
	DEFINES += WIN32_LEAN_AND_MEAN NOMINMAX _SCL_SECURE_NO_WARNINGS

	!*msvc2013*:QMAKE_LFLAGS += /DEBUG:FASTLINK

	Debug:QMAKE_LFLAGS += /INCREMENTAL
	Release:QMAKE_LFLAGS += /OPT:REF /OPT:ICF
}

linux*|mac*{
	QMAKE_CXXFLAGS_WARN_ON = -Wall -Wno-c++11-extensions -Wno-local-type-template-args -Wno-deprecated-register

	Release:DEFINES += NDEBUG=1
	Debug:DEFINES += _DEBUG
}

win32*:!*msvc2012:*msvc* {
	QMAKE_CXXFLAGS += /FS
}


mac*|linux*{
	PRE_TARGETDEPS += $${DESTDIR}/cpputils.a
}

SOURCES += \
	src/main.cpp
