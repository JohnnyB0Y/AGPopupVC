//
//  AGPopupVC.m
//  AGPopupVC
//
//  Created by JohnnyB0Y on 2017/3/7.
//  Copyright © 2017年 JohnnyB0Y. All rights reserved.
//  弹框控制器

#import "AGPopupVC.h"
#import "UIView+LayoutMethods.h"

@interface AGPopupVC ()
{
    /** 内容展示尺寸 默认 ( 屏幕宽，屏幕高的0.4 ) */
    CGSize _contentSize;
    
    /** 内容出现位置 默认 ( 底部钻出 ) */
    AGPopupDirection _alertDirection;
}

/** contentView */
@property (nonatomic, strong) UIView *contentView;

@end

@implementation AGPopupVC

#pragma mark - --------- Life Cycle ------------
- (instancetype)init
{
    self = [super init];
    
    if (self) {
        CGSize size = [UIScreen mainScreen].bounds.size;
        _contentSize = CGSizeMake(size.width, 286.0);
        _showDuration = 0.35f;
        _hideDuration = 0.25f;
        _alertDirection = AGPopupDirectionBottom;
        _coverColor = [UIColor colorWithWhite:0.000 alpha:0.50];
    }
    
    return self;
}

+ (__kindof AGPopupVC *)sharedInstance
{
    static AGPopupVC *popupVC = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        popupVC = [[self alloc] init];
    });
    
    return popupVC;
}

#pragma mark - 视图加载
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.view.frame = self.window.bounds;
}

- (void) setupUI
{
    // 配置
    self.view.backgroundColor = [UIColor clearColor];
    self.view.hidden = YES;
}

#pragma mark - --------- Public Methods -------------
#pragma mark - 视图出现-消失
- (void) ag_showView:(UIView *)view
{
    [self ag_showView:view contentSize:_contentSize];
}

- (void) ag_showView:(UIView *)view height:(CGFloat)height
{
    [self ag_showView:view contentSize:CGSizeMake(_contentSize.width, height)];
}

/**
 *  弹出视图 默认宽度( 屏幕宽 )
 */
- (void) ag_showView:(UIView *)view height:(CGFloat)height direction:(AGPopupDirection)direction
{
    [self ag_showView:view contentSize:CGSizeMake(_contentSize.width, height) direction:direction];
}

- (void) ag_showView:(UIView *)view direction:(AGPopupDirection)direction
{
    [self ag_showView:view contentSize:_contentSize direction:direction];
}

- (void) ag_showView:(UIView *)view contentSize:(CGSize)contentSize
{
    [self ag_showView:view contentSize:contentSize direction:AGPopupDirectionBottom];
}

- (void) ag_showView:(UIView *)view contentSize:(CGSize)contentSize direction:(AGPopupDirection)direction
{
    CGRect rect = CGRectMake(0, 0, contentSize.width, contentSize.height);
    [self _showView:view inRect:rect direction:direction defaultOrigin:YES];
}

- (void) ag_showView:(UIView *)view inRect:(CGRect)rect direction:(AGPopupDirection)direction
{
    [self _showView:view inRect:rect direction:direction defaultOrigin:NO];
}

/**
 自定义弹出视图
 
 @param view 弹出的视图
 @param customAnimation 自定义弹出视图 block
 */
- (void) ag_showView:(UIView *)view customOperation:(AGPopupCustomOperationBlock)operation
{
    if (self.isShowing) {
        return;
    }
    
    // 1.0 添加到父视图
    [self.window        addSubview:self.view];
    [self.view          addSubview:view];
    self.contentView    = view;
    
    // 2.0 背景视图显示
    self.view.hidden        = NO;
    self.contentView.hidden = NO;
    _showing = YES;
    
    [UIView animateWithDuration:_showDuration animations:^{
        // 背景色
        self.view.backgroundColor = [self coverColor];
    }];
    
    // 操作 block
    operation ? operation(self.view) : nil;
    
}

#pragma mark 隐藏
- (void) ag_hide
{
    [self ag_hideWithDuration:_hideDuration direction:_alertDirection];
}

- (void) ag_hideWithDuration:(CGFloat)duration direction:(AGPopupDirection)direction
{
    if (self.isShowing == NO) {
        return;
    }
    
    // 1.0 动画
    self.view.backgroundColor = [UIColor clearColor];
    
    [UIView animateWithDuration:duration animations:^{
        
        switch (direction) {
            case AGPopupDirectionBottom: {
                self.contentView.y = self.view.height;
            } break;
                
            case AGPopupDirectionTop: {
                self.contentView.y = -self.contentView.height;
            } break;
                
            case AGPopupDirectionLeft: {
                self.contentView.x = -self.contentView.width;
            } break;
                
            case AGPopupDirectionRight: {
                self.contentView.x = self.view.width;
            } break;
                
            case AGPopupDirectionCenter: {
                self.contentView.hidden = YES;
            } break;
        }
        
    } completion:^(BOOL finished) {
        // 2.0 移除
        [self.contentView   removeFromSuperview];
        [self.view          removeFromSuperview];
        self.contentView    = nil;
        // 2.1 隐藏
        self.view.hidden    = YES;
        _alertDirection = AGPopupDirectionBottom;
    }];
    
    _showing = NO;
}

#pragma mark - --------- Private Methods --------------
- (void) _showView:(UIView *)view inRect:(CGRect)rect direction:(AGPopupDirection)direction defaultOrigin:(BOOL)yesOrNo
{
    if (self.isShowing) {
        return;
    }
    
    // 1.0 添加到父视图
    [self.window        addSubview:self.view];
    [self.view          addSubview:view];
    self.contentView    = view;
    _alertDirection     = direction;
    
    // 2.0 背景视图显示
    self.view.hidden        = NO;
    self.contentView.hidden = NO;
    
    // 3.0 内容视图初始化位置
    CGFloat width       = self.view.width;
    CGFloat height      = self.view.height;
    CGFloat contentW    = rect.size.width;
    CGFloat contentH    = rect.size.height;
    CGFloat contentX    = rect.origin.x;
    CGFloat contentY    = rect.origin.y;
    
    switch (_alertDirection) {
        case AGPopupDirectionBottom: {
            if (yesOrNo)
                contentX = (width - contentW) * 0.5;
            
            contentY = height;
            self.contentView.frame = CGRectMake(contentX, contentY, contentW, contentH);
        } break;
            
        case AGPopupDirectionTop: {
            if (yesOrNo)
                contentX = (width - contentW) * 0.5;
            
            contentY = -contentH;
            self.contentView.frame = CGRectMake(contentX, contentY, contentW, contentH);
        } break;
            
        case AGPopupDirectionLeft: {
            if (yesOrNo)
                contentY = (height - contentH) * 0.5;
            
            contentX = -contentW;
            self.contentView.frame = CGRectMake(contentX, contentY, contentW, contentH);
            
        } break;
            
        case AGPopupDirectionRight: {
            if (yesOrNo)
                contentY = (height - contentH) * 0.5;
            
            contentX = width;
            self.contentView.frame = CGRectMake(contentX, contentY, contentW, contentH);
            
        } break;
            
        case AGPopupDirectionCenter: {
            if (yesOrNo) {
                contentX = (width - contentW) * 0.5;
                contentY = (height - contentH) * 0.5;
            }
            self.contentView.frame = CGRectMake(contentX, contentY, contentW, contentH);
            self.contentView.hidden = YES;
        } break;
    }
    
    // 4.0 动画弹出
    [UIView animateWithDuration:_showDuration animations:^{
        // 位置改变
        switch (_alertDirection) {
            case AGPopupDirectionBottom: {
                if (yesOrNo)
                    self.contentView.y = height - contentH;
                else
                    self.contentView.y = rect.origin.y;
                
            } break;
                
            case AGPopupDirectionTop: {
                if (yesOrNo)
                    self.contentView.y = 0.0;
                else
                    self.contentView.y = rect.origin.y;
                
            } break;
                
            case AGPopupDirectionLeft: {
                if (yesOrNo)
                    self.contentView.x = 0.0;
                else
                    self.contentView.x = rect.origin.x;
                
            } break;
                
            case AGPopupDirectionRight: {
                if (yesOrNo)
                    self.contentView.x = width - contentW;
                else
                    self.contentView.x = rect.origin.x;
                
            } break;
                
            case AGPopupDirectionCenter: {
                self.contentView.hidden = NO;
                
            } break;
        }
        
        // 背景色
        self.view.backgroundColor = [self coverColor];
    } completion:^(BOOL finished) {
        
    }];
    
    _showing = YES;
    
}


#pragma mark - ---------- Event -----------
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    if (CGRectContainsPoint(self.contentView.frame, point) == NO)
        [self ag_hide];
}

#pragma mark - -------- Getter --------------
- (UIWindow *)window
{
    return [UIApplication sharedApplication].keyWindow;
}

@end
