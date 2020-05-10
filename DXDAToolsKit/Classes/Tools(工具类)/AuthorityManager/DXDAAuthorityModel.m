
//
//  DXDAAuthorityModel.m
//  x_App
//
//  Created by DXDA on 2017/6/13.
//  Copyright © 2017年 com.dxda.xapp. All rights reserved.
//

#import "DXDAAuthorityModel.h"

@implementation DXDAAuthorityModel

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.Role_ID forKey:@"Role_ID"];
    [encoder encodeObject:self.Fun_ID forKey:@"Fun_ID"];
    [encoder encodeObject:self.User_ID forKey:@"User_ID"];
    [encoder encodeObject:self.Power_ID forKey:@"Power_ID"];
    [encoder encodeObject:self.Remark_ID forKey:@"Remark_ID"];
    [encoder encodeObject:self.Valid_Flag forKey:@"Valid_Flag"];
    [encoder encodeObject:self.Fun_Name forKey:@"Fun_Name"];
    [encoder encodeObject:self.User_Name forKey:@"User_Name"];
}
- (id)initWithCoder:(NSCoder *)decoder
{
    if(self = [super init])
    {
        self.Role_ID = [decoder decodeObjectForKey:@"Role_ID"];
        self.Fun_ID = [decoder decodeObjectForKey:@"Fun_ID"];
        self.User_ID = [decoder decodeObjectForKey:@"User_ID"];
        self.Power_ID = [decoder decodeObjectForKey:@"Power_ID"];
        self.Remark_ID = [decoder decodeObjectForKey:@"Remark_ID"];
        self.Valid_Flag = [decoder decodeObjectForKey:@"Valid_Flag"];
        self.Fun_Name = [decoder decodeObjectForKey:@"Fun_Name"];
        self.User_Name = [decoder decodeObjectForKey:@"User_Name"];
    }
    return  self;
}

+(instancetype)createWithDic:(NSDictionary *)dict {
    return [[self alloc]initWithDict:dict];
}

-(instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+(NSMutableArray *)createWith:(NSArray *)array
{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSDictionary *dic in array)
    {
        [tempArray addObject:[self createWithDic:dic]];
    }
    return tempArray;
}

@end
