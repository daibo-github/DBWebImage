//
//  DownloaderOperation.h
//  DBWebImage
//
//  Created by 代波 on 16/9/21.
//  Copyright © 2016年 daibo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DownloaderOperation : NSOperation

@property (nonatomic, copy) NSString *URLString;

@property (nonatomic, copy) void(^successBlock)(UIImage *image);

@end
