//
//  AGAlertViewManager.m
//  AGPopupVC
//
//  Created by JohnnyB0Y on 2017/3/7.
//  Copyright © 2017年 JohnnyB0Y. All rights reserved.
//  警告框

#import "AGAlertViewManager.h"

@interface AGAlertViewManager ()
<
UIAlertViewDelegate
>

/** 并发线程队列 */
@property (nonatomic, strong) dispatch_queue_t concurrentQueue;

/** 缓存 */
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, AlertOperationBlock> *blockDictM;

@end

@implementation AGAlertViewManager {
    NSInteger _alertTag;
}

+ (instancetype) sharedInstance
{
    static AGAlertViewManager *alertViewManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        alertViewManager = [[self alloc] init];
        alertViewManager->_alertTag = 1024;
        alertViewManager->_blockDictM = [NSMutableDictionary dictionaryWithCapacity:8];
        alertViewManager->_concurrentQueue = dispatch_queue_create("com.AGPopupTool.AlertViewManagerQueue", DISPATCH_QUEUE_CONCURRENT);
    });
    return alertViewManager;
}

#pragma mark - ---------- System Delegate ----------
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSNumber *tag = @(alertView.tag);
    AlertOperationBlock block = self.blockDictM[tag];
    
    if (block) {
        block(alertView, buttonIndex);
        
        // 执行完，移除代码块
        [self.blockDictM removeObjectForKey:tag];
    }
}

#pragma mark - ---------- Public Methods ----------
- (void) ag_showAlertView:(AlertSetupBlock)setupBlock
                    title:(NSString *)title
                  message:(NSString *)message
          operationBlocks:(AlertOperationBlock)operationBlocks
        cancelButtonTitle:(NSString *)cancelButtonTitle
        otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
    // 取出可变参数
    va_list args;
    va_start(args, otherButtonTitles);
    NSMutableArray *buttonTitlesArray = [NSMutableArray new];
    while (otherButtonTitles != nil) {
        [buttonTitlesArray addObject:otherButtonTitles];
        otherButtonTitles = va_arg(args, NSString *);
    }
    va_end(args);
    
    [[self _createAlertView:setupBlock
                      title:title
                    message:message
            operationBlocks:operationBlocks
          cancelButtonTitle:cancelButtonTitle
          otherButtonTitles:buttonTitlesArray] show];
}

- (void)ag_showAlertViewWithTitle:(NSString *)title
                          message:(NSString *)message
                  operationBlocks:(AlertOperationBlock)operationBlocks
                cancelButtonTitle:(NSString *)cancelButtonTitle
                otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
    // 取出可变参数
    va_list args;
    va_start(args, otherButtonTitles);
    NSMutableArray *buttonTitlesArray = [NSMutableArray new];
    while (otherButtonTitles != nil) {
        [buttonTitlesArray addObject:otherButtonTitles];
        otherButtonTitles = va_arg(args, NSString *);
    }
    va_end(args);
    
    [[self _createAlertView:nil
                      title:title
                    message:message
            operationBlocks:operationBlocks
          cancelButtonTitle:cancelButtonTitle
          otherButtonTitles:buttonTitlesArray] show];
}

#pragma mark - ---------- Private Methods ----------
#pragma mark 生成新的 tag
- (NSNumber *) _newAlertTag
{
    return @(++_alertTag);
}

- (UIAlertView *) _createAlertView:(AlertSetupBlock)setupBlock
                             title:(NSString *)title
                           message:(NSString *)message
                   operationBlocks:(AlertOperationBlock)operationBlocks
                 cancelButtonTitle:(NSString *)cancelButtonTitle
                 otherButtonTitles:(NSArray<NSString *> *)otherButtonTitles
{
    __block UIAlertView *alertView = nil;
    dispatch_barrier_sync(self.concurrentQueue, ^{
        
        // 创建
        alertView = [[UIAlertView alloc] init];
        alertView.title = title;
        alertView.message = message;
        alertView.delegate = self;
        
        // 添加按钮
        if (cancelButtonTitle) {
            [alertView addButtonWithTitle:cancelButtonTitle];
        }
        
        for (NSString *otherBtnTitle in otherButtonTitles) {
            [alertView addButtonWithTitle:otherBtnTitle];
        }
        
        // 保存block
        NSNumber *key = [self _newAlertTag];
        alertView.tag = key.integerValue;
        
        if (operationBlocks) {
            [self.blockDictM setObject:[operationBlocks copy] forKey:key];
        }
        
        // 设置属性
        if (setupBlock) {
            setupBlock(alertView);
        }
    });
    
    return alertView;
}

#pragma mark - ---------- Getter Methods ----------


@end
