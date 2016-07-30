//
//  ViewController.m
//  03GCD的Barrier
//
//  Created by 李朝霞 on 16/7/30.
//  Copyright © 2016年 李朝霞. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,strong)NSMutableArray* arrayM;
//并发队列
@property(nonatomic,strong)dispatch_queue_t queue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.arrayM = [NSMutableArray array];
    
    self.queue = dispatch_queue_create("com.lizhaoxia.queue", DISPATCH_QUEUE_CONCURRENT );
    
    [self addImage];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%ld",self.arrayM.count);
}

- (void)addImage
{
    for (int i = 0; i<20; i++) {
        dispatch_async(self.queue, ^{
            NSLog(@"async = %@",[NSThread currentThread]);
            
            NSString* name = [NSString stringWithFormat:@"%02d.jpg",(i%10+1)];
            
            NSURL* url = [[NSBundle mainBundle]URLForResource:name withExtension:nil];
            
            NSData* data = [NSData dataWithContentsOfURL:url];
            
            UIImage* image = [UIImage imageWithData:data];
            
            if (image == nil) {
                 NSLog(@"image 为 nil");
            }
            
            dispatch_barrier_async(self.queue, ^{
                NSLog(@"barrier = %@", [NSThread currentThread]);
                [self.arrayM addObject:image];

            });
            
        });
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
