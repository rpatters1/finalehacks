# Finale Hacks

Finale Hacks is a custom plug-in for MakeMusic Finale 27 (and possibly earlier versions, but no guarantees) that
patches their code to work around known bugs.

Please file bugs with the correct tag.  For problems where the plug-in fails to fix a bug that it claims to fix,
file under Plug-in Bug.  For new bugs in Finale that you'd like someone to try to work around, file under
Finale Bug.

---

## Version History

### 1.0

Fixes a bug that can cause crashes when deleting notes using Simple Edit (and possibly at other times).  Crash signature:

```
0   libsystem_kernel.dylib        	       0x1885aaa60 __pthread_kill + 8
1   libsystem_pthread.dylib       	       0x1885e2c20 pthread_kill + 288
2   libsystem_c.dylib             	       0x1884efa30 abort + 180
3   libswiftCore.dylib            	       0x1986559f4 swift::fatalErrorv(unsigned int, char const*, char*) + 128
4   libswiftCore.dylib            	       0x198655a14 swift::fatalError(unsigned int, char const*, ...) + 32
5   libswiftCore.dylib            	       0x198656008 swift::runtime::AccessSet::insert(swift::runtime::Access*, void*, void*, swift::ExclusivityFlags) + 536
6   libswiftCore.dylib            	       0x19865605c swift_beginAccess + 84
7   AppKit                        	       0x18c2d3124 0x18bee6000 + 4116772
8   AppKit                        	       0x18c2d34a8 0x18bee6000 + 4117672
9   AppKit                        	       0x18c56d9f0 -[NSViewBackingLayer display] + 820
10  AppKit                        	       0x18c9c434c __25-[NSView displayIfNeeded]_block_invoke + 184
11  AppKit                        	       0x18bf628a4 NSPerformVisuallyAtomicChange + 108
12  AppKit                        	       0x18bfc8974 -[NSView displayIfNeeded] + 192
13  Finale                        	       0x1024a8ea0 -[MusView display] + 96
...
21  Finale                        	       0x1024aa35c -[MusView drawRect:] + 560
...
38  Finale                        	       0x1024a8ea0 -[MusView display] + 96
...
```
