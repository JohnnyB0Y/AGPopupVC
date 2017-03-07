//
//  UIView+LayoutMethods.h
//  TmallClient4iOS-Prime
//
//  Created by casa on 14/12/8.
//  Copyright (c) 2014年 casa. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define SCREEN_FRAME [UIScreen mainScreen].bounds
#define SCREEN_WIDTH ([[UIScreen mainScreen]bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen]bounds].size.height)
#define SCREEN_WITHOUT_STATUS_HEIGHT (SCREEN_HEIGHT - [[UIApplication sharedApplication] statusBarFrame].size.height)

@interface UIView (LayoutMethods)

// coordinator getters
- (CGFloat)height;
- (CGFloat)width;
- (CGFloat)x;
- (CGFloat)y;
- (CGSize)size;
- (CGPoint)origin;
- (CGFloat)centerX;
- (CGFloat)centerY;
- (CGFloat)bottom;
- (CGFloat)right;

- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;

// height
- (void)setHeight:(CGFloat)height;
- (void)heightEqualToView:(UIView *)view;

// width
- (void)setWidth:(CGFloat)width;
- (void)widthEqualToView:(UIView *)view;

// center
- (void)setCenterX:(CGFloat)centerX;
- (void)setCenterY:(CGFloat)centerY;
- (void)centerXEqualToView:(UIView *)view;
- (void)centerYEqualToView:(UIView *)view;

// top, bottom, left, right
- (void)top:(CGFloat)top FromView:(UIView *)view;
- (void)bottom:(CGFloat)bottom FromView:(UIView *)view;
- (void)left:(CGFloat)left FromView:(UIView *)view;
- (void)right:(CGFloat)right FromView:(UIView *)view;

- (void)topInContainer:(CGFloat)top shouldResize:(BOOL)shouldResize;
- (void)bottomInContainer:(CGFloat)bottom shouldResize:(BOOL)shouldResize;
- (void)leftInContainer:(CGFloat)left shouldResize:(BOOL)shouldResize;
- (void)rightInContainer:(CGFloat)right shouldResize:(BOOL)shouldResize;

/**
 *  顶部对齐 -- 顶部与目标视图顶部对齐
 *
 *  @param view 目标视图
 */
- (void)topEqualToView:(UIView *)view;
/**
 *  底部对齐 -- 底部与目标视图底部对齐
 *
 *  @param view 目标视图
 */
- (void)bottomEqualToView:(UIView *)view;
/**
 *  左对齐 -- 左边与目标视图左边对齐
 *
 *  @param view 目标视图
 */
- (void)leftEqualToView:(UIView *)view;
/**
 *  右对齐 -- 右边与目标视图右边对齐
 *
 *  @param view 目标视图
 */
- (void)rightEqualToView:(UIView *)view;

// size
/**
 *  设置大小size
 *
 *  @param size 大小size
 */
- (void)setSize:(CGSize)size;
/**
 *  大小等于某视图的size
 *
 *  @param view 等于的那个视图
 */
- (void)sizeEqualToView:(UIView *)view;

// imbueset
/**
 *  宽度填充父视图
 */
- (void)fillWidth;
/**
 *  高度填充父视图
 */
- (void)fillHeight;
/**
 *  填充整个父视图
 */
- (void)fill;

/**
 *  寻找最上层的父视图
 *
 *  @return 最上层的父视图
 */
- (UIView *)topSuperView;

@end

@protocol LayoutProtocol
@required
// put your layout code here
- (void)calculateLayout;
@end
