//
//  UIBarButtonItem+NCExtension.m
//  eBank
//
//  Created by ZMJ on 16/4/15.
//  Copyright © 2016年 ncnx. All rights reserved.
//

#import "UIBarButtonItem+NCExtension.h"
#import "UIView+NCExtension.h"

@implementation UIBarButtonItem (NCExtension)

+ (instancetype)barButtonItemWithImage:(NSString *)imageName highImage:(NSString *)highImageName target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 20, 20);
   // button.backgroundColor = [UIColor yellowColor];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return  [[UIBarButtonItem alloc] initWithCustomView:button];
}


@end
