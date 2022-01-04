//
//  UITextView+LWGrayTheme.m
//  LWGrayTheme
//
//  Created by jk_wlw on 2022/1/4.
//

#import "UITextView+LWGrayTheme.h"
#include <objc/runtime.h>
#import "LWGrayThemeManager.h"

@implementation UITextView (LWGrayTheme)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selectors[] = {
            @selector(setTextColor:),
        };
        for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
            SEL systemSel = selectors[index];
            SEL swizzSel = NSSelectorFromString([@"lw_" stringByAppendingString:NSStringFromSelector(systemSel)]);
            Method systemMethod = class_getInstanceMethod([self class], systemSel);
            Method swizzMethod = class_getInstanceMethod([self class], swizzSel);
            method_exchangeImplementations(systemMethod, swizzMethod);
        }
    });
}

- (void)lw_setTextColor:(UIColor *)textColor {
    if ([LWGrayThemeManager hasUIView:self]) {
        UIColor *newColor = [LWGrayThemeManager makeGrayColor:textColor];
        [self lw_setTextColor:newColor];
    } else {
        [self lw_setTextColor:textColor];
    }
}

@end
