//
//  DXDAMoreListTableView.m
//  NewApp3.0
//
//  Created by DXDA on 2019/9/2.
//  Copyright © 2019 DXDA. All rights reserved.
//

#import "DXDAMoreListTableView.h"
#import "DXDADepartmentCell.h"
#import "DXDADepartmentModel.h"
#import "DXDAMoreListMainModel.h"

static NSString *const dxdaDepartmentCellID = @"dxdaDepartmentCellID";

@interface DXDAMoreListTableView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSMutableArray *categoryArray;
@property (nonatomic, strong)NSMutableArray *tempData;

@property (nonatomic,strong)DXDAMoreListMainModel *oneModel; //顶层
@property (nonatomic,strong)DXDAMoreListMainModel *twoModel; //父层
@property (nonatomic,strong)DXDAMoreListMainModel *subModel; //子层
@property (nonatomic,strong)DXDAMoreListMainModel *lastModel; //记录上一次点击的模型.

@property (assign,nonatomic) BOOL oneAction; //一级是否展开
@property (assign,nonatomic) BOOL lastAction; //二级是否展开
@end
@implementation DXDAMoreListTableView

+(instancetype)createWith:(CGRect)frame cellType:(ListCellType)cellType {
    DXDAMoreListTableView *instance = [[DXDAMoreListTableView alloc] initWithFrame:frame style:UITableViewStylePlain cellType:cellType];
    return instance;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style cellType:(ListCellType)cellType
{
    if (self = [super initWithFrame:frame style:style]) {
        self.cellType = cellType;
        [self setup];
    }
    return self;
}

-(void)setup
{
    self.delegate = self;
    self.dataSource = self;
    _categoryArray = [NSMutableArray array];
    _tempData = [NSMutableArray array];
    [self registerClass:[DXDADepartmentCell class] forCellReuseIdentifier:dxdaDepartmentCellID];
}
-(void)cleanModels
{
    self.oneModel = nil;
    self.twoModel = nil;
    self.subModel = nil;
    self.lastModel = nil;
    self.oneAction = NO;
    self.lastAction = NO;
}

-(void)updateData:(NSArray *)arrayData
{
    [self cleanModels];
    NSMutableArray *allArr = [NSMutableArray array];
    if (_cellType == ListCellType_department) {
     allArr = [self departmentArrayWith:arrayData];
    }
    [self paixuAction:allArr];
}

-(NSMutableArray *)departmentArrayWith:(NSArray *)arrayData
{

    NSMutableArray *allArr = [NSMutableArray array];
    for (DXDADepartmentModel *model in arrayData) {
        NSDictionary *dict = model.mj_keyValues;
        DXDAMoreListMainModel *mod = [DXDAMoreListMainModel mj_objectWithKeyValues:dict];
        [allArr addObject:mod];
    }
    return allArr;
}


-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tempData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (_cellType == ListCellType_department) {
        cell = [self department_returnCell:tableView indexPath:indexPath];
    }
    return cell;
}
-(UITableViewCell *)department_returnCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    
    DXDADepartmentCell *cell = [tableView dequeueReusableCellWithIdentifier:dxdaDepartmentCellID];
    if (cell == nil) {
        cell = (DXDADepartmentCell *)[[[NSBundle mainBundle]loadNibNamed:@"DXDADepartmentCell" owner:self options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    }
    DXDAMoreListMainModel *frameModel = self.tempData[indexPath.row];
    NSDictionary *dict = frameModel.mj_keyValues;
    
    DXDADepartmentModel *model = [DXDADepartmentModel mj_objectWithKeyValues:dict];
    
    cell.titleName.text = model.desc;
    cell.departmentID.text = model.dept_id;
    cell.address.text = model.address;
    cell.faxNum.text = model.fax;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_cellType == ListCellType_department) {
        return [self heightforRowWithIndexPath:indexPath];
    }
    return 100;
}
-(CGFloat)heightforRowWithIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self departmentForDidSelectWithTableView:tableView indexPath:indexPath];
    
}

//多级列表******************************* begin
-(void)paixuAction:(NSMutableArray *)allArr
{
    //筛选出根目录以及子级内容
    NSMutableArray *rootArr = [NSMutableArray array];
    NSMutableArray *subArr = [NSMutableArray array];
    [allArr enumerateObjectsUsingBlock:^(id  _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
        DXDAMoreListMainModel *rootModel = obj1;
        if (rootModel.parent_dept_id.length == 0) {
            [rootArr addObject:rootModel];
        }else{
            [subArr addObject:rootModel];
        }
    }];
    //子级目录
    NSMutableArray *twoArr = [NSMutableArray array];
    NSMutableDictionary *twoDict = [NSMutableDictionary dictionary];
    for (DXDAMoreListMainModel *model in rootArr) {
        NSMutableArray *twoA = [NSMutableArray array];
        for (DXDAMoreListMainModel *mod in subArr) {
            if ([model.dept_id isEqualToString:mod.parent_dept_id]) {
                [twoA addObject:mod];
                [twoArr addObject:mod];
            }
        }
        [twoDict setValue:twoA forKey:model.dept_id];
    }
     //孙集目录
    NSMutableDictionary *threeDict = [NSMutableDictionary dictionary];
    for (DXDAMoreListMainModel *model in twoArr) {
        NSMutableArray *threeA = [NSMutableArray array];
        for (DXDAMoreListMainModel *mod in subArr) {
            if ([model.dept_id isEqualToString:mod.parent_dept_id]) {
                [threeA addObject:mod];
            }
        }
        [threeDict setValue:threeA forKey:model.dept_id];
    }
    //重新编码排序
    NSMutableArray *cateARR = [NSMutableArray array];
    for (DXDAMoreListMainModel *model in rootArr) {
        model.parentId = -1;
        model.depth = 0;
        model.expand = YES;
        [cateARR addObject:model];
        
        BOOL rootBool = [[twoDict allKeys] containsObject:model.dept_id];
        if (rootBool == YES) {
            NSMutableArray *tempData = [NSMutableArray array];
            NSMutableArray *twoArray = twoDict[model.dept_id];
            for (DXDAMoreListMainModel *oneModel in twoArray) {
                oneModel.depth = 1;
                oneModel.expand = NO;
                [tempData addObject:oneModel];
                
                BOOL twoBool = [[threeDict allKeys] containsObject:oneModel.dept_id];
                if (twoBool == YES) {
                    NSMutableArray *threeArray = threeDict[oneModel.dept_id];
                    for (DXDAMoreListMainModel *twoModel in threeArray) {
                        twoModel.depth = 2;
                        twoModel.expand = NO;
                        [tempData addObject:twoModel];
                    }
                    
                }
            }
            [cateARR addObjectsFromArray:tempData];
        }
        
    }
    _categoryArray = cateARR;
    for (int i = 0; i < cateARR.count; i++) {
        DXDAMoreListMainModel *model = cateARR[i];
        model.nodeId = i;
    }
    //重新更新序号
    int oneNodeID = 0; //保存一级的nodeid
    int twoNodeID = 0; //保存二级的nodeid
    
    for (int i = 0; i < cateARR.count; i++) {
        DXDAMoreListMainModel *model = cateARR[i];
        DXDAMoreListMainModel *upModel = nil;
        if (i>0) {
            upModel = cateARR[i-1];
            if (model.depth == 0) { //一级
                //保存
                oneNodeID = model.nodeId;
                //设置
                model.parentId = -1;
                
            }else if (model.depth == 1){ //二级
                //保存
                twoNodeID = model.nodeId;
                //设置
                model.parentId = oneNodeID;
                
            }else{ //三级
                //设置
                model.parentId = twoNodeID;
            }
        }
    }
    
    _tempData =[self createTempData:_categoryArray];
    
    [self reloadData];
    
}
//分级时的初始化
-(NSMutableArray *)createTempData : (NSArray *)data{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i=0; i<data.count; i++) {
        DXDAMoreListMainModel *node = [_categoryArray objectAtIndex:i];
        if (node.expand) {
            [tempArray addObject:node];
        }
    }
    return tempArray;
}

-(void)departmentForDidSelectWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *index = indexPath;
    DXDAMoreListMainModel *frameModel = _tempData[index.row];
    if (frameModel.depth == 0) {
        //判断是否一级
        if ((frameModel.parentId == -1) && ![self.lastModel isEqual:frameModel] && ![self.oneModel isEqual:frameModel] && self.lastModel != nil && (frameModel.parentId != self.lastModel.nodeId)) {
            
            NSInteger i = [_tempData indexOfObject:self.oneModel];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            if (self.oneAction == YES) {
                [self threeTableviewActionWithIndex:indexPath];
            }
            
        }
        
    }else if (frameModel.depth == 1) {
        
        if (self.lastModel.depth >= 1 && ![self.twoModel isEqual:frameModel]) {
            
            NSInteger i = [_tempData indexOfObject:self.twoModel];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            if (self.lastAction == YES) {
                [self threeTableviewActionWithIndex:indexPath];
            }
        }
        
    }
    NSInteger i = [_tempData indexOfObject:frameModel];
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:i inSection:0];
    [self threeTableviewActionWithIndex:indexPath1]; //展开分级的操作
    
    if (frameModel.depth == 0) {
        self.oneModel = frameModel;
    }else if (frameModel.depth == 1){
        self.twoModel = frameModel;
    }else{
        self.subModel = frameModel;
    }
    self.lastModel = frameModel; //记录本次点击的模型.
}

//点击cell调用
-(void)threeTableviewActionWithIndex:(NSIndexPath *)indexPath
{
    //先修改数据源
    DXDAMoreListMainModel *parentNode = [_tempData objectAtIndex:indexPath.row];
    
    NSUInteger startPosition = indexPath.row+1;
    NSUInteger endPosition = startPosition;
    BOOL expand = NO;
    for (int i=0; i<_categoryArray.count; i++) {
        DXDAMoreListMainModel *node = [_categoryArray objectAtIndex:i];
        node.isSelect = NO; //默认展开的子级都是未选择状态
        
        if (node.parentId == parentNode.nodeId) {
            node.expand = !node.expand;
            if (node.expand) {
                [_tempData insertObject:node atIndex:endPosition];
                expand = YES;
                endPosition++;
            }else{
                expand = NO;
                endPosition = [self removeAllNodesAtParentNode:parentNode];
                break;
            }
        }
    }
    
    //获得需要修正的indexPath
    NSMutableArray *indexPathArray = [NSMutableArray array];
    for (NSUInteger i=startPosition; i<endPosition; i++) {
        NSIndexPath *tempIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [indexPathArray addObject:tempIndexPath];
    }
    
    //插入或者删除相关节点
    if (expand) {
        [self insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone];
        if (parentNode.depth == 0) {
            self.oneAction = YES;
        }else if(parentNode.depth == 1){
            self.lastAction = YES;
        }
    }else{
        [self deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone];
        if (parentNode.depth == 0) {
            self.oneAction = NO;
        }else if(parentNode.depth == 1){
            self.lastAction = NO;
        }
    }
    
}
/**
 *  删除该父节点下的所有子节点（包括孙子节点）
 *
 *  @param parentNode 父节点
 *
 *  @return 该父节点下一个相邻的统一级别的节点的位置
 */
-(NSUInteger)removeAllNodesAtParentNode : (DXDAMoreListMainModel *)parentNode{
    NSUInteger startPosition = [_tempData indexOfObject:parentNode];
    NSUInteger endPosition = startPosition;
    for (NSUInteger i=startPosition+1; i<_tempData.count; i++) {
        DXDAMoreListMainModel *node = [_tempData objectAtIndex:i];
        endPosition++;
        if (node.depth <= parentNode.depth) {
            break;
        }
        if(endPosition == _tempData.count-1){
            endPosition++;
            node.expand = NO;
            break;
        }
        node.expand = NO;
    }
    if (endPosition>startPosition) {
        [_tempData removeObjectsInRange:NSMakeRange(startPosition+1, endPosition-startPosition-1)];
    }
    return endPosition;
}
//多级列表******************************* end
@end
