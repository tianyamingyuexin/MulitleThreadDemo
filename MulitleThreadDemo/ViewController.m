//
//  ViewController.m
//  MulitleThreadDemo
//
//  Created by guangshu01 on 2018/3/16.
//  Copyright © 2018年 guangshu01. All rights reserved.
//

#import "ViewController.h"
#import "NTThreadVC.h"
#import "GCDViewController.h"
#import "NSOperationVC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (IBAction)threadButtonClick:(id)sender
{
    NTThreadVC *vc = [[NTThreadVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)gcdButtonClick:(id)sender
{
    GCDViewController *vc = [[GCDViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)operationButtonClick:(id)sender
{
    NSOperationVC *vc = [[NSOperationVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
