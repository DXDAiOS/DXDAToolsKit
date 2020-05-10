//
//  DXDASingleton.m
//  NewApp3.0
//
//  Created by DXDA on 2017/3/28.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import "DXDASingleton.h"

static DXDASingleton *single = nil;
@implementation DXDASingleton

+(instancetype)share {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single = [[self alloc] init];
    });
    return single;
}

-(NSMutableDictionary *)requestDic {
    if (!_requestDic) {
        _requestDic = [NSMutableDictionary dictionary];
    }
    return _requestDic;
}

@end
