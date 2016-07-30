//
//  ViewController.m
//  03操作间的依赖
//
//  Created by 李朝霞 on 16/7/29.
//  Copyright © 2016年 李朝霞. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,strong)NSOperationQueue* queue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.queue = [[NSOperationQueue alloc]init];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self demo1];
}

- (void)demo1
{
    //登录
    NSBlockOperation* loginUp = [NSBlockOperation blockOperationWithBlock:^{
        
        [NSThread sleepForTimeInterval:3];
        
        NSLog(@"登陆成功！ %@",[NSThread currentThread]);
    }];
    //下载1
    
    NSBlockOperation* down1 = [NSBlockOperation blockOperationWithBlock:^{
        
        [NSThread sleepForTimeInterval:2];
        
         NSLog(@"down1成功！ %@",[NSThread currentThread]);
    }];
    
    
    
      //下载2
    NSBlockOperation* down2 = [NSBlockOperation blockOperationWithBlock:^{
        
        [NSThread sleepForTimeInterval:5];
        
        NSLog(@"down2成功！ %@",[NSThread currentThread]);
    }];
    
    
    [down1 addDependency:loginUp];
    [down2 addDependency:loginUp];
    
    [self.queue addOperations:@[loginUp,down1,down2] waitUntilFinished:false];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
