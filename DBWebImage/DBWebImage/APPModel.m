//
//  APPModel.m
//  AsyncDownLoadJPG01
//
//  Created by 代波 on 16/9/17.
//  Copyright © 2016年 daibo. All rights reserved.
//

#import "APPModel.h"

@implementation APPModel

+ (instancetype)appWithDict:(NSDictionary *)dict
{
    APPModel *app = [[APPModel alloc] init];
    
    [app setValuesForKeysWithDictionary:dict];
    
    return app;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@ %@",_name,_icon,_download];
}

@end
