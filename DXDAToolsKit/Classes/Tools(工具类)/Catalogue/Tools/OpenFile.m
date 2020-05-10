//
//  OpenFile.m
//  Ace
//
//  Created by Quua on 2017/3/1.
//  Copyright © 2017年 Q、徐. All rights reserved.
//

#import "OpenFile.h"
#import <QuickLook/QuickLook.h>

@interface OpenFile()<QLPreviewControllerDelegate,QLPreviewControllerDataSource>
{
    NSArray * urls;
}
@end

@implementation OpenFile
/// md、该死的不写成单例 还会被干掉...
+(instancetype)open{
    static OpenFile *open = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        open = [[self alloc] init];
    });
    return open;
}


+(void)open:(NSArray *)urls dex:(int)dex Vc:(UIViewController *)vc{
    OpenFile * open = [OpenFile open];
    open->urls = urls;
    QLPreviewController * pl = [[QLPreviewController alloc] init];
    pl.delegate = open;
    pl.dataSource = open;
    [vc presentViewController:pl animated:true completion:nil];
    pl.currentPreviewItemIndex = dex;
    NSLog(@"需要打开的文件  %@   第%d个",urls,dex);
}

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)previewController
{
    return urls.count;
}

// returns the item that the preview controller should preview
- (id)previewController:(QLPreviewController *)previewController previewItemAtIndex:(NSInteger)idx
{
    return urls[idx];
}


@end
