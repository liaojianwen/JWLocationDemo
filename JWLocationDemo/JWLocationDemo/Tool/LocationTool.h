//
//  LocationTool.h
//  JWLocationDemo
//
//  Created by ZMJ on 16/4/23.
//  Copyright © 2016年 LJW. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LocationBlock)(NSString *city);

@interface LocationTool : NSObject

@property (nonatomic, strong) LocationBlock locationBlock;

- (void)startLocationWithBlock:(LocationBlock)returnBlock;

@end
