#import "FinaleHackList.h"
#import "FinaleHackManager.h"

@interface FinaleWorkarounds : NSObject
@end

@implementation FinaleWorkarounds

+ (void)load {
  NSLog(@"Hacking Finale to work around bugs.");

  /// @todo possible suppress hack registration based on a config file
  registerMusViewHack();
  registerModelessDialogHack();

  [FinaleHackManager applyAllHacks];

  NSLog(@"Done hacking Finale to work around bugs.");
}

@end
