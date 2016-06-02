//
//  XXGCDGroup.m
//  XXGCD
//
//  Created by tomxiang on 5/24/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "XXGCDGroup.h"
#import "XXEngine.h"
//http://stackoverflow.com/questions/10643797/wait-until-multiple-networking-requests-have-all-executed-including-their-comp/10644282#10644282
@implementation XXGCDGroup

-(void) testGCDGroup{
    dispatch_group_t group = dispatch_group_create();
    for(int i = 0; i < 10; i++)
    {
        dispatch_group_enter(group);
        [[XXEngine instance] doAsyncWorkWithCompletionBlock:^{
            dispatch_group_leave(group);
        }];
    }
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSLog(@"testGCDGroup1 更新UI操作");
}


//当这些并行操作完成的时候，还可以使用它来异步调用一个block。
-(void) testGCDGroup2{
    dispatch_group_t group = dispatch_group_create();
    for(int i = 0; i < 10; i++)
    {
        dispatch_group_enter(group);
        [[XXEngine instance] doAsyncWorkWithCompletionBlock:^{
            dispatch_group_leave(group);
        }];
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"testGCDGroup2 更新UI操作");
    });
}

-(void) testGCDGroup3{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"group1");
    });
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"group2");
    });
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"group3");
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"testGCDGroup3 更新UI操作");
    });
}

@end
