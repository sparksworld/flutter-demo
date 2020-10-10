#import "UsthSparkSharePlugin.h"
#if __has_include(<usth_spark_share/usth_spark_share-Swift.h>)
#import <usth_spark_share/usth_spark_share-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "usth_spark_share-Swift.h"
#endif

@implementation UsthSparkSharePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftUsthSparkSharePlugin registerWithRegistrar:registrar];
}
@end
