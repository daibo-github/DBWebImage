//
//  DownloaderOperation.h
//  DBWebImage
//
//  Created by 代波 on 16/9/21.
//  Copyright © 2016年 daibo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSString+path.h"

@interface DownloaderOperation : NSOperation

+ (instancetype)downloaderOperationWithURLString:(NSString *)URLString successBlock:(void(^)(UIImage *image))successBlock;

@end
