//
//  UITableViewCell+InitCell.h
//  NewApp3.0
//
//  Created by DXDA on 2017/10/24.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (InitCell)

+(instancetype)createWith:(UITableView *)tableView identy:(NSString *)identy;

-(void)setup;

-(void)selectionStyleNone;

@end
