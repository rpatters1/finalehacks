#import <objc/runtime.h>
#import "FinaleHackManager.h"
#import "FinaleHackList.h"

void registerMusViewHack() {
    [FinaleHackManager registerHackWithName:@"MusViewHack" block:^{
        id MusViewClass = objc_getClass("MusView");
        if (!MusViewClass) {
            NSLog(@"MusViewHack Error: MusView class not found. Skipping hack installation.");
            return;
        }

        Method displayMethod = class_getInstanceMethod(MusViewClass, @selector(display));
        if (!displayMethod) {
            NSLog(@"MusViewHack Error: Failed to retrieve display selector for MusView class. Skipping hack installation.");
            return;
        }

        IMP originalImplementation = method_getImplementation(displayMethod);
        if (!originalImplementation) {
            NSLog(@"MusViewHack Error: Failed to get the implementation of display method. Skipping hack installation.");
            return;
        }

        IMP newImplementation = imp_implementationWithBlock(^(id blockSelf) {
            if (objc_getAssociatedObject(blockSelf, @selector(display))) {
                NSLog(@"MusViewHack disabled recursive call to MusView display selector.");
                return;
            }

            objc_setAssociatedObject(blockSelf, @selector(display), @YES, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

            // Run the original method code.
            ((void (*)(id))originalImplementation)(blockSelf);

            objc_setAssociatedObject(blockSelf, @selector(display), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        });

        method_setImplementation(displayMethod, newImplementation);

        NSLog(@"MusViewHack applied.");
    }];
}
