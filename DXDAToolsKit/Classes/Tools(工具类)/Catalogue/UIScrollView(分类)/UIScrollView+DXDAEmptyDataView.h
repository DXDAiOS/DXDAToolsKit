//
//  UIScrollView+DXDAEmptyDataView.h
//  x_App
//
//  Created by DXDA on 2017/7/13.
//  Copyright © 2017年 com.dxda.xapp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, EmptyType) {
    emptyType_empty,
    emptyType_order,
    emptyType_news,
    emptyType_refresh,
    emptyType_error,
    emptyType_custom,
    emptyType_supplier,
};

@interface EmptyView : UIView

+(instancetype)createWith:(UIView *)view type:(EmptyType)type tips:(NSString *)tips refresh:(void(^)())refresh;

@property (nonatomic,assign) EmptyType emptyType;

@property (nonatomic,strong) NSString *tips;

@end

@interface UIScrollView (DXDAEmptyDataView)

@property (nonatomic,strong) EmptyView *emptyView;

@end
