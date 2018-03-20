//
//  NTThreadVC.m
//  MulitleThreadDemo
//
//  Created by guangshu01 on 2018/3/16.
//  Copyright © 2018年 guangshu01. All rights reserved.
//

#import "NTThreadVC.h"

@interface NTThreadVC ()

@end

@implementation NTThreadVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /** 方法一，需要start */
    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(doSomething1:) object:@"NSThread1"];
    // 线程加入线程池等待CPU调度，时间很快，几乎是立刻执行
    [thread1 start];
    
    /** 方法二，创建好之后自动启动 */
    [NSThread detachNewThreadSelector:@selector(doSomething2:) toTarget:self withObject:@"NSThread2"];
    
    /** 方法三，隐式创建，直接启动 */
    [self performSelectorInBackground:@selector(doSomething3:) withObject:@"NSThread3"];
    
}

- (void)doSomething1:(NSObject *)object
{
    // 传递过来的参数
    NSLog(@"%@",object);
    NSLog(@"doSomething1：%@",[NSThread currentThread]);
}

- (void)doSomething2:(NSObject *)object
{
    NSLog(@"%@",object);
    NSLog(@"doSomething2：%@",[NSThread currentThread]);
}

- (void)doSomething3:(NSObject *)object
{
    NSLog(@"%@",object);
    NSLog(@"doSomething3：%@",[NSThread currentThread]);
}


@end
