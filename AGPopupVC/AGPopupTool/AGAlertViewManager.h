//
//  AGAlertViewManager.h
//  AGPopupVC
//
//  Created by JohnnyB0Y on 2017/3/7.
//  Copyright © 2017年 JohnnyB0Y. All rights reserved.
//  警告框

#import <UIKit/UIKit.h>

/** 点击处理block */
typedef void(^AlertOperationBlock)(UIAlertView *alertView, NSInteger clickedIndex);
/** 设置属性 block */
typedef void(^AlertSetupBlock)(UIAlertView *alertView);

@interface AGAlertViewManager : NSObject

+ (instancetype) sharedInstance;

/**
 * 弹出 UIAlertView
 *
 * setupBlock ：show alertView 前调用的block
 * title ：alertView 标题
 * message ：alertView 信息
 * operationBlocks alertView 点击处理的block
 * cancelButtonTitle ：取消按钮标题
 * otherButtonTitles：其他按钮的标题s
 */
- (void) ag_showAlertView:(AlertSetupBlock)setupBlock
                    title:(NSString *)title
                  message:(NSString *)message
          operationBlocks:(AlertOperationBlock)operationBlocks
        cancelButtonTitle:(NSString *)cancelButtonTitle
        otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/**
 * 弹出 UIAlertView
 *
 * title ：alertView 标题
 * message ：alertView 信息
 * operationBlocks alertView 点击处理的block
 * cancelButtonTitle ：取消按钮标题
 * otherButtonTitles：其他按钮的标题s
 */
- (void) ag_showAlertViewWithTitle:(NSString *)title
                           message:(NSString *)message
                   operationBlocks:(AlertOperationBlock)operationBlocks
                 cancelButtonTitle:(NSString *)cancelButtonTitle
                 otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;



@end
