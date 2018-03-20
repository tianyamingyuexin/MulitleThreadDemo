//
//  GCDViewController.m
//  MulitleThreadDemo
//
//  Created by guangshu01 on 2018/3/16.
//  Copyright © 2018年 guangshu01. All rights reserved.
//

#import "GCDViewController.h"
#import "SingleIntanceTest.h"
@interface GCDViewController ()

@end

@implementation GCDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"viewDidLoad");
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"看你走不走啊啊啊啊啊");
//    });
}

- (IBAction)gotoMainQueue:(UIButton *)sender
{
    dispatch_async(dispatch_get_main_queue(), ^{
       //回到主线程，今进行UI刷新以及其它对界面的操作
    });
  
}

- (IBAction)customSerial:(id)sender
{
    dispatch_queue_t serialQueue = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
    NSLog(@"当前任务1");
    NSLog(@"1:%@",[NSThread currentThread]);
    dispatch_async(serialQueue, ^{
      NSLog(@"当前任务2");
        NSLog(@"2:%@",[NSThread currentThread]);
        sleep(2);
    });
    dispatch_async(serialQueue, ^{
        
     NSLog(@"当前任务3");
        NSLog(@"3:%@",[NSThread currentThread]);
    });
    
   
}
- (IBAction)customConcurrent:(UIButton *)sender
{
    dispatch_queue_t conCurrentQueue = dispatch_queue_create("TestCon", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"1");
    NSLog(@"one:%@",[NSThread currentThread]);
    dispatch_async(conCurrentQueue, ^{
        NSLog(@"2");
        NSLog(@"two:%@",[NSThread currentThread]);
    });
    dispatch_async(conCurrentQueue, ^{
        NSLog(@"3");
        NSLog(@"three:%@",[NSThread currentThread]);
    });
    NSLog(@"4");
    
  
}
- (IBAction)globalConcurrent:(UIButton *)sender
{
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{
        NSLog(@"test");
    });
}


- (IBAction)singleInstance:(id)sender
{
    SingleIntanceTest *singTest = [SingleIntanceTest shareInstace];
}
- (IBAction)notify:(UIButton *)sender
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    //里面的代码需要时顺序执行 不然没有效果
    dispatch_group_async(group, queue, ^{
        NSLog(@"one");
    });
    dispatch_group_async(group, queue, ^{
     NSLog(@"two");
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        NSLog(@"执行完毕");
    });
}
- (IBAction)timerAction:(id)sender
{
    
    NSTimeInterval period = 1.0; //设置时间间隔
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        //在这里执行事件
    });
    dispatch_resume(_timer);
    
}
- (IBAction)barrier:(id)sender
{
    //同dispatch_queue_create函数生成的concurrent Dispatch Queue队列一起使用
    dispatch_queue_t queue = dispatch_queue_create("barrierTest", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"----1-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----2-----%@", [NSThread currentThread]);
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"----barrier-----%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"----3-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----4-----%@", [NSThread currentThread]);
    });
}

@end
