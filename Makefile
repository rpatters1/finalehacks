INSTALL_DIR = /Library/Application\ Support/MakeMusic/Finale\ 27/Plug-ins

BUILD_DIR = Finale\ Hacks
RELEASE_DIR = ${BUILD_DIR}/Release
DEBUG_DIR = ${BUILD_DIR}/Debug
BUNDLE_DIR = Finale\ Hacks.bundle/Contents

CXX = c++  # Use the C++ compiler
CXXFLAGS = -std=c++17 -mmacosx-version-min=10.10 -dynamiclib -framework Foundation -x objective-c++
ARCH_FLAGS = -arch x86_64 -arch arm64

all:
	mkdir -p ${RELEASE_DIR}/${BUNDLE_DIR}/MacOS
	${CXX} ${CXXFLAGS} ${ARCH_FLAGS} -o ${RELEASE_DIR}/${BUNDLE_DIR}/MacOS/'Finale Hacks' src/FinaleHacks.m
	cp Info.plist ${RELEASE_DIR}/${BUNDLE_DIR}

install: all
	rm -rf ${INSTALL_DIR}/Finale\ Hacks
	cp -r ${RELEASE_DIR} ${INSTALL_DIR}/Finale\ Hacks

debug:
	mkdir -p ${DEBUG_DIR}/${BUNDLE_DIR}/MacOS
	${CXX} ${CXXFLAGS} -g -O0 ${ARCH_FLAGS} -o ${DEBUG_DIR}/${BUNDLE_DIR}/MacOS/'Finale Hacks' src/FinaleHacks.m
	cp Info.plist ${DEBUG_DIR}/${BUNDLE_DIR}

clean:
	rm -rf 'Finale Hacks'
