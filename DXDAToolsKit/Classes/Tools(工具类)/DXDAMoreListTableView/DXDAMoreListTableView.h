//
//  DXDAMoreListTableView.h
//  NewApp3.0
//
//  Created by DXDA on 2019/9/2.
//  Copyright © 2019 DXDA. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DXDAMoreListTableView : UITableView
@property (nonatomic, assign)ListCellType cellType;


-(void)updateData:(NSArray *)arrayData;
+(instancetype)createWith:(CGRect)frame cellType:(ListCellType)cellType;

@end

NS_ASSUME_NONNULL_END
