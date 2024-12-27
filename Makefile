INSTALL_DIR = /Library/Application\ Support/MakeMusic/Finale\ 27/Plug-ins

BUILD_DIR = Finale\ Hacks
RELEASE_DIR = ${BUILD_DIR}/Release
DEBUG_DIR = ${BUILD_DIR}/Debug
BUNDLE_DIR = Finale\ Hacks.bundle/Contents

CXX = c++  # Use the C++ compiler
CXXFLAGS = -std=c++17 -Wall -mmacosx-version-min=10.10 -dynamiclib -framework Cocoa -I./src
ARCH_FLAGS = -arch x86_64 -arch arm64
SRC_FILES = src/FinaleHackManager.mm \
			src/FinaleWorkarounds.mm \
			src/MusViewHack.mm \
			src/ModelessDialogHack.mm
DEBUG_FLAGS = -g -O0 -D_DEBUG
RELEASE_FLAGS = -O2

all:
	mkdir -p ${RELEASE_DIR}/${BUNDLE_DIR}/MacOS
	${CXX} ${CXXFLAGS} ${RELEASE_FLAGS} ${ARCH_FLAGS} -o ${RELEASE_DIR}/${BUNDLE_DIR}/MacOS/'Finale Hacks' ${SRC_FILES}
	cp Info.plist ${RELEASE_DIR}/${BUNDLE_DIR}

install: all
	rm -rf ${INSTALL_DIR}/Finale\ Hacks
	cp -r ${RELEASE_DIR} ${INSTALL_DIR}/Finale\ Hacks

debug:
	mkdir -p ${DEBUG_DIR}/${BUNDLE_DIR}/MacOS
	${CXX} ${CXXFLAGS} ${DEBUG_FLAGS} ${ARCH_FLAGS} -o ${DEBUG_DIR}/${BUNDLE_DIR}/MacOS/'Finale Hacks' ${SRC_FILES}
	cp Info.plist ${DEBUG_DIR}/${BUNDLE_DIR}

clean:
	rm -rf 'Finale Hacks'
