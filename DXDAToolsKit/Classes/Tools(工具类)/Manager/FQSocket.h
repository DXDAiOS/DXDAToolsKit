//
//  FQSocket.h
//  推送socket
//
//  Created by Erowin on 16/11/29.
//  Copyright © 2016年 DXDA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"

@protocol FQSocketDelegate <NSObject>

-(void)socketRead:(GCDAsyncSocket *)sock readData:(NSData *)data withTag:(NSInteger)tag;

@end

@interface FQSocket : NSObject<GCDAsyncSocketDelegate>

+(instancetype)shareSocket;

-(BOOL)connectSocket;

@property(nonatomic,weak)id<FQSocketDelegate> delegate;

@property(nonatomic)GCDAsyncSocket *socket;

@end
