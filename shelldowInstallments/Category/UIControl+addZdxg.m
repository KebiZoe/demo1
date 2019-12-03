//
//  UIControl+addZdxg.m
//  GooffWithLoan
//
//  Created by 曾祥宪 on 2018/9/27.
//  Copyright © 2018年 曾祥宪. All rights reserved.
//

#import "UIControl+addZdxg.h"

@implementation UIControl (addZdxg)
+ (void)load{
    method_exchangeImplementations(class_getInstanceMethod([self class], @selector(touchesBegan:withEvent:)), class_getInstanceMethod([self class], @selector(zxxtouchesBegan:withEvent:)));
}
- (void)zxxtouchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (@available(iOS 10.0, *)) {
        UIImpactFeedbackGenerator *feedBackGenertor = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
        [feedBackGenertor impactOccurred];
    } else {
        // Fallback on earlier versions
    }
    [self zxxtouchesBegan:touches withEvent:event];
}
@end
