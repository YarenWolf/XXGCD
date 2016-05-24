//
//  XXGCDSemaphore.m
//  XXGCD
//
//  Created by tomxiang on 5/24/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

//停车场剩余4个车位，那么即使同时来了四辆车也能停的下。如果此时来了五辆车，那么就有一辆需要等待。信号量的值就相当于车位的数目，dispatch_semaphore_wait函数就相当于来了一辆车，dispatch_semaphore_signal就相当于走了一辆车。停车位的剩余数目在初始化的时候就已经指明了（dispatch_semaphore_create（long value）），调用一次dispatch_semaphore_signal，剩余的车位就增加一个；调用一次dispatch_semaphore_wait剩余车位就减少一个；
//当剩余车位为0时，再来车（即调用dispatch_semaphore_wait）就只能等待。有可能同时有几辆车等待一个停车位。有些车主
//没有耐心，给自己设定了一段等待时间，这段时间内等不到停车位就走了，如果等到了就开进去停车。而有些车主就像把车停在这，
//所以就一直等下去。
//http://www.cnblogs.com/snailHL/p/3906112.html

//1. 创建信号量，可以设置信号量的资源数。0表示没有资源，调用dispatch_semaphore_wait会立即等待。
//dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
//
//2. 等待信号，可以设置超时参数。该函数返回0表示得到通知，非0表示超时。
//dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//
//3. 通知信号，如果等待线程被唤醒则返回非0，否则返回0。
//dispatch_semaphore_signal(semaphore);
//最后，还是回到生成消费者的例子，使用dispatch信号量是如何实现同步：
//http://blog.csdn.net/eduora_meimei/article/details/23129977

#import "XXGCDSemaphore.h"
#import "XXEngine.h"

@implementation XXGCDSemaphore

/**
 *  执行场景1:一个并发数为10的一个线程队列
 *  简单的介绍一下这一段代码，创建了一个初使值为10的semaphore，每一次for循环都会创建一个新的线程，线程结束的时候会发送一个信号，线程创建之前会信号等待，所以当同时创建了10个线程之后(使用Global Dispatch Queue创建的队列(例如下面的方法),其线程数目是不定的,是根据XNU内核决定的)，for循环就会阻塞，等待有线程结束之后会增加一个信号才继续执行，如此就形成了对并发的控制，如上就是一个并发数为10的一个线程队列。
 */
-(void) testSemaphore{
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(10); //信号总量是10
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0; i < 100; i++)
    {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);//信号量-1
        dispatch_group_async(group, queue, ^{
            NSLog(@"%i",i);
            sleep(2);
            dispatch_semaphore_signal(semaphore);   //信号量＋1
        });
    }
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
}

/**
 *  执行场景2:异步队列中做事，等待回调后执行某件事
 */
-(void) testAsynFinished{
    __block BOOL isok = NO;
    
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    
    XXEngine *engine = [[XXEngine alloc] init];
    [engine queryCompletion:^(BOOL isOpen) {
        isok = isOpen;
        dispatch_semaphore_signal(sema);
        NSLog(@"success!");
    } onError:^(BOOL isOpen, int errorCode) {
        isok = NO;
        dispatch_semaphore_signal(sema);
        NSLog(@"error!");

    }];
    NSLog(@"finished");
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}

/**
 *  执行场景3:生产者，消费者    生产者持续生产蛋糕，做完消费者立马拿
 */
-(void) testProductAndConsumer{
    
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    
    dispatch_queue_t producerQueue = dispatch_queue_create("producer", DISPATCH_QUEUE_CONCURRENT);//生产者线程跑的队列
    dispatch_queue_t consumerQueue = dispatch_queue_create("consumer", DISPATCH_QUEUE_CONCURRENT);//消费者线程跑的队列
    
    __block int cakeNumber = 0;
    
    dispatch_async(producerQueue,  ^{ //生产者队列
        while (1) {
            if (!dispatch_semaphore_signal(sem))
            {
                NSLog(@"Product:生产出了第%d个蛋糕",++cakeNumber);
                sleep(1); //wait for a while
                continue;
            }
        }
    });

    dispatch_async(consumerQueue,  ^{//消费者队列
        while (1) {
            if (dispatch_semaphore_wait(sem, dispatch_time(DISPATCH_TIME_NOW, 0*NSEC_PER_SEC))){
                if(cakeNumber > 0){
                    NSLog(@"Consumer:拿到了第%d个蛋糕",cakeNumber--);
                }
                continue;
            }
        }
    });
    

    
}

@end
