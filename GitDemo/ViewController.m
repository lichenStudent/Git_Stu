//
//  ViewController.m
//  GitDemo
//
//  Created by  lichen on 16/6/30.
//  Copyright © 2016年  lichen. All rights reserved.
//

#import "ViewController.h"
#import "TestClass.h"

@interface ViewController ()

@property (assign, nonatomic) int sum;
@property (strong, nonatomic) TestClass *testClass;
@property (strong, nonatomic) NSObject *obj;

- (void)sayGoodBye;
- (void)sayHello;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _obj = [[NSObject alloc]init];
    
    int a    = 5;
<<<<<<< HEAD
    int b    = 10;
=======
    int b    = 15;
>>>>>>> develop
    self.sum = a + b;
    
    NSLog(@"The Result is:%d",self.sum);
    
    [self sayGoodBye];
    
    [self sayHello];
    

}

- (void)sayGoodBye
{
    NSLog(@"byebye world!");
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized (_obj) {
            NSLog(@"执行操作1---开始");
            sleep(3);
            NSLog(@"执行操作2---开始");
        }
    });
    
}

- (void)sayHello
{
    NSLog(@"hello world!");
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        @synchronized (_obj) {
            NSLog(@"执行操作3---开始");
        }
    });
    
    dispatch_semaphore_t signal = dispatch_semaphore_create(1);
    dispatch_time_t overTime = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_semaphore_wait(signal, overTime);
        NSLog(@"需要线程同步的操作1 开始");
        sleep(3);
        NSLog(@"需要线程同步的操作1 结束");
        dispatch_semaphore_signal(signal);
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        dispatch_semaphore_wait(signal, overTime);
        NSLog(@"需要线程同步的操作2");
        dispatch_semaphore_signal(signal);
    });
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
