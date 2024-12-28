#import <Cocoa/Cocoa.h>

#ifdef _DEBUG // defined or not on the compiler command line
#define DEBUG_CODE(C) C
#else
#define DEBUG_CODE(C)
#endif

typedef void(^ HackBlock)(void);

@interface FinaleHackManager : NSObject

+ (void)registerHackWithName:(NSString *)name block:(HackBlock)block;
+ (void)applyAllHacks;

@end
