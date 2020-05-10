//
//  DXDAAuthorityModel.h
//  x_App
//
//  Created by DXDA on 2017/6/13.
//  Copyright © 2017年 com.dxda.xapp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXDAAuthorityModel : NSObject

+(NSMutableArray *)createWith:(NSArray *)array;

@property(nonatomic,strong)NSString *Role_ID;
@property(nonatomic,strong)NSString *Fun_ID;
@property(nonatomic,strong)NSString *User_ID;
@property(nonatomic,strong)NSString *Power_ID;
@property(nonatomic,strong)NSString *Remark_ID;
@property(nonatomic,strong)NSString *Valid_Flag;
@property(nonatomic,strong)NSString *Fun_Name;
@property(nonatomic,strong)NSString *User_Name;

@end
