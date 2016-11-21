//
//  ViewController.m
//  RACTest
//
//  Created by 梦想 on 2016/11/18.
//  Copyright © 2016年 lin_tong. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "MyViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *myBtn;
@property (weak, nonatomic) IBOutlet UITextField *myTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    
    [[self.myTextField rac_textSignal] subscribeNext:^(id x) {
        NSLog(@"x  %@", x);
    }];
    
    [[self.myBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"按钮被点击");
        [self.navigationController pushViewController:[[MyViewController alloc] init] animated:YES];
//        [self presentViewController:[[MyViewController alloc] init] animated:YES completion:nil];
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
//    [self.view addGestureRecognizer:tap];

//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"RAC" message:@"RAC Test" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"other", nil];
//    [[alertView rac_signalForSelector:@selector(alertView:clickedButtonAtIndex:) fromProtocol:@protocol(UIAlertViewDelegate)] subscribeNext:^(RACTuple *tuple) {
//        NSLog(@"%@", tuple);
//        
//        NSLog(@"%@", tuple.first);
//        NSLog(@"%@", tuple.second);
//    }];
//    [alertView show];
    
//    UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"RAC" message:@"RAC TEST" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"next", @"other", nil];
//    [[self rac_signalForSelector:@selector(alertView:clickedButtonAtIndex:) fromProtocol:@protocol(UIAlertViewDelegate)] subscribeNext:^(RACTuple *tuple) {
//        NSLog(@"tuple %@", tuple);
//        NSLog(@"first %@",tuple.first);
//        NSLog(@"second %@",tuple.second);
//        NSLog(@"third %@",tuple.third);
//    }];
//    [aler show];
//    [[aler rac_buttonClickedSignal] subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];

    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"postData" object:nil] subscribeNext:^(NSNotification *notification) {
        NSLog(@"%s", __func__);
        NSLog(@"%@", notification.name);
        NSLog(@"%@", notification.object);
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSLog(@"这是创建的一个信号");
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"信号被销毁");
        }];
    }];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"我已经订阅了这个信号");
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
