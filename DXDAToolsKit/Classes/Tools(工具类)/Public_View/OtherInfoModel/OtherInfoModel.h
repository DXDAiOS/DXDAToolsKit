//
//  OtherInfoModel.h
//  RxdaApp
//
//  Created by Erowin on 16/9/23.
//  Copyright © 2016年 Fady. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OtherInfoModel : NSObject<NSCoding>

@property(nonatomic,strong)NSString *strUserID;

//手势密码
@property(nonatomic,strong)NSString *gesture;
//是否开启手势
@property(nonatomic,assign)BOOL isOpenGesture;

@end
