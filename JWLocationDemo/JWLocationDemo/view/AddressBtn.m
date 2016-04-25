//
//  NCAddresSelectViewController.m
//  eBank
//
//  Created by ZMJ on 16/4/19.
//  Copyright © 2016年 ncnx. All rights reserved.
//

#import "AddressBtn.h"
#import "UIView+NCExtension.h"

@implementation AddressBtn

- (instancetype)initWithFrame:(CGRect)frame{
    
    
    if (self = [super initWithFrame:frame]) {
        
        self.titleLabel.contentMode = UIViewContentModeLeft;
  
        self.titleLabel.font = [UIFont systemFontOfSize:15];
         //self.titleLabel.backgroundColor = [UIColor yellowColor];
         // self.imageView.backgroundColor = [UIColor blueColor];
        // self.backgroundColor = [UIColor greenColor];
        //self.imageView.contentMode = UIViewContentModeLeft;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
       // self.titleLabel.adjustsFontSizeToFitWidth = YES;
        

        [self.titleLabel sizeToFit];
    }
    
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
/*ergqewrgverger*/
//- (CGRect)titleRectForContentRect:(CGRect)contentRect
//{
//    return CGRectMake(0, 0, self.width*0.75, self.height);
//    
//}
//- (CGRect)imageRectForContentRect:(CGRect)contentRect
//{
//
//    return CGRectMake(self.width*0.75+2, 12,12, 6);
//    
//}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.x = -10;
    self.imageView.y = 0;
    self.imageView.width = 30;
    self.imageView.height = 30;
    self.titleLabel.x = self.imageView.width - 10;
    self.titleLabel.width = self.width - self.imageView.width;
    self.titleLabel.height = self.imageView.height;
    self.titleLabel.centerY = self.height * 0.5;
    self.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);



}
#pragma mark - 重写父类的这个方法
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    CGRect rect = [self dynamicHeight:title fontSize:15];
    
    CGFloat with = rect.size.width;
    if (with > 100) {
        with = 80;
    }
    self.frame = CGRectMake(0, 0, with+30, 30);
    
    
}

//- (void)setImage:(UIImage *)image forState:(UIControlState)state
//{
//
//    [super setImage:image forState:state];
//    [self setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
//
//}

//计算字符串的大小
- (CGRect)dynamicHeight:(NSString *)str fontSize:(NSInteger)fontSize
{
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGRect rect = [str boundingRectWithSize:CGSizeMake(1000, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect;
}
@end
