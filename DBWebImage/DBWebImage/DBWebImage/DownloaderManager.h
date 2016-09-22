//
//  DownloaderManager.h
//  DBWebImage
//
//  Created by 代波 on 16/9/22.
//  Copyright © 2016年 daibo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DownloaderManager : NSObject

+ (instancetype)sharedManager;

- (void)downloadImageWithURLString:(NSString *)URLString successBlock:(void(^)(UIImage *image))successBlock;

@end
