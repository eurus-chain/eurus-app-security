#import "AppSecurityKitPlugin.h"
#if __has_include(<app_security_kit/app_security_kit-Swift.h>)
#import <app_security_kit/app_security_kit-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "app_security_kit-Swift.h"
#endif

@implementation AppSecurityKitPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAppSecurityKitPlugin registerWithRegistrar:registrar];
}
@end
