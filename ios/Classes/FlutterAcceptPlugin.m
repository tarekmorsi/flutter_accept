#import "FlutterAcceptPlugin.h"
#if __has_include(<flutter_accept/flutter_accept-Swift.h>)
#import <flutter_accept/flutter_accept-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_accept-Swift.h"
#endif

@implementation FlutterAcceptPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterAcceptPlugin registerWithRegistrar:registrar];
}
@end
