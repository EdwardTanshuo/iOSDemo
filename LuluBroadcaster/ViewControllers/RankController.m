//
//  RankController.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 4/26/17.
//  Copyright © 2017 ShuoTan. All rights reserved.
//

#import "RankController.h"
#import "RankCell.h"

static RankController* _vc = nil;

@interface RankController ()<UITableViewDataSource, UITableViewDelegate>{
}
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@end

@implementation RankController

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupTable];
}

- (void)viewDidAppear:(BOOL)animated{
    [self.table reloadData];
    [self fillInfo];
}

#pragma mark -
#pragma mark setup

- (void)setupTable{
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.backgroundColor = [UIColor clearColor];
    self.table.tableFooterView = [UIView new];
    
    [self.table registerNib:[UINib nibWithNibName:@"RankCell" bundle:nil] forCellReuseIdentifier:@"RankCellID"];
}

#pragma mark -
#pragma mark methods

- (void)fillInfo{
    NSInteger total = 0;
    for(id iter in _list){
        total -= [iter[@"benifit"] integerValue];
    }
    self.totalLabel.text = [NSString stringWithFormat:@"这回合总共获得： %ld 魔法石", (long)total];
}

+ (void)popoutWithList:(NSArray*)list WithController:(UIViewController*)vc{
    RankController* pop = [[RankController alloc] initWithNibName:@"RankController" bundle:nil];
    pop.list = list;
    _vc = pop;
    pop.view.frame = [UIScreen mainScreen].bounds;
    [pop.view layoutIfNeeded];
    [vc.view addSubview:pop.view];
    [pop viewDidAppear:NO];
}

#pragma mark -
#pragma mark actions
- (IBAction)cancel:(id)sender {
    [_vc.view removeFromSuperview];
    _vc = nil;
}


#pragma mark - 
#pragma mark <UITableViewDataSource, UITableViewDelegate>

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RankCell* cell = [tableView dequeueReusableCellWithIdentifier:@"RankCellID"];
    [cell configWithData:_list[indexPath.row] WithIndex:indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list.count;
}

@end
