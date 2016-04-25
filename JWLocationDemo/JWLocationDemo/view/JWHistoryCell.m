//
//  JWHistoryCell.m
//  JWLocationDemo
//
//  Created by ZMJ on 16/4/24.
//  Copyright © 2016年 LJW. All rights reserved.
//

#import "JWHistoryCell.h"

@implementation JWHistoryCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }

    return self;

}

- (void)addContent:(NSArray *)contentArray
{

    //int count = contentArray.count;
    
    int colnum = 3;
    CGFloat margin = 10;
    CGFloat labelW = (kscreenW - 4 * margin)/colnum;
    CGFloat labelH = 44;
    
    for (int i = 0; i < contentArray.count; i++) {
        
        UILabel *contentlabel = [[UILabel alloc] init];
        contentlabel.textColor = [UIColor darkGrayColor];
        contentlabel.font = [UIFont systemFontOfSize:14];
        contentlabel.textAlignment = NSTextAlignmentCenter;
        int col = i % colnum;
        int row = i / colnum;
        CGFloat contentlabelX = margin + (labelW + margin) * col;
        CGFloat contentlabelY = margin + (labelH + margin) * row;
        contentlabel.frame = CGRectMake(contentlabelX, contentlabelY, labelW, labelH);
        contentlabel.text = contentArray[i];
        contentlabel.backgroundColor = JWCColor(245, 245, 245);
        contentlabel.userInteractionEnabled = YES;
       
      // UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc] init];
        [contentlabel addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];

        
        [self.contentView addSubview:contentlabel];
    }



}

- (void)labelClick:(UITapGestureRecognizer *)tap
{
    
    if ([tap.view isKindOfClass:[UILabel class]]) {
        
        UILabel *label = (UILabel *)tap.view;
        
         NSLog(@"labelclick==%@", label.text);
        JWAnchiveTool *anchive = [[JWAnchiveTool alloc] init];
        [anchive saveCity:label.text];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"sendCity" object:nil userInfo:@{@"city":label.text}];
        UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        [nav dismissViewControllerAnimated:YES completion:nil];
        
        
    }

   

}

@end
