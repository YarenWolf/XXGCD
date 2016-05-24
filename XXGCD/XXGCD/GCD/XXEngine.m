//
//  XXEngine.m
//  XXGCD
//
//  Created by tomxiang on 5/24/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "XXEngine.h"

@implementation XXEngine

-(void) queryCompletion:(void (^)(BOOL isOpen)) successBlock
                onError:(void (^)(BOOL isOpen,int errorCode)) errorBlock{

    [NSThread sleepForTimeInterval:3.f];
    successBlock(YES);
}

@end
