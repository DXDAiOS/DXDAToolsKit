
//
//  DXDAAFNetworkManager.m
//  NewApp3.0
//
//  Created by 东信达 on 2017/3/24.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import "DXDAAFNetworkManager.h"
#import "XMLReader.h"
#import "ZYNetworkAccessibity.h"

@implementation DXDAAFNetworkManager

+(instancetype)parse{
    static DXDAAFNetworkManager *user = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        user = [[self alloc] init];
    });
    return user;
}

// ccz
+(AFHTTPSessionManager *)shareManager {
    static AFHTTPSessionManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [AFHTTPSessionManager manager];
    });
    return instance;
}

#pragma mark -- GET请求 --
+ (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(id))success
                 failure:(void (^)(NSString *))failure {
    
    
    // ccz 网络不可用提示
    [self alertNetworkChange];
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPSessionManager *manager = [DXDAAFNetworkManager shareManager];
    
    //可以接受的类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //请求队列的最大并发数
    //manager.operationQueue.maxConcurrentOperationCount = 5;
    //请求超时的时间
    //manager.requestSerializer.timeoutInterval = 5;
    
    [manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            success(resultDic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure([error localizedDescription]);
        }
    }];
}
#pragma mark -- POST请求 --
+ (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id))success
                  failure:(void (^)(NSString *))failure {
    
    [self alertNetworkChange];
    
    // ccz
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPSessionManager *manager = [DXDAAFNetworkManager shareManager];
    
    //请求超时的时间
    manager.requestSerializer.timeoutInterval = 30;
    //
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues = YES;
    manager.responseSerializer = response;
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            // ccz dispatch_async
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                // 解析XML
                NSString * str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSXMLParser *par = [[NSXMLParser alloc] initWithData:responseObject];
                par.delegate = [DXDAAFNetworkManager parse];
                [par parse];
                
                // ccz
////                if ([str containsString:@"\"\"\"\""]) {
//                    str = [str stringByReplacingOccurrencesOfString:@"\"\"\"\"" withString:@"\"\""];
//                }
//                if ([str containsString:@"'"]) {
//                    str = [str stringByReplacingOccurrencesOfString:@"'" withString:@"\""];
//                }
//                if ([str containsString:@"服务器繁忙"]) {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        failure ? failure(@"网络异常，请检查网络!") : nil;
//                    });
//                    return ;
//                }
                
                // 解析XML为NSDictionary
                NSError *parseError = nil;
                NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:str error:&parseError];
                NSData *jsonData = [[[xmlDictionary valueForKey:@"string"] valueForKey:@"text"] dataUsingEncoding:NSUTF8StringEncoding];
                
                NSError *err;
                
                if (!jsonData) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        failure ? failure(@"查询数据失败，请稍后重试!") : nil;
                    });
                    return ;
                }
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
                
                if (!dic) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        failure ? failure(@"查询数据失败，请稍后重试!") : nil;
                    });
                    return;
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    success(dic);
                });
                
            });
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            if (error.code == -1001) {
                failure(@"请求超时，请稍后重试!");
            }
            failure(@"网络异常，请检查网络!");
//            failure([error localizedDescription]);
        }
    }];
}

+ (void)postWithURLStringWithError:(NSString *)URLString
                        parameters:(id)parameters
                           success:(void (^)(id))success
                           failure:(void (^)(NSError *))failure {
    
    [self alertNetworkChange];
    
    // ccz
    //    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPSessionManager *manager = [DXDAAFNetworkManager shareManager];
    
    //请求超时的时间
    manager.requestSerializer.timeoutInterval = 30;
    //
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues = YES;
    manager.responseSerializer = response;
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            // ccz dispatch_async
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                // 解析XML
                NSString * str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSXMLParser *par = [[NSXMLParser alloc] initWithData:responseObject];
                par.delegate = [DXDAAFNetworkManager parse];
                [par parse];
                
                // ccz
                ////                if ([str containsString:@"\"\"\"\""]) {
                //                    str = [str stringByReplacingOccurrencesOfString:@"\"\"\"\"" withString:@"\"\""];
                //                }
                //                if ([str containsString:@"'"]) {
                //                    str = [str stringByReplacingOccurrencesOfString:@"'" withString:@"\""];
                //                }
                //                if ([str containsString:@"服务器繁忙"]) {
                //                    dispatch_async(dispatch_get_main_queue(), ^{
                //                        failure ? failure(@"网络异常，请检查网络!") : nil;
                //                    });
                //                    return ;
                //                }
                
                // 解析XML为NSDictionary
                NSError *parseError = nil;
                NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:str error:&parseError];
                NSData *jsonData = [[[xmlDictionary valueForKey:@"string"] valueForKey:@"text"] dataUsingEncoding:NSUTF8StringEncoding];
                
                NSError *err;
                
                if (!jsonData) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        failure ? failure(@"查询数据失败，请稍后重试!") : nil;
                    });
                    return ;
                }
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
                
                if (!dic) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        failure ? failure(@"查询数据失败，请稍后重试!") : nil;
                    });
                    return;
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    success(dic);
                });
                
            });
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


+ (void)responseCancel
{
    
}



#pragma mark - 监听网络变化
+(void)alertNetworkChange {
    
    float currentVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (currentVersion < 10.0) {
        return;
    }
    
    ZYNetworkAccessibleState state = ZYNetworkAccessibity.currentState;
    if (state == ZYNetworkRestricted) {//判断网络权限是否被关闭
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"允许“%@”使用数据？",AppName] message:@"可能同时包含无线局域网和蜂窝移动数据" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"不允许" style:UIAlertActionStyleCancel handler:nil];
        
        UIAlertAction *alertB = [UIAlertAction actionWithTitle:@"允许" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([[UIApplication sharedApplication]
                 canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }
        }];
        
        [alertC addAction:alertA];
        [alertC addAction:alertB];
        
        [[UIApplication sharedApplication].windows lastObject];
        [[self getCurrentVC] presentViewController:alertC animated:YES completion:nil];
    }else{
        if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
            [[self getCurrentVC] showTips:@"网络异常，请检查网络！"];
        }
    }
    
    
    
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

#pragma mark - 监听网络变化
+(void)monitorNetworkState {
    AFHTTPSessionManager * manager = [DXDAAFNetworkManager shareManager];

    // 设置网络状态变化回调
//    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        switch (status) {
//            case AFNetworkReachabilityStatusNotReachable:
//                
//                // 设置网络请求的缓存政策
////                manager.requestSerializer.cachePolicy =  NSURLRequestReturnCacheDataDontLoad;
//                NSLog(@"断网状态");
//                
//                break;
//            case AFNetworkReachabilityStatusReachableViaWWAN:
//                
//                // 设置网络请求的缓存政策
////                manager.requestSerializer.cachePolicy =  NSURLRequestReturnCacheDataElseLoad;
//                NSLog(@"4G状态");
//                
//                break;
//            case AFNetworkReachabilityStatusReachableViaWiFi:
//                
//                // 设置网络请求的缓存政策
////                manager.requestSerializer.cachePolicy =  NSURLRequestReloadIgnoringLocalCacheData;
//                NSLog(@"WiFi状态");
//                break;
//                
//            default:
//                break;
//        }
//    }];
    // 开始监听
    [manager.reachabilityManager startMonitoring];
}






#pragma mark xmlparser
//step 1 :准备解析
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    //    NSLog(@"%@",NSStringFromSelector(_cmd) );
    
}
//step 2：准备解析节点
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    //    NSLog(@"%@",NSStringFromSelector(_cmd) );
}
//step 3:获取首尾节点间内容
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
//    NSLog(@"%@",NSStringFromSelector(_cmd) );
}

//step 4 ：解析完当前节点
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
//    NSLog(@"%@",NSStringFromSelector(_cmd) );
}

//step 5；解析结束
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    //    NSLog(@"%@",NSStringFromSelector(_cmd) );
}
//获取cdata块数据
- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
    //    NSLog(@"%@",NSStringFromSelector(_cmd) );
}

@end
