//
//  TransactionViewController.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/20/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "TransactionViewController.h"
#import "TransactionDatasource.h"
#import "TransactionCell.h"
#import <SVPullToRefresh/SVPullToRefresh.h>

#define CELL_HEIGHT 60.0

@interface TransactionViewController ()<TransactionDatasourceDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) TransactionDatasource* datasource;
@end

@implementation TransactionViewController

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的收益";
    [self setupViews];
    [self setupDatasources];
    [self setupTable];
    [self setupLoadersCallback];
}

- (void)viewWillAppear:(BOOL)animated{
    [self  fetchData];
}

- (void)setupViews{
    
}

- (void)setupDatasources{
    self.datasource = [[TransactionDatasource alloc] init];
    self.datasource.delegate = self;
}

- (void)setupTable{
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.backgroundColor = [UIColor clearColor];
    self.table.tableFooterView = [UIView new];
    
    [self.table registerNib:[UINib nibWithNibName:@"TransactionCell" bundle:nil] forCellReuseIdentifier:@"TransactionCellID"];
}

- (void)fetchData{
    [self.datasource reset];
}

- (void) setupLoadersCallback{
    __weak TransactionViewController* wself = self;
    [self.table addPullToRefreshWithActionHandler:^{
        [wself fetchData];
    }];
}

#pragma mark -
#pragma mark HistoryDatasourceDelegate

- (void)dataHasChanged:(NSArray<Transaction *> *)transactions{
    [self.table reloadData];
    [self.table.pullToRefreshView stopAnimating];
}

- (void)dataHasFailed:(NSError *)error{
    [self.table.pullToRefreshView stopAnimating];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TransactionCell* cell = [tableView dequeueReusableCellWithIdentifier:@"TransactionCellID"];
    cell.transaction = [self.datasource getModelAtIndexPath:indexPath];
    [cell configureWithTransaction:cell.transaction];
    
    //loadmore
    if ((self.datasource.total > indexPath.row + 1) && (indexPath.row == [self.datasource numOfRows] - 1))
    {
        [self.datasource fetchNew];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.datasource numOfRows];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_HEIGHT;
}

@end
