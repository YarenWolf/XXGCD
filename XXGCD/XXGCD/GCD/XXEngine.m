//
//  XXEngine.m
//  XXGCD
//
//  Created by tomxiang on 5/24/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "XXEngine.h"

@implementation XXEngine

+(instancetype) instance{
    static dispatch_once_t onceToken;
    static XXEngine *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(void) queryCompletion:(void (^)(BOOL isOpen)) successBlock
                onError:(void (^)(BOOL isOpen,int errorCode)) errorBlock{

    [NSThread sleepForTimeInterval:3.f];
    successBlock(YES);
}

-(void) doAsyncWorkWithCompletionBlock:(void (^)()) successBlock{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"%s",__func__);
        [NSThread sleepForTimeInterval:2.f];
        successBlock();
    });
}

@end
