//
//  DownloaderManager.m
//  DBWebImage
//
//  Created by 代波 on 16/9/22.
//  Copyright © 2016年 daibo. All rights reserved.
//

#import "DownloaderManager.h"
#import "DownloaderOperation.h"

@interface DownloaderManager ()

@property (nonatomic, strong) NSMutableDictionary *OPCaches;

@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation DownloaderManager

+ (instancetype)sharedManager
{
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        
        self.OPCaches = [[NSMutableDictionary alloc] init];
        self.queue = [[NSOperationQueue alloc] init];
    }
    
    return self;
}

- (void)downloadImageWithURLString:(NSString *)URLString successBlock:(void(^)(UIImage *image))successBlock
{
    if ([self.OPCaches objectForKey:URLString]) {
        return;
    }
    
    void(^managerBlock)() = ^(UIImage *image){
        
        if (successBlock) {
            successBlock(image);
        }
        
        [self.OPCaches removeObjectForKey:URLString];
        
    };
    
    DownloaderOperation *op = [DownloaderOperation downloaderOperationWithURLString:URLString successBlock:managerBlock];
    
    [self.OPCaches setObject:op forKey:URLString];
    
    [self.queue addOperation:op];
}



@end
