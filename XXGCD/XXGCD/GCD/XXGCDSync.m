//
//  XXGCDSync.m
//  XXGCD
//
//  Created by tomxiang on 6/2/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//
//http://zhangbuhuai.com/2015/04/11/%E6%B7%B1%E5%85%A5%E7%90%86%E8%A7%A3dispatch_sync/
#import "XXGCDSync.h"

@implementation XXGCDSync
//死锁原因
//1:dispatch_sync在等待block语句执行完成，而block语句需要在主线程里执行，所以dispatch_sync如果在主线程调用就会造成死锁
//2:dispatch_sync是同步的，本身就会阻塞当前线程，也即主线程。而又往主线程里塞进去一个block，所以就会发生死锁。
//});

-(void) startSYNC{
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"3");
    });
}

//简单来说，在dispatch_sync嵌套使用时要注意：不能在一个嵌套中使用同一个serial dispatch queue，因为会发生死锁；
- (void)testSYNC2 {
    dispatch_queue_t aSerialDispatchQueue =
    dispatch_queue_create("I.am.an.iOS.developer", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(aSerialDispatchQueue, ^{
        // block 1
        NSLog(@"Good Night, Benjamin.");
        dispatch_sync(aSerialDispatchQueue, ^{
            // block 2
            NSLog(@"Good Night, Daisy.");
        });
    });
}

-(void) startASYNC{
    dispatch_async(dispatch_get_main_queue(), ^{
        //async 异步队列，dispatch_async 函数会立即返回, block会在后台异步执行。
        NSLog(@"2");//不会造成死锁；
    });
}
@end
