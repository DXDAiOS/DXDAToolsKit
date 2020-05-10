//
//  NSString+path.m
//  RxdaApp
//
//  Created by Erowin on 16/9/9.
//  Copyright © 2016年 Fady. All rights reserved.
//

#import "NSString+path.h"

@implementation NSString (path)

+(NSString *)userDataPathWithFileName:(NSString *)fileName
{
    return  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileName];
}

@end
