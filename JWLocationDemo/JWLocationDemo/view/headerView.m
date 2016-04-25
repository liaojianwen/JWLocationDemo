//
//  headerView.m
//  JWLocationDemo
//
//  Created by ZMJ on 16/4/23.
//  Copyright © 2016年 LJW. All rights reserved.
//

#import "headerView.h"

#import "LocationTool.h"

@interface headerView()

@property (nonatomic, strong) LocationTool *location;

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@end

@implementation headerView

+ (instancetype)head
{

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];

}

- (void)awakeFromNib
{

    self.autoresizingMask = UIViewAutoresizingNone;
    
    [self locationcity];


}

- (void)locationcity
{

    self.location = [[LocationTool alloc] init];
    [self.location startLocationWithBlock:^(NSString *city) {
        
       // NSLog(@"city===%@", city);
        self.cityLabel.text = city;
        
        
    }];

}

@end
