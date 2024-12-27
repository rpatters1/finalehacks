#import <Foundation/Foundation.h>

typedef void (^HackBlock)(void);

@interface FinaleHackManager : NSObject

+ (void)registerHackWithName:(NSString *)name block:(HackBlock)block;
+ (void)applyAllHacks;

@end
