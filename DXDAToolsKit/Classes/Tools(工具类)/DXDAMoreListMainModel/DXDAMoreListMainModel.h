//
//  DXDAMoreListMainModel.h
//  NewApp3.0
//
//  Created by DXDA on 2019/9/2.
//  Copyright © 2019 DXDA. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DXDAMoreListMainModel : NSObject

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *approved;

@property(nonatomic,copy)NSString *trans_date_begin;
@property(nonatomic,copy)NSString *trans_date_end;

@property(nonatomic,assign)BOOL isSelect;

//计划类型
@property(nonatomic,copy)NSString *period;

//部门
@property(nonatomic,copy)NSString *dept_id;
@property(nonatomic,copy)NSString *parent_dept_id;
//创建人
@property(nonatomic,copy)NSString *User_ID;
@property(nonatomic,copy)NSString *User_Name;

@property (nonatomic, copy) NSString *customer_id;
@property (nonatomic, copy) NSString *vendor_id;
@property (nonatomic, copy) NSString *full_name;

@property (nonatomic, copy) NSString *min_amt;
@property (nonatomic, copy) NSString *max_amt;

@property(nonatomic,assign) NSInteger status;
@property (nonatomic, copy) NSString *if_Business;

@property(nonatomic,copy)NSString *if_business_chg;

@property(nonatomic,assign)NSInteger index;

@property(nonatomic,copy)NSString *process_id;

@property(nonatomic,copy)NSString *if_myself;



@property(nonatomic,copy)NSString *desc;//部门名称
@property(nonatomic,copy)NSString *address;//地址
@property(nonatomic,copy)NSString *fax;//传真

@property (nonatomic,copy) NSString *telephone;
@property (nonatomic,copy) NSString *parent_name;  //上级部门
@property (nonatomic,copy) NSString *supervisor_name;  //主管名
@property (nonatomic,copy) NSString *province;
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *district;




/**
 *  每个节点类型
 */
@property (nonatomic , assign) int parentId;//父节点的id，如果为-1表示该节点为根节点

@property (nonatomic , assign) int nodeId;//本节点的id

@property (nonatomic , strong) NSString *name;//本节点的名称

@property (nonatomic , assign) int depth;//该节点的深度

@property (nonatomic , assign) BOOL expand;//该节点是否处于展开状态

@end

NS_ASSUME_NONNULL_END
