//
//  XXGCDTimer.m
//  XXGCD
//
//  Created by tomxiang on 5/24/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//  http://www.jianshu.com/p/0c050af6c5ee

//1.必须保证有一个活跃的runloop。
//performSelector和scheduledTimerWithTimeInterval方法都是基于runloop的。我们知道，当一个应用启动时，系统会开启一个主线程，并且把主线程的runloop激活，也就是run起来，并且主线程的runloop是不会停止的。所以，当这两个方法在主线程可以被正常调用。但情况往往不是这样的。实际编码中，我们更多的逻辑是放在子线程中执行的。而子线程的runloop是默认关闭的。这时如果不手动激活runloop，performSelector和scheduledTimerWithTimeInterval的调用将是无效的。
//
//2.NSTimer的创建与撤销必须在同一个线程操作、performSelector的创建与撤销必须在同一个线程操作。
//
//3.内存管理有潜在泄露的风险
//文／Joey_Xu（简书作者）
//原文链接：http://www.jianshu.com/p/0c050af6c5ee
//著作权归作者所有，转载请联系作者获得授权，并标注“简书作者”。


#import "XXGCDTimer.h"

@interface XXGCDTimer()
{
    dispatch_source_t _timer;
}
@end

@implementation XXGCDTimer

-(void) startGCDTimer{
    
    NSTimeInterval period = 1.0; //设置时间间隔
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
     _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        //在这里执行事件
        NSLog(@"每秒执行test");
    });
    
    dispatch_resume(_timer);
}

-(void) pauseTimer{
    if(_timer){
        dispatch_suspend(_timer);
    }
}

-(void) resumeTimer{
    if(_timer){
        dispatch_resume(_timer);
    }
}

-(void) stopTimer{
    if(_timer){
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

@end
