//
//  UITableViewCell+InitCell.m
//  NewApp3.0
//
//  Created by DXDA on 2017/10/24.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import "UITableViewCell+InitCell.h"

@implementation UITableViewCell (InitCell)

+(instancetype)createWith:(UITableView *)tableView identy:(NSString *)identy {
    id cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
        [cell setup];
    }
    return cell;
}

-(void)setup {
    // do something
}

//MARK: - 取消点击效果
-(void)selectionStyleNone {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


@end
