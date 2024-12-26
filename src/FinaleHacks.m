
#import <objc/runtime.h>
#import <Foundation/Foundation.h>

@interface FinaleWorkarounds : NSObject

@end

@implementation FinaleWorkarounds

+ (void)load {
  NSLog(@"Hacking Finale to work around bugs.");
  id MusViewClass = objc_getClass("MusView");
  Method displayMethod = class_getInstanceMethod(MusViewClass, @selector(display));
  IMP originalImplementation = method_getImplementation(displayMethod);
  IMP newImplementation = imp_implementationWithBlock(^(id blockSelf) {
    if (objc_getAssociatedObject(blockSelf, @selector(display))) {
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

