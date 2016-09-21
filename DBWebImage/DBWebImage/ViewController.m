//
//  ViewController.m
//  DBWebImage
//
//  Created by 代波 on 16/9/21.
//  Copyright © 2016年 daibo. All rights reserved.
//

#import "ViewController.h"
#import "DownloaderOperation.h"
#import "AFNetworking.h"
#import "YYModel.h"
#import "APPModel.h"

@interface ViewController ()

@property (nonatomic, strong) NSOperationQueue *queue;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (nonatomic,strong) NSArray *appList;

@property (nonatomic, strong) NSMutableDictionary *OPCaches;

@property (nonatomic, copy) NSString *lastURLString;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.queue = [[NSOperationQueue alloc] init];
    
    self.OPCaches = [[NSMutableDictionary alloc] init];
    
    [self loadJSONData];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    int random = arc4random_uniform((u_int32_t)self.appList.count);
    
    APPModel *app = self.appList[random];
    
    if (![app.icon isEqualToString:self.lastURLString] && self.lastURLString != nil) {
        
        [[self.OPCaches objectForKey:self.lastURLString] cancel];
        
        [self.OPCaches removeObjectForKey:self.lastURLString];
    }
    
    self.lastURLString = app.icon;
    
    DownloaderOperation *op = [DownloaderOperation downloaderOperationWithURLString:app.icon successBlock:^(UIImage *image) {
        
        self.iconImageView.image = image;
    }];
    
    [self.OPCaches setObject:op forKey:app.icon];
    
    [self.queue addOperation:op];
}

- (void)loadJSONData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"https://raw.githubusercontent.com/daibo-github/ServerFileDownLoadJSON/master/apps.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        self.appList = [NSArray yy_modelArrayWithClass:[APPModel class] json:responseObject];
        NSLog(@"%@",self.appList);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

@end
