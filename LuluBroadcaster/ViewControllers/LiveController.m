//
//  LiveController.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 10/31/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "LiveController.h"
#import "LiveManager.h"
#import "StreamManager.h"
#import "CameraManager.h"
#import <GPUImage/GPUImageFramework.h>
#import <NSLogger/LoggerClient.h>
#import "DanmuManager.h"
#import "DanmuCell.h"
#import "GameManager.h"
#import "LiveAlertView.h"
#import "ViewerCell.h"

@interface LiveController ()<UICollectionViewDataSource, LiveDataSourceDelegate, DanmuDatasourceDelegate, GameManagerDelegate, GameManagerEvent, GameManagerDatasource, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) GPUImageView* imageView;

@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet UITableView *danmu_table;
@property (weak, nonatomic) IBOutlet UIButton *close;

@end

@implementation LiveController

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupViews];
    [self setupDanmuTable];
    [self setupDanmuDatasource];
    [self setupGame];
    [self launchLive];
}

- (void)dealloc{
   
}

- (void)launchLive{
    [LiveManager sharedManager].delegate = self;
    [[LiveManager sharedManager] startLiveWithView:_imageView];
}

- (void)setupViews{
    _imageView = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_imageView setBackgroundColorRed:0 green:0 blue:0 alpha:1.0];
    [self.view insertSubview:_imageView atIndex:0];
    
}

- (void)setupDanmuDatasource{
     [DanmuManager sharedManager].delegate = self;
}

- (void)setupGame{
    [GameManager sharedManager].delegate = self;
    [GameManager sharedManager].target = self;
    [GameManager sharedManager].datasource = self;
}

- (void)setupDanmuTable{
    _danmu_table.delegate = self;
    _danmu_table.dataSource = self;
    _danmu_table.backgroundColor = [UIColor clearColor];

    [self.danmu_table registerNib:[UINib nibWithNibName:@"DanmuCell" bundle:nil] forCellReuseIdentifier:@"DanmuCellID"];
}

- (void)setupCollection{
    self.collection.dataSource = self;
    
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(44.0f, 44.0);
    layout.minimumLineSpacing = 8.0;
    layout.minimumInteritemSpacing = 0.0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collection.collectionViewLayout = layout;
    self.collection.showsVerticalScrollIndicator = NO;
    self.collection.showsHorizontalScrollIndicator = NO;
    self.collection.backgroundColor = [UIColor clearColor];
    
    [self.collection registerNib:[UINib nibWithNibName:@"ViewerCell" bundle:nil] forCellWithReuseIdentifier:@"ViewerCell"];
}

#pragma mark -
#pragma mark actions
- (IBAction)closeActions:(id)sender {
    [[LiveManager sharedManager] stopLive];
    [[GameManager sharedManager] endGame: _scene.room];
    [LiveManager sharedManager].delegate = nil;
    [DanmuManager sharedManager].delegate = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)startBet:(id)sender {
     [[GameManager sharedManager] startBet: _scene.room];
}

- (IBAction)startGame:(id)sender {
    [[GameManager sharedManager] startGame: _scene.room];
}

- (IBAction)endDealer:(id)sender {
    [[GameManager sharedManager] endDealer: _scene.room];
}


#pragma mark -
#pragma mark LiveDataSourceDelegate

- (void)recieveStichedFragment:(CVPixelBufferRef)pixelBuffer timestamp:(int64_t)timestamp{
    
}

- (void)recieveOnRawFragment:(CVPixelBufferRef)pixelBuffer timestamp:(int64_t)timestamp{
    
  
}

- (void)recieveError:(NSError *)error{
     self.view.backgroundColor = [UIColor blackColor];
}


- (void)bufferFetched:(CVPixelBufferRef)buffer{
    
}

#pragma mark -
#pragma mark DanmuDatasourceDelegate
- (void)dataHasChanged:(NSArray<Danmu *> *)danmus{
    [self.danmu_table reloadData];
    [self updateTableContentInset];
    [self tableViewScrollToBottom: true];
}


#pragma mark -
#pragma mark UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DanmuCell* cell = (DanmuCell*)[tableView dequeueReusableCellWithIdentifier:@"DanmuCellID"];
    [cell configureWithDanmu:[[DanmuManager sharedManager].datasource getModelAtIndexPath:indexPath]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[DanmuManager sharedManager].datasource numOfRows];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [DanmuCell height:[[DanmuManager sharedManager].datasource getModelAtIndexPath:indexPath]];
}

#pragma mark -
#pragma mark danmu list
- (void)updateTableContentInset{
    NSInteger numRows = [[DanmuManager sharedManager].datasource numOfRows];
    CGFloat contentInsetTop = self.danmu_table.bounds.size.height;
    NSInteger i = 0;
    for(i = 0; i < numRows; i ++){
        contentInsetTop = contentInsetTop - [self tableView:self.danmu_table heightForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if(contentInsetTop <= 0){
            contentInsetTop = 0;
            break;
        }
    }
    self.danmu_table.contentInset =  UIEdgeInsetsMake(contentInsetTop, 0, 0, 0);
}

- (void)tableViewScrollToBottom: (BOOL)animation{
    __weak LiveController* wself = self;
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        NSInteger numberOfSections = 1;
        NSInteger numberOfRows = [wself.danmu_table numberOfRowsInSection:numberOfSections - 1];
        if(numberOfRows > 0){
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:numberOfRows - 1 inSection:numberOfSections - 1];
            [wself.danmu_table scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:true];
        }
    });
}

#pragma mark -
#pragma mark GameManagerDelegate


- (void)entryCallBack:(id _Nullable) argsData{
    if([[argsData objectForKey:@"code"] integerValue] == 200){
        [[GameManager sharedManager] createGame:@"57c54f1b5894e71f0aab3a78"];
    }
    
}

- (void)createCallBack:(id _Nullable) argsData{
    if([[argsData objectForKey:@"code"] integerValue] == 200){
        NSLog(@"OK");
    }
}

- (void)startCallBack:(id _Nullable) argsData{
    if([[argsData objectForKey:@"code"] integerValue] == 200){
        NSLog(@"OK");
    }
    else{
        NSError* error = [[GameManager sharedManager] makeError:argsData];
        [LiveAlertView popOutInController:self error:error];
    }
}

- (void)betCallBack:(id)argsData{
    if([[argsData objectForKey:@"code"] integerValue] == 200){
        NSLog(@"OK");
    }
    else{
        NSError* error = [[GameManager sharedManager] makeError:argsData];
        [LiveAlertView popOutInController:self error:error];
    }
}

- (void)endDealerCallBack:(id)argsData{
    if([[argsData objectForKey:@"code"] integerValue] == 200){
        NSLog(@"OK");
    }
    else{
        NSError* error = [[GameManager sharedManager] makeError:argsData];
        [LiveAlertView popOutInController:self error:error];
    }
}

- (void)endCallBack:(id _Nullable) argsData{
    
}

- (void)drawCallBack:(id _Nullable) argsData{
    if([[argsData objectForKey:@"code"] integerValue] == 200){
        NSLog(@"OK");
    }
    else{
        NSError* error = [[GameManager sharedManager] makeError:argsData];
        [LiveAlertView popOutInController:self error:error];
    }
}

- (void)finishTurnCallBack:(id _Nullable) argsData{
    if([[argsData objectForKey:@"code"] integerValue] == 200){
        NSLog(@"OK");
    }
    else{
        NSError* error = [[GameManager sharedManager] makeError:argsData];
        [LiveAlertView popOutInController:self error:error];
    }
}

#pragma mark -
#pragma mark GameManagerEvent
- (void)didConnected{
    [[GameManager sharedManager] entry:@"57c54f1b5894e71f0aab3a78"];
}

- (void)PlayerEnterEvent:(User *)user{

}

- (void)PlayerLeaveEvent:(User *)user{

}

- (void)NewTurnEvent: (NSDictionary* _Nullable)data{

}

- (void)disconnect:(NSError *)error{
    
}

#pragma mark -
#pragma mark GameManagerDatasource
- (void)viewsHasUpdated:(NSArray<User *> *)users{
    
}

- (void)sceneHasUpdated:(Scene *)scene{
    
}

#pragma mark -
#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ViewerCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ViewerCell" forIndexPath:indexPath];
    User* viewer = [[GameManager sharedManager].userDatasource getModelAtIndexPath:indexPath];
    cell.viewer = viewer;
    [cell configureCell];
    return cell;
}



@end
