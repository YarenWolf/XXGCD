//
//  XXGCDApply.m
//  XXGCD
//
//  Created by tomxiang on 5/24/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//  执行某段代码n次

#import "XXGCDApply.h"

@implementation XXGCDApply

static int i = 0;

-(void) testGCDApply{
    dispatch_queue_t globalQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_apply(10, globalQ, ^(size_t index) {
        // 执行10次
        [self printTest];
    });
}

-(void) printTest{
    NSLog(@"%d",++i);
}

@end
