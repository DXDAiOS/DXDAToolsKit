//
//  OtherInfoModel.m
//  RxdaApp
//
//  Created by Erowin on 16/9/23.
//  Copyright © 2016年 Fady. All rights reserved.
//

#import "OtherInfoModel.h"

@implementation OtherInfoModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.gesture forKey:@"gesture"];
    [aCoder encodeBool:self.isOpenGesture forKey:@"isOpenGesture"];
    [aCoder encodeObject:self.strUserID forKey:@"strUserID"];
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self.gesture = [aDecoder decodeObjectForKey:@"gesture"];
    self.isOpenGesture = [aDecoder decodeBoolForKey:@"isOpenGesture"];
    self.strUserID = [aDecoder decodeObjectForKey:@"strUserID"];
    return self;
}

@end
