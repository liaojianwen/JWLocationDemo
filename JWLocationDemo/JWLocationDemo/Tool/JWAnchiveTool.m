//
//  JWAnchiveTool.m
//  JWLocationDemo
//
//  Created by ZMJ on 16/4/24.
//  Copyright © 2016年 LJW. All rights reserved.
//

#import "JWAnchiveTool.h"

@interface JWAnchiveTool()

@property (nonatomic, strong) NSMutableArray *arrCity;

@end

@implementation JWAnchiveTool

- (NSMutableArray *)arrCity
{
    if (_arrCity == nil) {
        _arrCity = [NSMutableArray array];
    }
    return _arrCity;

}



- (NSMutableArray *)unAnchive
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileNameArchive];
   return [NSKeyedUnarchiver unarchiveObjectWithFile:path];


}


- (void)saveCity:(NSString *)city
{

//    if (_arrCity.count == 0) {
//        NSMutableArray *
//        
//    }
     self.arrCity = [self unAnchive];
       
    

    
     [self.arrCity insertObject:city atIndex:0];
    
    
    NSLog(@"count==%@", _arrCity);
    
    if (_arrCity.count == 2) {
        if ([city isEqualToString:[_arrCity objectAtIndex:1]]) {
            [_arrCity removeLastObject];
        }
        
    }
    if (_arrCity.count == 3) {
        
        if ([city isEqualToString:[_arrCity objectAtIndex:2]]) {
            [_arrCity removeLastObject];
        }
        if ([city isEqualToString:[_arrCity objectAtIndex:1]]) {
            [_arrCity removeObjectAtIndex:1];
            
        }
        
    }
    if (_arrCity.count > 3) {
        
        if ([city isEqualToString:[_arrCity objectAtIndex:1]]) {
            [_arrCity removeObjectAtIndex:1];
        }
        else if ([city isEqualToString:[_arrCity objectAtIndex:2]]) {
            [_arrCity removeObjectAtIndex:2];
        }else
        {
            [_arrCity removeLastObject];
        
        }
        
        
        
    }

    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileNameArchive];
    BOOL flag = [NSKeyedArchiver archiveRootObject:_arrCity toFile:path];
    if (flag) {
        NSLog(@"归档成功");
    }else
    {
        NSLog(@"归档失败");
        
    }


}
@end
