//
//  NetworkingHandler.m
//  UI22_NSURLSession
//
//  Created by Scott on 16/6/1.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "NetworkingHandler.h"

@interface NetworkingHandler () <NSURLSessionDelegate, NSURLSessionDataDelegate>

// 用来接收网络数据.
@property (nonatomic, strong) NSMutableData *mData;

@end

@implementation NetworkingHandler

#pragma mark - public
- (void)netWorkingHandlerGETWithURL:(NSString *)string completion:(void(^)(id result, NSData *data, NSURLResponse *response, NSError *error))completion {
    
    NSURL *url = [self encodingURLWithString:string];
    
    // Core API:
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 向session中添加任务(data)
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
     
        
        // data 解析.
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        
        // 进入主线程, block对调.
        dispatch_async(dispatch_get_main_queue(), ^{
            
            completion(result, data, response, error);
            
        });
    
    }];
    
    // 开始任务
    [dataTask resume];
}

- (void)networkingHandlerGetWithURL:(NSString *)string {
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURL *url = [self encodingURLWithString:string];
    
    // Core API
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    // 向session中添加任务(data)
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
    
    
    // 开始任务.
    [dataTask resume];
    
}

- (void)networkingHandlePOSTWithURL:(NSString *)urlstring httpBody:(NSString *)body completion:(void (^)(id result, NSData *data, NSURLResponse *response, NSError *error))completion {
    
    NSURL *url = [NSURL URLWithString:urlstring];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // httpMethod
    request.HTTPMethod = @"POST";
    
    // httpBody
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    
    
    // Core API
    NSURLSession *session = [NSURLSession sharedSession];
    
    
    
    // add Task
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        // 解析
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        // 向主线程中, 分配任务
        dispatch_async(dispatch_get_main_queue(), ^{
           
            completion(result, data, response, error);
    
        });

    }];
    
    // 开始任务.
    [dataTask resume];
    
}



- (void)networkingHandlePOSTWithURL:(NSString *)urlstring httpBody:(NSString *)body {
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlstring]];
    
    request.HTTPMethod = @"POST";
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    
    // Core API
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    
    
    // add Task
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
    
    [dataTask resume];

}


#pragma mark - data delegate
/** 收到服务器响应时, 调用此方法. */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    

    // 初始化.
    self.mData = [NSMutableData data];
    
    // 调用block
    completionHandler(NSURLSessionResponseAllow);
    
}

/** 从服务器接收到数据, 调用此方法, 此方法根据数据的大小, 可能会调用多次. */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    

    
    // 数据拼接.
    [self.mData appendData:data];
    
}

#pragma mark - task delegate
/** 当任务完成时候, 调用此协议方法. */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    

    
    // 解析数据.
    id result = [NSJSONSerialization JSONObjectWithData:self.mData options:NSJSONReadingMutableContainers error:nil];
    
    // 通过delegate回调数据.
    if ([self.delegate respondsToSelector:@selector(didCompleteWithJSONResult:receiveData:)]) {
        
        // 向主线程添加任务.
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.delegate didCompleteWithJSONResult:result receiveData:self.mData];
            
        });
        
    }

}



#pragma mark - private
- (NSURL *)encodingURLWithString:(NSString *)string {
    
    // Core API
//    NSString *decode = [string stringByRemovingPercentEncoding];
    
//    NSString *encodingStr = [decode stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    
    NSURL *url = [NSURL URLWithString:string];
    
    return url;

}




@end
