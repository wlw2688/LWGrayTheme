//
//  UIImageView+LWGrayTheme.m
//  handhelddoctor
//
//  Created by lw_wlw on 2021/12/28.
//  Copyright © 2021 gzJianke. All rights reserved.
//

#import "UIImageView+LWGrayTheme.h"
#include <objc/runtime.h>
#import "LWGrayThemeManager.h"

@implementation UIImageView (LWGrayTheme)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selectors[] = {
            @selector(setAnimationImages:),
            @selector(setImage:),
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

- (void)lw_setImage:(UIImage *)image {
    if ([LWGrayThemeManager hasUIView:self]) {
        UIImage *newImage = [LWGrayThemeManager makeGrayImage:image];
        [self lw_setImage:newImage];
    } else {
        [self lw_setImage:image];
    }
}

- (void)lw_setAnimationImages:(NSArray<UIImage *> *)animationImages {
    if ([LWGrayThemeManager hasUIView:self]) {
        NSMutableArray *imageArr = [[NSMutableArray alloc] init];
        for (UIImage *img in animationImages) {
            [imageArr addObject:[LWGrayThemeManager makeGrayImage:img]];
        }
        [self lw_setAnimationImages:imageArr];
    } else {
        [self lw_setAnimationImages:animationImages];
    }
}

@end
