//
//  AGPopupVC.h
//  AGPopupVC
//
//  Created by JohnnyB0Y on 2017/3/7.
//  Copyright © 2017年 JohnnyB0Y. All rights reserved.
//  弹框控制器

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AGPopupDirection) {
    
    AGPopupDirectionTop,        // 顶部钻出
    AGPopupDirectionLeft,       // 左边钻出
    AGPopupDirectionRight,      // 右边钻出
    AGPopupDirectionBottom,     // 底部钻出
    AGPopupDirectionCenter,     // 中间出现
};

typedef void(^AGPopupCustomOperationBlock)(UIView *superview);


@interface AGPopupVC : UIViewController

/** 出现动画时间 默认 0.35s */
@property (nonatomic, assign) CGFloat           showDuration;
/** 消失动画时间 默认 0.25s */
@property (nonatomic, assign) CGFloat           hideDuration;
/** 是否正在展示 */
@property (nonatomic, assign, readonly, getter=isShowing) BOOL    showing;

/** 遮盖背景色 默认黑色半透明 */
@property (nonatomic, strong) UIColor *coverColor;

/** 单例 */
+ (__kindof AGPopupVC *) sharedInstance;

/**
 *  弹出视图 默认尺寸( 屏幕宽，高286.0 )，位置( 底部钻出 )
 *
 *  @param view 弹出的视图
 */
- (void) ag_showView:(UIView *)view;

/**
 *  弹出视图 默认宽度( 屏幕宽 )
 *
 *  @param view      弹出的视图
 *  @param height    高度
 */
- (void) ag_showView:(UIView *)view height:(CGFloat)height;

/**
 *  弹出视图 默认宽度( 屏幕宽 )
 *
 *  @param view      弹出的视图
 *  @param height    高度
 *  @param direction 弹出视图位置
 */
- (void) ag_showView:(UIView *)view height:(CGFloat)height direction:(AGPopupDirection)direction;

/**
 *  弹出视图 默认尺寸( 屏幕宽，高286.0 )
 *
 *  @param view      弹出的视图
 *  @param direction 弹出视图位置
 */
- (void) ag_showView:(UIView *)view direction:(AGPopupDirection)direction;

/**
 *  弹出视图 默认位置( 底部钻出 )
 *
 *  @param view        弹出的视图
 *  @param contentSize 弹出视图尺寸
 */
- (void) ag_showView:(UIView *)view contentSize:(CGSize)contentSize;

/**
 *  弹出视图
 *
 *  @param view        弹出的视图
 *  @param contentSize 弹出视图尺寸
 *  @param direction   弹出视图位置
 */
- (void) ag_showView:(UIView *)view contentSize:(CGSize)contentSize direction:(AGPopupDirection)direction;

- (void) ag_showView:(UIView *)view inRect:(CGRect)rect direction:(AGPopupDirection)direction;

/**
 自定义弹出视图
 
 @param view 弹出的视图
 @param operation 自定义弹出视图 block (无循环引用)
 */
- (void) ag_showView:(UIView *)view customOperation:(AGPopupCustomOperationBlock)operation;


/** 隐藏视图 */
- (void) ag_hide;
- (void) ag_hideWithDuration:(CGFloat)duration direction:(AGPopupDirection)direction;

@end
