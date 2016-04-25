//
//  JWLocationController.m
//  JWLocationDemo
//
//  Created by ZMJ on 16/4/23.
//  Copyright © 2016年 LJW. All rights reserved.
//

#import "JWLocationController.h"

#import "headerView.h"

#import "ChineseString.h"

#import "JWHistoryCell.h"

#import "UIBarButtonItem+NCExtension.h"





@interface JWLocationController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, strong) NSMutableArray *titleArr;

@property (nonatomic, strong) NSMutableArray *nohistitleArr;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) NSMutableArray *historyArr;

@property (nonatomic, strong) NSMutableArray *searchArr;

@property (nonatomic, strong) UITableView *searchTableView;

/**
 * 本地城市
 */
@property (nonatomic, strong) NSArray *localCitys;

//@property (nonatomic, strong) JWAnchiveTool *anchive;



@end


@implementation JWLocationController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.view.backgroundColor = [UIColor blueColor];
    UIButton *removeBtn = [[UIButton alloc] init];
    [removeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    removeBtn.frame = CGRectMake(0, 0, 50, 44);
    [removeBtn addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    //[self.navigationController.navigationBar setTintColor:[UIColor redColor]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:removeBtn];
     [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
   
  //  NSLog(@"headview==%@", self.tableView.tableHeaderView);
   // self.tableView
    [self setupTitleinfo];
    [self createData];
    
    [self setupTableView];
    
   
    
    
}

- (void)setupTitleinfo
{
    self.title = @"定位";
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIBarButtonItem *backItem = [UIBarButtonItem barButtonItemWithImage:@"close" highImage:nil target:self action:@selector(remove)];
    
    self.navigationItem.leftBarButtonItem = backItem;



}

- (void)setupTableView
{
   self.tableView.tableHeaderView = [headerView head];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"defaultcell"];
    [self.tableView registerClass:[JWHistoryCell class] forCellReuseIdentifier:@"historycell"];
    
    //self.searchTableView = [[UITableView alloc] ];
    self.searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 108, kscreenW, 0) style:UITableViewStylePlain];
    self.searchTableView.dataSource = self;
    self.searchTableView.delegate = self;
    [self.searchTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"searchBarcell"];
    [self.view addSubview:self.searchTableView];
    
    


}

- (void)setupsearchBarTableView:(BOOL)Hidden
{
    NSInteger height = Hidden ? kscreenH - 108 : 0;
    
    [self.searchTableView setFrame:CGRectMake(0, 108, kscreenW, height)];


}
- (void)createData
{

    NSMutableArray *array = [NSMutableArray array];
    
    NSDictionary *addDict = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"address" ofType:@"plist"]];
    NSArray *arr = [addDict objectForKey:@"address"];
    for (NSDictionary *dict in arr) {
        
        NSArray *Newarr = [dict objectForKey:@"sub"];
        for (NSDictionary *Newdict in Newarr) {
            [array addObject:[Newdict objectForKey:@"name"]];
        }
    }
    
    self.titleArr = [ChineseString IndexArray:array];
    self.dataArr = [ChineseString LetterSortArray:array];
    [self.titleArr insertObject:@"历史访问城市" atIndex:0];
    [self.titleArr insertObject:@"本省城市" atIndex:1];
    
    self.nohistitleArr = [ChineseString IndexArray:array];
    [self.nohistitleArr insertObject:@"本省城市" atIndex:0];
    
    self.localCitys = @[@"南昌",@"景德镇",@"九江",@"鹰潭",@"吉安",@"抚州",@"萍乡",@"新余",@"赣州",@"宜春",@"上饶"];
    
    JWAnchiveTool *anchive = [[JWAnchiveTool alloc] init];
    self.historyArr = [anchive unAnchive];
   


}
- (void)remove
{

    [self dismissViewControllerAnimated:YES completion:nil];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.searchTableView]) {
        
        return self.searchArr.count;
        
    }else
    {
        if (self.historyArr.count == 0) {
            if (section == 0) {
                return 1;
            }else
            {
                NSArray *arr = [self.dataArr objectAtIndex:section - 1];
                return arr.count;
            
            }
            
        }else
        {
        
            if (section == 0) {
                return 1;
            } else if (section == 1)
            {
                return 1;
            } else
            {
                //NSLog(@"self.data.count==%zd",self.dataArr.count);
                NSArray *arr = [self.dataArr objectAtIndex:section - 2];
                return arr.count;
                
            }
        
        }
        
    
    }
    
    

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([tableView isEqual:self.searchTableView]) {
        return 1;
    }else
    {
        if (self.historyArr == 0) {
            
            return self.nohistitleArr.count;
            
        }else
        {
         return self.titleArr.count;
        
        }
        
    
    }
    


}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

   
    
    if ([tableView isEqual:self.searchTableView])
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchBarcell"];
        cell.textLabel.text = self.searchArr[indexPath.row];
        return cell;
        
    }else
    {
        if (self.historyArr == 0) {
            
            if (indexPath.section == 0) {
                
                JWHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"historycell"];
                [cell addContent:self.localCitys];
                //cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
                
            }else
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"defaultcell"];
                //cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.text = self.dataArr[indexPath.section - 1][indexPath.row];
                return cell;
            
            }
            
            
        }else
        {
            if (indexPath.section == 0) {
                JWHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"historycell"];
                if (self.historyArr.count > 0) {
                    [cell addContent:self.historyArr];
                }
                return cell;
            } else if (indexPath.section == 1){
                
                JWHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"historycell"];
                [cell addContent:self.localCitys];
                //cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
                // cell.textLabel.text = @"cell";
            }else
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"defaultcell"];
                //cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.text = self.dataArr[indexPath.section - 2][indexPath.row];
                return cell;
                
            }
        
        }
        
         
    }
  
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.searchTableView]) {
        return 44;
    } else
    {
        if (self.historyArr.count == 0) {
            if (indexPath.section == 0) {
                return 230;
            }else
            {
                return 44;
            
            }
            
        }else
        {
            if (indexPath.section == 0) {
                return 64;
            }
            else if (indexPath.section == 1) {
                return 230;
            }else
            {
                return 44;
                
            }
        
        }
        
    
    }
    

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:self.searchTableView]) {
        return nil;
    }
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = JWCColor(239, 239, 239);
    //titleView.frame = CGRectMake(0, 0, kscreenW, 100);
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(20, 0, kscreenW - 20, 35);
    titleLabel.textColor = [UIColor darkGrayColor];
    [titleView addSubview:titleLabel];
    if (self.historyArr.count == 0) {
       // NSMutableArray *newtitleArr = [self.nohistitleArr mutableCopy];
        
        titleLabel.text = self.nohistitleArr[section];
        
    }else
    {
        titleLabel.text = self.titleArr[section];
    }
    
   
    
    
    return titleView;
    

}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if ([tableView isEqual:self.searchTableView]) {
        return nil;
    }
    if (self.historyArr.count == 0) {
        NSMutableArray *titleArr = [self.nohistitleArr mutableCopy];
        [titleArr replaceObjectAtIndex:0 withObject:@"本省"];
        return titleArr;
        
    }else
    {
        NSMutableArray *titleArr = [self.titleArr mutableCopy];
        [titleArr replaceObjectAtIndex:0 withObject:@"历史"];
        [titleArr replaceObjectAtIndex:1 withObject:@"本省"];
        return titleArr;
    
    }
    
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:self.searchTableView]) {
        return 0;
    }
    return 35;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.searchTableView]) {
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if ([self.delegate respondsToSelector:@selector(JWLocationSelectionTitle:)]) {
            [self.delegate JWLocationSelectionTitle:cell.textLabel.text];
        }
        
        JWAnchiveTool *anchive = [[JWAnchiveTool alloc] init];
        [anchive saveCity:cell.textLabel.text];
        
        
    }else
    {
        if (self.historyArr.count == 0) {
            if (indexPath.section == 0) return;
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            if ([self.delegate respondsToSelector:@selector(JWLocationSelectionTitle:)]) {
                [self.delegate JWLocationSelectionTitle:cell.textLabel.text];
            }
           // NSLog(@"cell.textlabel.text==%@", cell.textLabel.text);
            JWAnchiveTool *anchive = [[JWAnchiveTool alloc] init];
            [anchive saveCity:cell.textLabel.text];
            
            
        }else
        {
            if (indexPath.section == 0 || indexPath.section == 1) return;
            // UITableViewCell *cell = [self.tableVi]
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            if ([self.delegate respondsToSelector:@selector(JWLocationSelectionTitle:)]) {
                [self.delegate JWLocationSelectionTitle:cell.textLabel.text];
            }
            JWAnchiveTool *anchive = [[JWAnchiveTool alloc] init];
            [anchive saveCity:cell.textLabel.text];
        
        }
    
        
        
        
    
    
    }
    
    
  
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];



}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"searchBar textDidChange:");
    if (searchText.length > 0) {
        [self setupsearchBarTableView:YES];
    }else
    {
    [self setupsearchBarTableView:NO];
    
    }
    

   [self searchkeyBoardWithStr:searchText];
    


}

- (void)searchkeyBoardWithStr:(NSString *)Str
{
    self.searchArr = [NSMutableArray array];
    
   [self.dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       NSArray *nameArry = (NSArray *)obj;
       [nameArry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           NSString *name = (NSString *)obj;
           if ([name containsString:Str]) {
               
               [self.searchArr addObject:name];
               
           }
           
       }];
       
       
   }];
    
    [self.searchTableView reloadData];


}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{

    [self.view endEditing:YES];

}

@end
