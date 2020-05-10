//
//  FQRollTextView.h
//  FQRollText
//
//  Created by Erowin on 16/10/28.
//  Copyright © 2016年 DXDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FQRollTextView : UIView

+(instancetype)sharedRollTextView;

@property(nonatomic,strong)NSArray *datas;

@end
