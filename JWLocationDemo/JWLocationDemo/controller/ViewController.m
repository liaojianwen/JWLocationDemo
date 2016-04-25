//
//  ViewController.m
//  JWLocationDemo
//
//  Created by ZMJ on 16/4/23.
//  Copyright © 2016年 LJW. All rights reserved.
//

#import "ViewController.h"

#import "JWLocationController.h"

#import "AddressBtn.h"




@interface ViewController ()<JWLocationControllerDelegate>

@property (nonatomic, strong) AddressBtn *addressBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
  
    [self setTitleinfo];
    
    [self setupleftButton];
   
    
}

- (void)setTitleinfo
{

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"城市选择";
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rebackCity:) name:@"sendCity" object:nil];

}

- (void)setupleftButton
{
    
    self.addressBtn = [AddressBtn buttonWithType:UIButtonTypeCustom];
    //CGRectMake(10, 0, 55, 30)
    
    [self.addressBtn setTitle:@"  " forState:UIControlStateNormal];
    [self.addressBtn setImage:[UIImage imageNamed:@"LeftNavItemImage"] forState:UIControlStateNormal];
    [self.addressBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.addressBtn];



}

- (void)rebackCity:(NSNotification *)info
{
    NSString *city = info.userInfo[@"city"];

   [self.addressBtn setTitle:city forState:UIControlStateNormal];

}

- (void)btnClick
{
    JWLocationController *location = [[JWLocationController alloc] init];
    location.delegate = self;
    
    UINavigationController *locnav = [[UINavigationController alloc] initWithRootViewController:location];
    
    [self.navigationController presentViewController:locnav animated:YES completion:nil];

   // NSLog(@"btnClick");


}

- (void)JWLocationSelectionTitle:(NSString *)city
{

    [self.addressBtn setTitle:city forState:UIControlStateNormal];

}

@end
