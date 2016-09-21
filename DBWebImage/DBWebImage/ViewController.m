//
//  ViewController.m
//  DBWebImage
//
//  Created by 代波 on 16/9/21.
//  Copyright © 2016年 daibo. All rights reserved.
//

#import "ViewController.h"
#import "DownloaderOperation.h"

@interface ViewController ()

@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.queue = [[NSOperationQueue alloc] init];
    
    DownloaderOperation *op = [[DownloaderOperation alloc] init];
    
    op.URLString = @"https://raw.githubusercontent.com/daibo-github/ServerFileDownLoadJSON/master/apps.json";
    
//    void (^successBlock)() = ^(UIImage *image){
//        NSLog(@"%@",[NSThread currentThread]);       
//    };
//    op.successBlock = successBlock;
    [op setSuccessBlock:^(UIImage *image) {
        NSLog(@"%@",[NSThread currentThread]);
    }];
    
    [self.queue addOperation:op];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    
}

@end
