//
//  DXDACZSearchView.h
//  NewApp3.0
//
//  Created by DXDA on 2017/5/4.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DXDACZSearchView : UISearchBar

+(instancetype)createWith:(UIView *)view searchAction:(void(^)())search cancelAction:(void(^)())cancel;

@end
