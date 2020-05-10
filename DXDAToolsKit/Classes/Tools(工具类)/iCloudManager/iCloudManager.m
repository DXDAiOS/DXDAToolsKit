//
//  iCloudManager.m
//  NewApp3.0
//
//  Created by DXDA on 2019/8/9.
//  Copyright © 2019 DXDA. All rights reserved.
//

#import "iCloudManager.h"
#import <QuickLook/QuickLook.h>

@interface ZZDocument : UIDocument
@property (nonatomic, strong) NSData *data;
@end
@implementation ZZDocument

- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError {
    self.data = contents;
    return YES;
}


@end



@implementation iCloudManager
+ (BOOL)iCloudEnable {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSURL *url = [manager URLForUbiquityContainerIdentifier:nil];
    
    if (url != nil)
    {
        return YES;
    }
    NSLog(@"iCloud 不可用");
    return NO;
}
+ (void)downloadWithDocumentURL:(NSURL*)url callBack:(downloadBlock)block {
    
    ZZDocument *iCloudDoc = [[ZZDocument alloc]initWithFileURL:url];
    [iCloudDoc openWithCompletionHandler:^(BOOL success) {
        if (success) {
            [iCloudDoc closeWithCompletionHandler:^(BOOL success) {
                NSLog(@"关闭成功");
            }];
            if (block) {
                block(iCloudDoc.data);
            }
        }
    }];
}



@end
