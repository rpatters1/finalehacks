
INSTALL_DIR = /Library/Application\ Support/MakeMusic/Finale\ 27/Plug-ins

all:
	mkdir -p 'Finale Hacks/Finale Hacks.bundle/Contents/MacOS'
	cc -dynamiclib -arch x86_64 -arch arm64 -o 'Finale Hacks/Finale Hacks.bundle/Contents/MacOS/Finale Hacks' FinaleHacks.m -framework Foundation
	cp Info.plist 'Finale Hacks/Finale Hacks.bundle/Contents'

install:
	rm -rf ${INSTALL_DIR}/Finale\ Hacks
	cp -r 'Finale Hacks' ${INSTALL_DIR}

clean:
	rm -rf 'Finale Hacks'
