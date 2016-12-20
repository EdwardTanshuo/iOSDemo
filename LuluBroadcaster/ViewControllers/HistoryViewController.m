//
//  HistoryViewController.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/19/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryDatasource.h"
#import "HistoryCell.h"
#import <SVPullToRefresh/SVPullToRefresh.h>

#define CELL_HEIGHT 72.0

@interface HistoryViewController ()<HistoryDatasourceDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) HistoryDatasource* datasource;
@end

@implementation HistoryViewController

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"直播历史";
    
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
    self.datasource = [[HistoryDatasource alloc] init];
    self.datasource.delegate = self;
}

- (void)setupTable{
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.backgroundColor = [UIColor clearColor];
    self.table.tableFooterView = [UIView new];
    
    [self.table registerNib:[UINib nibWithNibName:@"HistoryCell" bundle:nil] forCellReuseIdentifier:@"HistoryCellID"];
}

- (void)fetchData{
    [self.datasource reset];
}

- (void) setupLoadersCallback{
    __weak HistoryViewController* wself = self;
    [self.table addPullToRefreshWithActionHandler:^{
        [wself fetchData];
    }];
}


#pragma mark - 
#pragma mark HistoryDatasourceDelegate

- (void)dataHasChanged:(NSArray<Broad *> *)histories{
    [self.table reloadData];
    [self.table.pullToRefreshView stopAnimating];
}

- (void)dataHasFailed:(NSError *)error{
    [self.table.pullToRefreshView stopAnimating];
}
#pragma mark -
#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryCell* cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryCellID"];
    cell.history = [self.datasource getModelAtIndexPath:indexPath];
    [cell configureWithBroad:cell.history];
    
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
