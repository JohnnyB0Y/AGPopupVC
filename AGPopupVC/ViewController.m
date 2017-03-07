//
//  ViewController.m
//  AGPopupVC
//
//  Created by JohnnyB0Y on 2017/3/7.
//  Copyright © 2017年 JohnnyB0Y. All rights reserved.
//

#import "ViewController.h"
#import "AGPopupVC.h"
#import "AGAlertViewManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 测试1
    [[AGAlertViewManager sharedInstance] ag_showAlertView:^(UIAlertView *alertView) {
        // 设置 alertView
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        
    } title:@"温馨提示：" message:@"你有一条新消息，请注意查收！" operationBlocks:^(UIAlertView *alertView, NSInteger clickedIndex) {
        
        if ( clickedIndex == 0 )
            NSLog(@"点击了取消按钮！");
        else if ( clickedIndex == 1 )
            NSLog(@"点击了确认按钮！");
        else if ( clickedIndex == 2 )
            NSLog(@"%@！", [alertView buttonTitleAtIndex:2]);
        
    } cancelButtonTitle:@"取消" otherButtonTitles:@"确认", @"呵呵", nil];
    
    
    
    
    // 测试2
//    UIView *view = [UIView new];
//    
//    [view addSubview:[UISwitch new]];
//    
//    view.backgroundColor = [UIColor yellowColor];
//    
//    [[AGPopupVC sharedInstance] ag_showView:view];
    //[[AGPopupVC sharedInstance] showView:view contentSize:CGSizeMake(200, 200)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
