//
//  ViewController.m
//  XXGCD
//
//  Created by tomxiang on 5/24/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//  https://github.com/ming1016/study/wiki/%E7%BB%86%E8%AF%B4GCD%EF%BC%88Grand-Central-Dispatch%EF%BC%89%E5%A6%82%E4%BD%95%E7%94%A8

#import "ViewController.h"
#import "XXGCDSemaphore.h"
#import "XXGCDGroup.h"
#import "XXGCDApply.h"
#import "XXGCDTimer.h"
#import "XXGCDSync.h"
#import "XXGCDGlobal.h"
#import "XXGCDSpecific.h"

@interface ViewController ()
{
    XXGCDTimer *gcdTimer;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self testSemaphore];
//    [self testSYNC];
//    [self testGroup];
//    [self testApply];
//    [self testGCDTimer];
//    [self testSYNC];
//    [self testGlobal];
    
    [self testSpecfic];
}

-(void) testSemaphore {
    XXGCDSemaphore *gcdSemaphore = [XXGCDSemaphore new];
    [gcdSemaphore testSemaphore];
//    [gcdSemaphore testAsynFinished];
//    [gcdSemaphore testProductAndConsumer];
}

-(void) testGroup{
    XXGCDGroup *gcdGroup = [XXGCDGroup new];
//    [gcdGroup testGCDGroup];
//    [gcdGroup testGCDGroup2];
    [gcdGroup testGCDGroup3];
}

-(void) testApply{
    XXGCDApply *gcdApply = [[XXGCDApply alloc] init];
    [gcdApply testGCDApply];
}

-(void) testGCDTimer{
    gcdTimer = [XXGCDTimer new];
    [gcdTimer startGCDTimer];
}

-(void) testSYNC{
    XXGCDSync *sync = [[XXGCDSync alloc] init];
//    [sync startSYNC];
    [sync testSYNC2];
//    [sync startASYNC];
}

-(void) testGlobal{
    XXGCDGlobal *global = [XXGCDGlobal new];
    [global test];
}

-(void) testSpecfic{
    XXGCDSpecific *spec = [XXGCDSpecific new];
//    [spec startAsyncSpecific];
    [spec startSyncSpecific];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
