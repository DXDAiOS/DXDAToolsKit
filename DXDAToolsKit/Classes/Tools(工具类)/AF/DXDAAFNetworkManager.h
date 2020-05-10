//
//  DXDAAFNetworkManager.h
//  NewApp3.0
//
//  Created by 东信达 on 2017/3/24.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/NSObject.h>
#import <UIKit/UIKit.h>

@interface DXDAAFNetworkManager : NSObject<NSXMLParserDelegate>

/**
 *  发送get请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(id responseObject))success
                 failure:(void (^)(NSString *error))failure;

/**
 *  发送post请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSString *error))failure;

+ (void)postWithURLStringWithError:(NSString *)URLString
                        parameters:(id)parameters
                           success:(void (^)(id))success
                           failure:(void (^)(NSError *))failure;

+ (void)responseCancel;

// 监听网络变化
+(void)monitorNetworkState;

@end
