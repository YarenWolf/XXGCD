//
//  XXGCDApply.m
//  XXGCD
//
//  Created by tomxiang on 5/24/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//  执行某段代码n次

#import "XXGCDApply.h"

@implementation XXGCDApply

-(void) testGCDApply{
    dispatch_queue_t globalQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_apply(20, globalQ, ^(size_t index) {
        // 执行5次
        [self printTest];
    });
}

-(void) printTest{
    NSLog(@"xiangchenyu %s",__func__);
}

@end
