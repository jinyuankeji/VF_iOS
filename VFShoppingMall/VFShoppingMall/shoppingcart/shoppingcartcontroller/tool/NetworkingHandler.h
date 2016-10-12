//
//  NetworkingHandler.h
//  UI22_NSURLSession
//
//  Created by Scott on 16/6/1.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetworkingHandlerDelegate <NSObject>

- (void)didCompleteWithJSONResult:(id)result receiveData:(NSData *)data;

@end

@interface NetworkingHandler : NSObject

@property (nonatomic, assign) id<NetworkingHandlerDelegate> delegate;


#pragma mark - GET
- (void)netWorkingHandlerGETWithURL:(NSString *)string completion:(void(^)(id result, NSData *data, NSURLResponse *response, NSError *error))completion;


- (void)networkingHandlerGetWithURL:(NSString *)string;

#pragma mark - POST
- (void)networkingHandlePOSTWithURL:(NSString *)urlstring httpBody:(NSString *)body completion:(void (^)(id result, NSData *data, NSURLResponse *response, NSError *error))completion;

- (void)networkingHandlePOSTWithURL:(NSString *)urlstring httpBody:(NSString *)body;














@end
