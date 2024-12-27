
#import <objc/runtime.h>
#import <Foundation/Foundation.h>

@interface FinaleWorkarounds : NSObject

@end

@implementation FinaleWorkarounds

+ (void)load {
  NSLog(@"Hacking Finale to work around bugs.");

  id MusViewClass = objc_getClass("MusView");
  if (!MusViewClass) {
    NSLog(@"Finale Hacks Error: MusView class not found. Skipping hack installation.");
    return;
  }

  Method displayMethod = class_getInstanceMethod(MusViewClass, @selector(display));
  if (!displayMethod) {
    NSLog(@"Finale Hacks Error: Failed to retrieve display selector for MusView class. Skipping hack installation.");
    return;
  }

  IMP originalImplementation = method_getImplementation(displayMethod);
  if (!originalImplementation) {
    NSLog(@"Finale Hacks Error: Failed to get the implementation of display method. Skipping hack installation.");
    return;
  }

  IMP newImplementation = imp_implementationWithBlock(^(id blockSelf) {
    if (objc_getAssociatedObject(blockSelf, @selector(display))) {
      NSLog(@"Finale Hacks disabled recursive call to MusView display selector.");
      return;
    }

    objc_setAssociatedObject(blockSelf, @selector(display), @YES, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    // Run the original method code.
    ((void (*)(id))originalImplementation)(blockSelf);

    objc_setAssociatedObject(blockSelf, @selector(display), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  });

  method_setImplementation(displayMethod, newImplementation);
  
  NSLog(@"Done hacking Finale to work around bugs.");
}

@end

