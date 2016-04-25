//
//  UIBarButtonItem+NCExtension.h
//  eBank
//
//  Created by ZMJ on 16/4/15.
//  Copyright © 2016年 ncnx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (NCExtension)

+ (instancetype)barButtonItemWithImage:(NSString *)imageName highImage:(NSString *)highImageName target:(id)target action:(SEL)action;


@end
