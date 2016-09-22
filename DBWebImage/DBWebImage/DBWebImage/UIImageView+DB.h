//
//  UIImageView+DB.h
//  DBWebImage
//
//  Created by 代波 on 16/9/22.
//  Copyright © 2016年 daibo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloaderManager.h"

@interface UIImageView (DB)

- (void)DB_setImageWithURLString:(NSString *)URLString;

@property (nonatomic,copy) NSString *lastURLString;

@end
