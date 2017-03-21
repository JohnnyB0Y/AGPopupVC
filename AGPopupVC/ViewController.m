//
//  ViewController.m
//  AGPopupVC
//
//  Created by JohnnyB0Y on 2017/3/7.
//  Copyright © 2017年 JohnnyB0Y. All rights reserved.
//

#import "ViewController.h"
#import "AGPopupVC.h"
#import "AGPopupManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
//    [self agPopupVCTest1];
    
//    [self agPopupManagerTest1];
    
//    [self agPopupManagerTest2];
    
    [self agPopupManagerTest3];
}

- (void) agPopupManagerTest1
{
    // 测试1
    [[AGPopupManager sharedInstance] ag_showAlertView:^(UIAlertView *alertView) {
        // 设置 alertView
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        
    } title:@"温馨提示：" message:@"你有一条新消息，请注意查收！" operationBlocks:^(UIAlertView *alertView, NSInteger clickedIndex) {
        // 处理结果
        if ( clickedIndex == 0 )
            NSLog(@"点击了取消按钮！");
        else if ( clickedIndex == 1 )
            NSLog(@"点击了确认按钮！");
        else if ( clickedIndex == 2 )
            NSLog(@"%@！", [alertView buttonTitleAtIndex:2]);
        
    } cancelButtonTitle:@"取消" otherButtonTitles:@"确认", @"呵呵", nil];
}

- (void) agPopupManagerTest2
{
    __weak typeof(self) weakSelf = self;
    
    UIAlertController *alertController = [[AGPopupManager sharedInstance] ag_alertController:^(UIAlertController *alertC) {
        // 设置属性
        [alertC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.text = @"who 怕 who ?!";
        }];
        
    } title:@"来啊！" message:@"互相伤害啊！" preferredStyle:UIAlertControllerStyleAlert cancelTitle:@"😁" alertActionTitles:@[AASDestructive(@"🐒")] operationBlocks:^(UIAlertController *alertC, NSInteger clickedIndex) {
        // 处理结果
        if ([weakSelf.view.backgroundColor isEqual:[UIColor orangeColor]]) {
            weakSelf.view.backgroundColor = [UIColor purpleColor];
        } else {
            weakSelf.view.backgroundColor = [UIColor orangeColor];
        }
        
        NSLog(@"你点击了按钮 %ld, viewTag:%ld", clickedIndex, weakSelf.view.tag);
        
    }];
    
    // 弹出
    [self presentViewController:alertController animated:YES completion:^{
        NSLog(@"%@", [[AGPopupManager sharedInstance] description]);
        
        weakSelf.view.tag = arc4random_uniform(100);
        NSLog(@"viewTag: %ld", weakSelf.view.tag);
    }];
}

- (void) agPopupManagerTest3
{
    __weak typeof(self) weakSelf = self;
    
    UIAlertController *alertController = [[AGPopupManager sharedInstance] ag_actionSheetWithTitle:@"来啊！" message:@"互相伤害啊！" cancelTitle:@"取消" destructiveTitle:@"确认" operationBlocks:^(UIAlertController *alertC, NSInteger clickedIndex) {
        
        // 处理结果
        if ([weakSelf.view.backgroundColor isEqual:[UIColor orangeColor]]) {
            weakSelf.view.backgroundColor = [UIColor yellowColor];
        } else {
            weakSelf.view.backgroundColor = [UIColor brownColor];
        }
        
        NSLog(@"你点击了按钮 %ld, viewTag:%ld", clickedIndex, weakSelf.view.tag);
        
    }];
    
    // 弹出
    [self presentViewController:alertController animated:YES completion:^{
        NSLog(@"%@", [[AGPopupManager sharedInstance] description]);
        
        weakSelf.view.tag = arc4random_uniform(100);
        NSLog(@"viewTag: %ld", weakSelf.view.tag);
    }];
}

- (void) agPopupVCTest1
{
    // 测试
    UIView *view = [UIView new];
    
    [view addSubview:[UISwitch new]];
    
    view.backgroundColor = [UIColor yellowColor];
    
    [[AGPopupVC sharedInstance] ag_showView:view];
    //[[AGPopupVC sharedInstance] showView:view contentSize:CGSizeMake(200, 200)];
}


@end
