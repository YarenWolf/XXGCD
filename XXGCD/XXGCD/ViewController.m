//
//  ViewController.m
//  XXGCD
//
//  Created by tomxiang on 5/24/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "ViewController.h"
#import "XXGCDSemaphore.h"
#import "XXGCDGroup.h"
#import "XXGCDApply.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void) testSemaphore {
    XXGCDSemaphore *gcdSemaphore = [XXGCDSemaphore new];
    [gcdSemaphore testSemaphore];
    [gcdSemaphore testProductAndConsumer];
}

-(void) testGroup{
    XXGCDGroup *gcdGroup = [XXGCDGroup new];
    [gcdGroup testGCDGroup];
    [gcdGroup testGCDGroup2];
    [gcdGroup testGCDGroup3];
}

-(void) testApply{
    XXGCDApply *gcdApply = [[XXGCDApply alloc] init];
    [gcdApply testGCDApply];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
