INSTALL_DIR = /Library/Application\ Support/MakeMusic/Finale\ 27/Plug-ins

BUILD_DIR = Finale\ Hacks
RELEASE_BUILD_DIR = ${BUILD_DIR}/Release
DEBUG_BUILD_DIR = ${BUILD_DIR}/Debug

all:
	mkdir -p ${RELEASE_BUILD_DIR}/'Finale Hacks.bundle/Contents/MacOS'
	cc -dynamiclib -arch x86_64 -arch arm64 -o ${RELEASE_BUILD_DIR}/'Finale Hacks.bundle/Contents/MacOS/Finale Hacks' src/FinaleHacks.m -framework Foundation
	cp Info.plist ${RELEASE_BUILD_DIR}/'Finale Hacks.bundle/Contents'

install: all
	rm -rf ${INSTALL_DIR}/Finale\ Hacks
	cp -r ${RELEASE_BUILD_DIR} ${INSTALL_DIR}/Finale\ Hacks

debug:
	mkdir -p ${DEBUG_BUILD_DIR}/'Finale Hacks.bundle/Contents/MacOS'
	cc -dynamiclib -g -O0 -arch x86_64 -arch arm64 -o ${DEBUG_BUILD_DIR}/'Finale Hacks.bundle/Contents/MacOS/Finale Hacks' src/FinaleHacks.m -framework Foundation
	cp Info.plist ${DEBUG_BUILD_DIR}/'Finale Hacks.bundle/Contents'

clean:
	rm -rf 'Finale Hacks'
