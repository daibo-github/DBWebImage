//
//  DownloaderOperation.m
//  DBWebImage
//
//  Created by 代波 on 16/9/21.
//  Copyright © 2016年 daibo. All rights reserved.
//

#import "DownloaderOperation.h"

@implementation DownloaderOperation

- (void)main
{
    NSURL *URL = [NSURL URLWithString:self.URLString];
    NSData *data = [NSData dataWithContentsOfURL:URL];
    UIImage *image = [UIImage imageWithData:data];
    
    if (self.successBlock != nil) {
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            self.successBlock(image);
        }];
    }
    
    
}

@end
