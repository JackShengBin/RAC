//
//  MyViewController.m
//  RACTest
//
//  Created by 梦想 on 2016/11/18.
//  Copyright © 2016年 lin_tong. All rights reserved.
//

#import "MyViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithObjects:@"1", @"2", @"3", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"postData" object:dataArray];
    
    
    UIScrollView *scroll  = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 300)];
    scroll.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:scroll];
    scroll.contentSize = CGSizeMake(1000, 1000);
    
    [RACObserve(scroll, contentOffset) subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
