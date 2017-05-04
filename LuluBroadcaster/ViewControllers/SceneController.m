//
//  SceneController.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 4/26/17.
//  Copyright © 2017 ShuoTan. All rights reserved.
//

#import "SceneController.h"
#import "SceneDatasource.h"
#import "SceneRequest.h"
#import "SceneCell.h"

@interface SceneController ()<SceneDatasourceDelegate, UITableViewDelegate, UITableViewDataSource>{
    SceneDatasource* data;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SceneController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self setDatasource];
    [self setTable];
}

- (void)viewDidAppear:(BOOL)animated{
    [self fetch];
}

#pragma mark -
#pragma mark setups

- (void)setDatasource{
    data = [SceneDatasource new];
    data.delegate = self;
}

- (void)setTable{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SceneCell" bundle:nil] forCellReuseIdentifier:@"SceneCellID"];
}

- (void)fetch{
    [[SceneRequest sharedRequest] fetchScenesWithCompletion:^(NSArray<Record *> * _Nullable list, NSError * _Nullable error) {
        if(list){
            [data update:list];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [data numberOfRecords];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SceneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SceneCellID" forIndexPath:indexPath];
    
    // Configure the cell...
    [cell configureWithRecord:[data getModelAtIndexPath:indexPath]];
    
    return cell;
}

#pragma mark -
#pragma mark <FollowerDatasourceDelegate>
- (void)dataHasChanged:(NSArray<Record *> *)records{
    [self.tableView reloadData];
}
@end
