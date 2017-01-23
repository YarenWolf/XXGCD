//
//  XXGCDSpecific.m
//  XXGCD
//
//  Created by XiangChenyu on 2017/1/23.
//  Copyright © 2017年 tomxiang. All rights reserved.
//

#import "XXGCDSpecific.h"

static const void * kAsyncDispatchQueueSpecificKey = &kAsyncDispatchQueueSpecificKey;

static const void * kSyncDispatchQueueSpecificKey = &kSyncDispatchQueueSpecificKey;

@interface XXGCDSpecific()

@property(nonatomic,strong) dispatch_queue_t queueAsync;
@property(nonatomic,strong) dispatch_queue_t queueSync;

@end

@implementation XXGCDSpecific


-(instancetype)init{
    if (self = [super init]) {
        _queueAsync = dispatch_queue_create([[NSString stringWithFormat:@"fmdbASync.%@",self] UTF8String], NULL);
        dispatch_queue_set_specific(_queueAsync, kAsyncDispatchQueueSpecificKey, (__bridge void * _Nullable)(self), NULL);
        
        _queueSync = dispatch_queue_create([[NSString stringWithFormat:@"fmdbSync.%@",self] UTF8String], NULL);
        dispatch_queue_set_specific(_queueSync, kSyncDispatchQueueSpecificKey, (__bridge void * _Nullable)(self), NULL);

    }
    return self;
}

#pragma mark- Async
-(void) startAsyncSpecific{
    [self performAsyncBlock:^{
        NSLog(@"EndtAsyncSpecific!!");
    }];
}

-(void) performAsyncBlock:(void(^)()) block
{
    if(block == nil){
        return;
    }
    //如果当前线程是 kAsyncDispatchQueueSpecificKey 所在的线程
    if(dispatch_get_specific(kAsyncDispatchQueueSpecificKey)){
        block();
    }else{
        dispatch_async(_queueAsync, block);
    }
}


-(void) startSyncSpecific{
    int result = [self getResult];
    
    NSLog(@"result:%d",result);
}

-(int) getResult{
    __block int result = 5;
    dispatch_block_t block = ^{
        result = 1;
    };
    
    if(dispatch_get_specific(kSyncDispatchQueueSpecificKey)){
        block();
    }else{
        dispatch_sync(_queueSync, block);
    }
    return result;
}


@end
