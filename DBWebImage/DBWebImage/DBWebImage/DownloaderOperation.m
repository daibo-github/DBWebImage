//
//  DownloaderOperation.m
//  DBWebImage
//
//  Created by 代波 on 16/9/21.
//  Copyright © 2016年 daibo. All rights reserved.
//

#import "DownloaderOperation.h"


@interface DownloaderOperation ()

@property (nonatomic, copy) NSString *URLString;

@property (nonatomic, copy) void(^successBlock)(UIImage *image);

@end

@implementation DownloaderOperation

+ (instancetype)downloaderOperationWithURLString:(NSString *)URLString successBlock:(void(^)(UIImage *image))successBlock
{
    DownloaderOperation *op = [[DownloaderOperation alloc] init];
    
    op.URLString = URLString;
    op.successBlock = successBlock;
    
    return op;
}

- (void)main
{
    NSLog(@"传入--%@",self.URLString);
    
    [NSThread sleepForTimeInterval:1.0];
    
    NSURL *URL = [NSURL URLWithString:self.URLString];
    NSData *data = [NSData dataWithContentsOfURL:URL];
    UIImage *image = [UIImage imageWithData:data];
    
    if (image) {
        
        [data writeToFile:[self.URLString appendCaches] atomically:YES];
    }
    
    if (self.isCancelled) {
        NSLog(@"取消--%@",self.URLString);
        return;
    }
    
//    NSAssert(self.successBlock != nil, @"图片传递代码块不能为空!");
    
    if (self.successBlock != nil) {
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            NSLog(@"完成--%@",self.URLString);
            
            self.successBlock(image);
        }];
    }
    
    
}

@end
