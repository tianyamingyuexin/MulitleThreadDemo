//
//  SingleIntanceTest.m
//  MulitleThreadDemo
//
//  Created by guangshu01 on 2018/3/19.
//  Copyright © 2018年 guangshu01. All rights reserved.
//

#import "SingleIntanceTest.h"
static SingleIntanceTest *__singleInstacess = nil;
@implementation SingleIntanceTest

+ (instancetype)shareInstace
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __singleInstacess = [[SingleIntanceTest alloc] init];
    });
    return __singleInstacess;
}

@end
