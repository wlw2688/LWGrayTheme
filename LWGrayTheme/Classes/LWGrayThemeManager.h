//
//  LWGrayThemeManager.h
//  handhelddoctor
//
//  Created by jk_wlw on 2021/12/27.
//  Copyright © 2021 gzJianke. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface LWGrayThemeManager : NSObject


/// 在handleGrayThemeWithSuperView 方法前调用
/// 只能设置一次，多次设置无效，如果不设置，默认不置灰
/// 目的：防止有的置灰，有的不置灰
+ (void)configCanGray:(BOOL)canGray;

/// 主要方法
/// 把该控件以及它的子控件置灰，并且弱引用添加到缓存
+ (void)handleGrayThemeWithSuperView:(UIView *)superView;

/// 是否缓存该控件
/// 扩展逻辑可以用这个判断，需要不需要设置灰色主题
+ (BOOL)hasCALayer:(CALayer *)layer;
+ (BOOL)hasUIView:(UIView *)view;

/// 工具方法
+ (UIImage *)makeGrayImage:(UIImage *)image;                 // 获取图片置灰方法
+ (UIColor *)makeGrayColor:(UIColor *)color;                 // 把颜色改为灰色
+ (void)handleGrayThemeWithSuperLayer:(CALayer *)superLayer; // 处理layer

@end

NS_ASSUME_NONNULL_END
