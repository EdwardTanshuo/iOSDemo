//
//  FollowController.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 4/10/17.
//  Copyright © 2017 ShuoTan. All rights reserved.
//

#import "FollowController.h"
#import "FollowerDatasource.h"
#import "FollowRequest.h"
#import "FollowerCell.h"

@interface FollowController ()<FollowerDatasourceDelegate, UITableViewDelegate, UITableViewDataSource>{
    FollowerDatasource* data;
}
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation FollowController

- (BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setDatasource];
    [self setTable];
    
    [self fetch];
}

#pragma mark -
#pragma mark setups

- (void)setDatasource{
    data = [FollowerDatasource new];
    data.delegate = self;
}

- (void)setTable{
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.backgroundColor = [UIColor clearColor];
    self.table.tableFooterView = [UIView new];
    
    [self.table registerNib:[UINib nibWithNibName:@"FollowerCell" bundle:nil] forCellReuseIdentifier:@"FollowerCellID"];
}

#pragma mark -
#pragma mark methods

- (void)fetch{
    [[FollowRequest sharedRequest] fetchFollowWithCompletion:^(NSArray<User *> * _Nullable followers, NSError * _Nullable error) {
        if(followers){
            [data update:followers];
        }
    }];
}

#pragma mark -
#pragma mark <FollowerDatasourceDelegate>
- (void)dataHasChanged:(NSArray<User *> *)followers{
    [self.table reloadData];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FollowerCell* cell = [tableView dequeueReusableCellWithIdentifier:@"FollowerCellID"];
    //cell.transaction = [self.datasource getModelAtIndexPath:indexPath];
    [cell configureWithUser:[data getModelAtIndexPath:indexPath]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [data numberOfFollowers];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65.0f;
}

@end
