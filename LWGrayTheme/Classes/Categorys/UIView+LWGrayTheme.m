//
//  UIView+LWGrayTheme.m
//  handhelddoctor
//
//  Created by lw_wlw on 2021/12/28.
//  Copyright © 2021 gzJianke. All rights reserved.
//

#import "UIView+LWGrayTheme.h"
#include <objc/runtime.h>
#import "LWGrayThemeManager.h"

@implementation UIView (LWGrayTheme)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selectors[] = {
            @selector(setBackgroundColor:),
            @selector(setTintColor:),
            @selector(addSubview:),
            @selector(insertSubview:atIndex:),
            @selector(insertSubview:belowSubview:),
            @selector(insertSubview:aboveSubview:),
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

- (void)lw_insertSubview:(UIView *)view atIndex:(NSInteger)index {
    if ([LWGrayThemeManager hasUIView:self]) {
        [LWGrayThemeManager handleGrayThemeWithSuperView:view];
    }
    [self lw_insertSubview:view atIndex:index];
}

- (void)lw_insertSubview:(UIView *)view aboveSubview:(UIView *)siblingSubview {
    if ([LWGrayThemeManager hasUIView:self]) {
        [LWGrayThemeManager handleGrayThemeWithSuperView:view];
    }
    [self lw_insertSubview:view aboveSubview:siblingSubview];
}

- (void)lw_insertSubview:(UIView *)view belowSubview:(UIView *)siblingSubview {
    if ([LWGrayThemeManager hasUIView:self]) {
        [LWGrayThemeManager handleGrayThemeWithSuperView:view];
    }
    [self lw_insertSubview:view belowSubview:siblingSubview];
}

- (void)lw_addSubview:(UIView *)view {
    [self lw_addSubview:view];
     if ([LWGrayThemeManager hasUIView:self]) {
         [LWGrayThemeManager handleGrayThemeWithSuperView:view];
     }
}

- (void)lw_setBackgroundColor:(UIColor *)backgroundColor {
    if ([LWGrayThemeManager hasUIView:self]) {
        UIColor *newColor = [LWGrayThemeManager makeGrayColor:backgroundColor];
        [self lw_setBackgroundColor:newColor];
    } else {
        [self lw_setBackgroundColor:backgroundColor];
    }
}

- (void)lw_setTintColor:(UIColor *)tintColor {
    if ([LWGrayThemeManager hasUIView:self]) {
        UIColor *newColor = [LWGrayThemeManager makeGrayColor:tintColor];
        [self lw_setTintColor:newColor];
    } else {
        [self lw_setTintColor:tintColor];
    }
}

@end
