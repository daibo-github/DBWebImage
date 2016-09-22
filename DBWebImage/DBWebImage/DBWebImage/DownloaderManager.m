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

@property (nonatomic, strong) NSMutableDictionary *imagesCache;

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
        self.imagesCache = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void)downloadImageWithURLString:(NSString *)URLString successBlock:(void(^)(UIImage *image))successBlock
{
    if ([self checkCaches:URLString]) {
        
        UIImage *image = [self.imagesCache objectForKey:URLString];
        
        if (successBlock) {
            successBlock(image);
        }
        
        return;
    }
    
    if ([self.OPCaches objectForKey:URLString]) {
        return;
    }
    
    void(^managerBlock)() = ^(UIImage *image){
        
        NSLog(@"从网络加载...%@",URLString);
        
        if (successBlock) {
            successBlock(image);
        }
        
        [self.OPCaches removeObjectForKey:URLString];
        
        [self.imagesCache setObject:image forKey:URLString];
        
    };
    
    DownloaderOperation *op = [DownloaderOperation downloaderOperationWithURLString:URLString successBlock:managerBlock];
    
    [self.OPCaches setObject:op forKey:URLString];
    
    [self.queue addOperation:op];
}

- (BOOL)checkCaches:(NSString *)URLString
{
    if ([self.imagesCache objectForKey:URLString]) {
        
        NSLog(@"从内存加载...%@",URLString);
        
        return YES;
    }
    
    UIImage *cacheImage = [UIImage imageWithContentsOfFile:[URLString appendCaches]];
    
    if (cacheImage) {
        
        NSLog(@"从沙盒加载...%@",URLString);
        
        [self.imagesCache setObject:cacheImage forKey:URLString];
        
        return YES;
    }
    
    return NO;
}

- (void)cancelDownloadingOperationWithLastURLString:(NSString *)lastURLString
{
    DownloaderOperation *op = [self.OPCaches objectForKey:lastURLString];
    
    if (op != nil) {
        
        [op cancel];
        
        [self.OPCaches removeObjectForKey:lastURLString];
    }
    
//    [[self.OPCaches objectForKey:lastURLString] cancel];
//    
//    [self.OPCaches removeObjectForKey:lastURLString];
}



@end
