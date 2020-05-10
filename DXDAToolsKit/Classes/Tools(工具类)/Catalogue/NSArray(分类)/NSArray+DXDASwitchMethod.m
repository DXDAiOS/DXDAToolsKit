//
//  NSArray+DXDASwitchMethod.m
//  NewApp3.0
//
//  Created by DXDA on 2017/5/9.
//  Copyright © 2017年 DXDA. All rights reserved.
//

#import "NSArray+DXDASwitchMethod.h"

@implementation NSArray (DXDASwitchMethod)

// ccz 方法交换
+(void)load{
    
//    [super load];
//    
//    Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:));
//    
//    Method toMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(lxzObjectAtIndex:));
//    
//    method_exchangeImplementations(fromMethod, toMethod);
    
}

- (id)lxzObjectAtIndex:(NSInteger)index{
    
    if (self.count-1<index || self.count == 0) {
        
        @try {
            
            [self lxzObjectAtIndex:index];
            
        }
        
        @catch (NSException *exception) {
            
            NSLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
            
            NSLog(@"ERROR:%@",[exception callStackSymbols]);
            
        }
        
        @finally {}
        
        return nil;
        
    }else{
        
        return [self lxzObjectAtIndex:index];
        
    }
    
}
@end
