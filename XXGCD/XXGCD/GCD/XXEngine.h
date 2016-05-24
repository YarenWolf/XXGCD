//
//  XXEngine.h
//  XXGCD
//
//  Created by tomxiang on 5/24/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXEngine : NSObject

+(instancetype) instance;

-(void) queryCompletion:(void (^)(BOOL isOpen)) successBlock
                onError:(void (^)(BOOL isOpen,int errorCode)) errorBlock;

-(void) doAsyncWorkWithCompletionBlock:(void (^)()) successBlock;

@end
