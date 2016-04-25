//
//  JWLocationController.h
//  JWLocationDemo
//
//  Created by ZMJ on 16/4/23.
//  Copyright © 2016年 LJW. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JWLocationControllerDelegate <NSObject>

- (void)JWLocationSelectionTitle:(NSString *)city;

@end

@interface JWLocationController : UIViewController

@property (nonatomic, weak) id<JWLocationControllerDelegate> delegate;


@end
