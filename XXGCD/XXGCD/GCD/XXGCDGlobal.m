//
//  XXGCDGlobal.m
//  XXGCD
//
//  Created by tomxiang on 6/2/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "XXGCDGlobal.h"

@implementation XXGCDGlobal

//#define DISPATCH_QUEUE_PRIORITY_HIGH 2
//#define DISPATCH_QUEUE_PRIORITY_DEFAULT 0
//#define DISPATCH_QUEUE_PRIORITY_LOW (-2)

-(void) test{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            NSLog(@"update UI");
        });
    });
}

@end
