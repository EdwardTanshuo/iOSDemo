//
//  HomepageController.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 10/31/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "HomepageController.h"
#import "CameraManager.h"
#import "NavigationRouter.h"
#import "CustomerTabBarController.h"
#import "StreamCell.h"
#import "BroadcasterDatasource.h"

@interface HomepageController ()<CameraManagerDelegate, CustomerTabBarControllerDelegate, UITableViewDelegate, UITableViewDataSource, BroadcasterDatasourceDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (assign, nonatomic) CameraStatus status;
@property (strong, nonatomic) BroadcasterDatasource* datasource;
@end

@implementation HomepageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [CameraManager sharedManager].delegate = self;
    [self setupViews];
    [self setupTable];
    [self setupDatasource];
    
    ((CustomerTabBarController*)(self.navigationController.tabBarController)).camearaDelegate = self;
    
    self.navigationItem.title = @"相机(断开)";
}

- (void) dealloc{
    [CameraManager sharedManager].delegate = nil;
    [[CameraManager sharedManager] closeCamera];
}

#pragma mark -
#pragma mark methods
- (void)setupViews{
    [self setupStatus];
    
}

- (void)setupTable{
    self.table.delegate = self;
    self.table.dataSource = self;
    
    [self.table registerNib:[UINib nibWithNibName:@"StreamCell" bundle:nil] forCellReuseIdentifier:@"StreamCellID"];
}


- (void)setupStatus{
    [self updateStatus: [CameraManager sharedManager]];
    [self openCamera];
}

- (void)updateStatus:(CameraManager*) manager{
    switch (manager.status) {
        case CameraStatusConnected:
            self.navigationItem.title = @"相机(断开)";
            self.status = CameraStatusConnected;
            [((CustomerTabBarController*)(self.navigationController.tabBarController)) active];
            break;
        case CameraStatusConnecting:
            self.navigationItem.title = @"相机(连接中)";
            self.status = CameraStatusConnecting;
            [((CustomerTabBarController*)(self.navigationController.tabBarController)) inactive];
            break;
        case CameraStatusDisconnected:
            self.navigationItem.title = @"相机(断开)";
            self.status = CameraStatusDisconnected;
            [((CustomerTabBarController*)(self.navigationController.tabBarController)) inactive];
            break;
        default:
            break;
    }
}

- (void)setupDatasource{
    _datasource = [[BroadcasterDatasource alloc] init];
    _datasource.delegate = self;
}

- (void)startLive{
    [NavigationRouter popLiveControllerFrom:self];
}

- (void)openCamera{
    [[CameraManager sharedManager] openCamera];
}

#pragma mark -
#pragma mark actions


#pragma mark -
#pragma mark CameraManagerDelegate

- (void)cameraDidConnect:(CameraManager *)manager{
    [self updateStatus: manager];
}

- (void)cameraConnectFail:(CameraManager *)manager{
    [self updateStatus: manager];
}

- (void)cameraIsConnecting:(CameraManager *)manager{
    [self updateStatus: manager];
}

- (void)cameraDidDisconnect:(CameraManager *)manager{
    [self updateStatus: manager];
}

#pragma mark -
#pragma mark CustomerTabBarControllerDelegate
- (void)didPressCameraButton{
    if(self.status == CameraStatusConnected){
        [self startLive];
    }
    else{
        [NavigationRouter showAlertInViewController:self WithTitle:@"相机未连接" WithMessage:@"请检查您的nano是否已经连接"];
    }
}

#pragma mark -
#pragma mark UITableViewDatasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StreamCell* cell = [tableView dequeueReusableCellWithIdentifier:@"StreamCellID"];
    cell.broadcaster = [self.datasource getModelAtIndexPath:indexPath];
    [cell configWithBroadcaster:cell.broadcaster];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.datasource numOfRows];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark -
#pragma mark BroadcasterDatasourceDelegate
- (void)dataHasChanged:(NSArray<Broadcaster *> *)broadcasters{
    [self.table reloadData];
}
@end
