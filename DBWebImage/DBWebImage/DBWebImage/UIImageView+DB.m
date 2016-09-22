//
//  UIImageView+DB.m
//  DBWebImage
//
//  Created by 代波 on 16/9/22.
//  Copyright © 2016年 daibo. All rights reserved.
//

#import "UIImageView+DB.h"
#import <objc/runtime.h>

@implementation UIImageView (DB)

- (void)setLastURLString:(NSString *)lastURLString
{
    objc_setAssociatedObject(self, "key", lastURLString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)lastURLString
{
    return objc_getAssociatedObject(self, "key");
}

- (void)DB_setImageWithURLString:(NSString *)URLString
{
    if (![URLString isEqualToString:self.lastURLString] && self.lastURLString != nil) {
        
        [[DownloaderManager sharedManager] cancelDownloadingOperationWithLastURLString:self.lastURLString];
        
    }
    
    self.lastURLString = URLString;
    
    DownloaderManager *manager = [DownloaderManager sharedManager];
    
    [manager downloadImageWithURLString:URLString successBlock:^(UIImage *image) {
        
        self.image = image;
    }];
}

@end
