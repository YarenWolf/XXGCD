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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    XXGCDSemaphore *gcdSemaphore = [XXGCDSemaphore new];
//    [gcdSemaphore testSemaphore];
//    [gcdSemaphore testProductAndConsumer];
    
    
    XXGCDGroup *gcdGroup = [XXGCDGroup new];
//    [gcdGroup testGCDGroup];
//    [gcdGroup testGCDGroup2];
    [gcdGroup testGCDGroup3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
