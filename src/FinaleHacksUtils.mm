#import "FinaleHacksUtils.h"
#import <dlfcn.h>

namespace utils {

NSBundle *getThisBundle() {
  static NSBundle *retval = nil;
  if (!retval) {
    Dl_info info;
    if (dladdr((void *)getThisBundle, &info)) {
      // Get the bundle path using the executable's address
      NSString *executablePath = [NSString stringWithUTF8String:info.dli_fname];
      NSRange range = [executablePath rangeOfString:@"/Contents/MacOS/"
                                            options:NSBackwardsSearch];
      if (range.location != NSNotFound) {
        NSString *bundlePath = [executablePath substringToIndex:range.location];
        retval = [NSBundle bundleWithPath:bundlePath];
      } else {
        NSLog(@"unable to back up to bundle path from '%@'", executablePath);
      }
    }
    if (!retval) {
      NSLog(@"Unable to find FinaleHacks bundle");
    }
  }
  return retval;
}

NSString *getLocalizedString(NSString *stringKey) {
  NSString *retval = NSLocalizedStringFromTableInBundle(
      stringKey, @"Localizable", getThisBundle(), nil);
  if (!retval || [retval isEqualTo:stringKey]) {
    NSLog(@"Localizable string not found for %@", stringKey);
    retval = stringKey;
  }
  return retval;
}

} // namespace utils