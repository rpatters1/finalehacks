#import <objc/runtime.h>
#import "FinaleHackManager.h"
#import "FinaleHackList.h"
#import "FinaleHacksUtils.h"

// Static key for detecting plugin windows.
static const void *kIsPluginWindowKey = &kIsPluginWindowKey;

void registerModelessDialogHack() {
  [FinaleHackManager registerHackWithName:@"ModelessDialogHack" block:^{
    Method canBecomeMainWindowMethod = class_getInstanceMethod([NSWindow class], @selector(canBecomeMainWindow));
    if (!canBecomeMainWindowMethod) {
      NSLog(@"ModelessDialogHack Error: Failed to retrieve canBecomeMainWindow selector for NSWindow class. Skipping hack installation.");
      return;
    }

    IMP originalImplementation = method_getImplementation(canBecomeMainWindowMethod);
    if (!originalImplementation) {
      NSLog(@"ModelessDialogHack Error: Failed to get the implementation of canBecomeMainWindow method. Skipping hack installation.");
      return;
    }

    IMP newImplementation = imp_implementationWithBlock(^(id self, SEL _cmd) {
      BOOL currValue = ((BOOL (*)(id, SEL))originalImplementation)(self, _cmd);            
      NSWindow* win = (NSWindow*)self;
      if (currValue && objc_getAssociatedObject(win, kIsPluginWindowKey)) {
        DEBUG_CODE(NSLog(@"Returning canBecomeMainWindowMethod NO for %@", [win title]));
        return NO;
      }
      return currValue;
    });

    method_setImplementation(canBecomeMainWindowMethod, newImplementation);

    // Event monitor for NSWindowDidBecomeKeyNotification
    [[NSNotificationCenter defaultCenter] addObserverForName:NSWindowDidBecomeKeyNotification
                                                      object:nil
                                                      queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *notification) {
      NSWindow *win = notification.object;
      if (![win isKindOfClass:[NSWindow class]]) return;

      const BOOL couldBeModelessPlugin = !win.isModalPanel
                                       && (win.level == NSFloatingWindowLevel || win.level == NSNormalWindowLevel)
                                       && ![win.title isEqualToString:@""]
                                       && win.canBecomeMainWindow;
      if (couldBeModelessPlugin) {
        DEBUG_CODE(NSLog(@"Window %@ is a %@ and has delegate class %@", [win title], NSStringFromClass([win class]), NSStringFromClass([win.delegate class])));
        if ([win isKindOfClass:NSClassFromString(@"EDLGWindow")]) {       // FX_Dialog plugin windows
          DEBUG_CODE(NSLog(@"Hacked FX_Dialog window %@", [win title]));
          objc_setAssociatedObject(win, kIsPluginWindowKey, @YES, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        } else if ([NSStringFromClass([win.delegate class]) hasPrefix:@"_NSWindowDelegate_jw"]) {    // JW Tools plugin windows
          // we use the associated value, because JW Tools plugins in particular lose their delegates for some reason
          DEBUG_CODE(NSLog(@"Hacked JW Tools window %@", [win title]));
          objc_setAssociatedObject(win, kIsPluginWindowKey, @YES, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        } else if ([win.title isEqualTo:utils::getLocalizedString(@"IDSTR_SPACE_SYSTEMS_WINDOW_TITLE")]) { // Space Systems (originally from JW)
          DEBUG_CODE(NSLog(@"Hacked window %@", [win title]));
          objc_setAssociatedObject(win, kIsPluginWindowKey, @YES, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        if (objc_getAssociatedObject(win, kIsPluginWindowKey) && !win.hidesOnDeactivate) {
          DEBUG_CODE(NSLog(@"Setting window %@ hidesOnDeactivate = YES", [win title]));
          win.hidesOnDeactivate = true;
        }
      }
    }];

    NSLog(@"ModelessDialogHack applied.");
  }];
}
