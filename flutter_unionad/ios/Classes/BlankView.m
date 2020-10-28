//
//  BlankView.m
//  flutter_unionad
//
//  Created by 余振泉 on 2020/10/28.
//

#import "BlankView.h"

@implementation BlankView

- (BlankView *)init {
    self = [super init];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [self addGestureRecognizer:tap];
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"FlutterView"]) {
        return NO;
    }
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([NSStringFromClass([touches.anyObject class]) isEqualToString:@"FlutterView"]) {
    }
}

@end
