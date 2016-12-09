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

@interface LiveController ()<LiveDataSourceDelegate, DanmuDatasourceDelegate, GameManagerDelegate, GameManagerEvent, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) GPUImageView* imageView;

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
}

- (void)setupDanmuTable{
    _danmu_table.delegate = self;
    _danmu_table.dataSource = self;
    _danmu_table.backgroundColor = [UIColor clearColor];

    [self.danmu_table registerNib:[UINib nibWithNibName:@"DanmuCell" bundle:nil] forCellReuseIdentifier:@"DanmuCellID"];
}

#pragma mark -
#pragma mark actions
- (IBAction)closeActions:(id)sender {
    [[LiveManager sharedManager] stopLive];
    [LiveManager sharedManager].delegate = nil;
    [DanmuManager sharedManager].delegate = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)createGame:(id)sender {
    [[GameManager sharedManager] connect];
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
- (void)didConnected{
    [[GameManager sharedManager] entry:@"57f5e15f908766837cb858c7"];
}

- (void)entryCallBack:(id _Nullable) argsData{
    if([[argsData objectForKey:@"code"] integerValue] == 200){
        [[GameManager sharedManager] createGame:@"57f5e15f908766837cb858c7"];
    }
    
}

- (void)createCallBack:(id _Nullable) argsData{
    if([[argsData objectForKey:@"code"] integerValue] == 200){
        NSLog(@"OK");
    }
}

- (void)startCallBack:(id _Nullable) argsData{

}

- (void)endCallBack:(id _Nullable) argsData{

}

- (void)drawCallBack:(id _Nullable) argsData{

}

- (void)finishTurnCallBack:(id _Nullable) argsData{

}

#pragma mark -
#pragma mark GameManagerEvent
- (void)PlayerEnterEvent: (NSDictionary* _Nullable)data{

}

- (void)PlayerLeaveEvent: (NSDictionary* _Nullable)data{

}

- (void)NewTurnEvent: (NSDictionary* _Nullable)data{

}

@end
