#import "FinaleHackManager.h"

@implementation FinaleHackManager

static NSMutableDictionary<NSString *, HackBlock> *hacks;

+ (void)initialize {
    if (self == [FinaleHackManager class]) {
        hacks = [NSMutableDictionary dictionary];
    }
}

+ (void)registerHackWithName:(NSString *)name block:(HackBlock)block {
    if (name && block) {
        hacks[name] = [block copy];
    } else {
        NSLog(@"FinaleHackManager Error: Attempt to register hack with invalid name or block.");
    }
}

+ (void)applyAllHacks {
    for (NSString *name in hacks) {
        HackBlock block = hacks[name];
        if (block) {
            NSLog(@"Applying hack: %@", name);
            block();
        }
    }
}

@end
