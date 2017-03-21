//
//  UIView+LayoutMethods.m
//  TmallClient4iOS-Prime
//
//  Created by casa on 14/12/8.
//  Copyright (c) 2014年 casa. All rights reserved.
//

#import "UIView+LayoutMethods.h"

@implementation UIView (LayoutMethods)

// coordinator getters
- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x
{
    self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (void)setY:(CGFloat)y
{
    self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGSize)size
{
    return self.frame.size;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (CGFloat)bottom
{
    return self.frame.size.height + self.frame.origin.y;
}

- (CGFloat)right
{
    return self.frame.size.width + self.frame.origin.x;
}

// height
- (void)setHeight:(CGFloat)height
{
    CGRect newFrame = CGRectMake(self.x, self.y, self.width, height);
    self.frame = newFrame;
}

/**
 *  self视图的高度等于目标视图的高度
 *
 *  @param view 目标视图
 */
- (void)heightEqualToView:(UIView *)view
{
    self.height = view.height;
}

// width
- (void)setWidth:(CGFloat)width
{
    CGRect newFrame = CGRectMake(self.x, self.y, width, self.height);
    self.frame = newFrame;
}

/**
 *  self视图的宽度等于目标视图的宽度
 *
 *  @param view 目标视图
 */
- (void)widthEqualToView:(UIView *)view
{
    self.width = view.width;
}

// center
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = CGPointMake(self.centerX, self.centerY);
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = CGPointMake(self.centerX, self.centerY);
    center.y = centerY;
    self.center = center;
}

/**
 *  self视图的 中心点X 等于目标视图的 中心点X
 *
 *  @param view 目标视图
 */
- (void)centerXEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewCenterPoint = [superView convertPoint:view.center toView:self.topSuperView];
    CGPoint centerPoint = [self.topSuperView convertPoint:viewCenterPoint toView:self.superview];
    self.centerX = centerPoint.x;
}

/**
 *  self视图的 中心点Y 等于目标视图的 中心点Y
 *
 *  @param view 目标视图
 */
- (void)centerYEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewCenterPoint = [superView convertPoint:view.center toView:self.topSuperView];
    CGPoint centerPoint = [self.topSuperView convertPoint:viewCenterPoint toView:self.superview];
    self.centerY = centerPoint.y;
}

// top, bottom, left, right
/**
 *  self视图 在 目标视图的顶部
 *
 *  @param top 相距目标视图顶部的距离
 *  @param view  目标视图
 */
- (void)top:(CGFloat)top FromView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.y = newOrigin.y + top + view.height;
}

/**
 *  self视图 在 目标视图的底部
 *
 *  @param bottom 相距目标视图底部的距离
 *  @param view  目标视图
 */
- (void)bottom:(CGFloat)bottom FromView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.y = newOrigin.y - bottom - self.height;
}

/**
 *  self视图 在 目标视图的左边
 *
 *  @param left 相距目标视图左边的距离
 *  @param view  目标视图
 */
- (void)left:(CGFloat)left FromView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.x = newOrigin.x - left - self.width;
}

/**
 *  self视图 在 目标视图的右边
 *
 *  @param right 相距目标视图右边的距离
 *  @param view  目标视图
 */
- (void)right:(CGFloat)right FromView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.x = newOrigin.x + right + view.width;
}

/**
 *  改变距离容器视图顶部的数值
 *
 *  @param top         距离容器视图顶部数值
 *  @param shouldResize 是否调整大小
 */
- (void)topInContainer:(CGFloat)top shouldResize:(BOOL)shouldResize
{
    if (shouldResize) {
        self.height = self.y - top + self.height;
    }
    self.y = top;
}

/**
 *  改变距离容器视图底部的数值
 *
 *  @param bottom       距离容器视图底部数值
 *  @param shouldResize 是否调整大小
 */
- (void)bottomInContainer:(CGFloat)bottom shouldResize:(BOOL)shouldResize
{
    if (shouldResize) {
        self.height = self.superview.height - bottom - self.y;
    } else {
        self.y = self.superview.height - self.height - bottom;
    }
}

/**
 *  改变距离容器视图左边的数值
 *
 *  @param left         距离容器视图左边数值
 *  @param shouldResize 是否调整大小
 */
- (void)leftInContainer:(CGFloat)left shouldResize:(BOOL)shouldResize
{
    if (shouldResize) {
        self.width = self.x - left + self.superview.width;
    }
    self.x = left;
}

/**
 *  改变距离容器视图右边的数值
 *
 *  @param right         距离容器视图右边数值
 *  @param shouldResize 是否调整大小
 */
- (void)rightInContainer:(CGFloat)right shouldResize:(BOOL)shouldResize
{
    if (shouldResize) {
        self.width = self.superview.width - right - self.x;
    } else {
        self.x = self.superview.width - self.width - right;
    }
}

/**
 *  顶部对齐 -- 顶部与目标视图顶部对齐
 *
 *  @param view 目标视图
 */
- (void)topEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.y = newOrigin.y;
}

/**
 *  底部对齐 -- 底部与目标视图底部对齐
 *
 *  @param view 目标视图
 */
- (void)bottomEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.y = newOrigin.y + view.height - self.height;
}

/**
 *  左对齐 -- 左边与目标视图左边对齐
 *
 *  @param view 目标视图
 */
- (void)leftEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.x = newOrigin.x;
}

/**
 *  右对齐 -- 右边与目标视图右边对齐
 *
 *  @param view 目标视图
 */
- (void)rightEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    // superView 上的 view.origin 这个点，相对于 self.topSuperView 上的坐标。
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    // self.topSuperView 上的 viewOrigin 这个点，相对于 self.superview 上的坐标
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.x = newOrigin.x + view.width - self.width;
}

/**
 *  设置大小size
 *
 *  @param size 大小size
 */
- (void)setSize:(CGSize)size
{
    self.frame = CGRectMake(self.x, self.y, size.width, size.height);
}

/**
 *  大小等于某视图的size
 *
 *  @param view 等于的那个视图
 */
- (void)sizeEqualToView:(UIView *)view
{
    self.frame = CGRectMake(self.x, self.y, view.width, view.height);
}

// imbueset
/**
 *  宽度填充父视图
 */
- (void)fillWidth
{
    self.width = self.superview.width;
}

/**
 *  高度填充父视图
 */
- (void)fillHeight
{
    self.height = self.superview.height;
}

/**
 *  填充整个父视图
 */
- (void)fill
{
    self.frame = CGRectMake(0, 0, self.superview.width, self.superview.height);
}

/**
 *  寻找最上层的父视图
 *
 *  @return 最上层的父视图
 */
- (UIView *)topSuperView
{
    UIView *topSuperView = self.superview;
    
    if (topSuperView == nil) {
        topSuperView = self;
    } else {
        while (topSuperView.superview) {
            topSuperView = topSuperView.superview;
        }
    }
    
    return topSuperView;
}

@end
