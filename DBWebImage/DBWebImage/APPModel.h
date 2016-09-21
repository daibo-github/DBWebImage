//
//  APPModel.h
//  AsyncDownLoadJPG01
//
//  Created by 代波 on 16/9/17.
//  Copyright © 2016年 daibo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APPModel : NSObject

@property (nonatomic,copy) NSString *name;

@property (nonatomic,copy) NSString *icon;

@property (nonatomic,copy) NSString *download;

+ (instancetype)appWithDict:(NSDictionary *)dict;

@end
