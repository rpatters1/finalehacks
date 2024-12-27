#import "FinaleHackManager.h"
#import "MusViewHack.h"

@interface FinaleWorkarounds : NSObject
@end

@implementation FinaleWorkarounds

+ (void)load {
    NSLog(@"Hacking Finale to work around bugs.");

    /// @todo possible suppress hack registration based on a config file
    registerMusViewHack();

    [FinaleHackManager applyAllHacks];

    NSLog(@"Done hacking Finale to work around bugs.");
}

@end
