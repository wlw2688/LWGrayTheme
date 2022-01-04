//
//  CALayer+LWGrayTheme.m
//  handhelddoctor
//
//  Created by lw_wlw on 2021/12/28.
//  Copyright © 2021 gzJianke. All rights reserved.
//

#import "CALayer+LWGrayTheme.h"
#include <objc/runtime.h>
#import "LWGrayThemeManager.h"


@implementation CALayer (LWGrayTheme)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selectors[] = {
            @selector(setBackgroundColor:),
            @selector(setBorderColor:),
            @selector(setShadowColor:),
            @selector(addSublayer:),
            @selector(insertSublayer:atIndex:),
            @selector(insertSublayer:below:),
            @selector(insertSublayer:above:),
            @selector(replaceSublayer:with:),
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

- (void)lw_addSublayer:(CALayer *)layer {
    if ([LWGrayThemeManager hasCALayer:self]) {
        [LWGrayThemeManager handleGrayThemeWithSuperLayer:layer];
    }
    [self lw_addSublayer:layer];
}

- (void)lw_insertSublayer:(CALayer *)layer atIndex:(unsigned)idx {
    if ([LWGrayThemeManager hasCALayer:self]) {
        [LWGrayThemeManager handleGrayThemeWithSuperLayer:layer];
    }
    [self lw_insertSublayer:layer atIndex:idx];
}

- (void)lw_insertSublayer:(CALayer *)layer below:(nullable CALayer *)sibling {
    if ([LWGrayThemeManager hasCALayer:self]) {
        [LWGrayThemeManager handleGrayThemeWithSuperLayer:layer];
    }
    [self lw_insertSublayer:layer below:sibling];
}

- (void)lw_insertSublayer:(CALayer *)layer above:(nullable CALayer *)sibling {
    if ([LWGrayThemeManager hasCALayer:self]) {
        [LWGrayThemeManager handleGrayThemeWithSuperLayer:layer];
    }
    [self lw_insertSublayer:layer above:sibling];
}

- (void)lw_replaceSublayer:(CALayer *)oldLayer with:(CALayer *)newLayer {
    if ([LWGrayThemeManager hasCALayer:self]) {
        [LWGrayThemeManager handleGrayThemeWithSuperLayer:newLayer];
    }
    [self lw_replaceSublayer:oldLayer with:newLayer];
}

- (void)lw_setBackgroundColor:(CGColorRef)backgroundColor {
    if ([LWGrayThemeManager hasCALayer:self]) {
        CGColorRef newColorRef = [LWGrayThemeManager makeGrayColor:[UIColor colorWithCGColor:backgroundColor]].CGColor;
        [self lw_setBackgroundColor:newColorRef];
    } else {
        [self lw_setBackgroundColor:backgroundColor];
    }
}

- (void)lw_setBorderColor:(CGColorRef)borderColor {
    if ([LWGrayThemeManager hasCALayer:self]) {
        CGColorRef newColorRef  = [LWGrayThemeManager makeGrayColor:[UIColor colorWithCGColor:borderColor]].CGColor;
        [self lw_setBorderColor:newColorRef];
    } else {
        [self lw_setBorderColor:borderColor];
    }
}

- (void)lw_setShadowColor:(CGColorRef)shadowColor {
    if ([LWGrayThemeManager hasCALayer:self]) {
        CGColorRef newColorRef  = [LWGrayThemeManager makeGrayColor:[UIColor colorWithCGColor:shadowColor]].CGColor;
        [self lw_setShadowColor:newColorRef];
    } else {
        [self lw_setShadowColor:shadowColor];
    }
}

@end
