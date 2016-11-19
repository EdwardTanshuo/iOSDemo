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
#import <GPUImage/GPUImageFramework.h>
#import <NSLogger/LoggerClient.h>
#import "DanmuManager.h"
#import "DanmuCell.h"

@interface LiveController ()<LiveDataSourceDelegate, DanmuDatasourceDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) GPUImageView* imageView;

@property (nonatomic, strong) UILabel* debug;
@property (nonatomic, strong) UILabel* error;

@property (weak, nonatomic) IBOutlet UITableView *danmu_table;

@end

@implementation LiveController

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupViews];
    [self setupDanmuTable];
    [self launchLive];
    
    [DanmuManager sharedManager].delegate = self;
}

- (void)dealloc{
    [LiveManager sharedManager].delegate = nil;
    [[LiveManager sharedManager] stopLive];
    
    [DanmuManager sharedManager].delegate = nil;
}

- (void)launchLive{
    [LiveManager sharedManager].delegate = self;
    [[LiveManager sharedManager] startLiveWithView:_imageView];
}

- (void)setupViews{
    _imageView = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_imageView setBackgroundColorRed:0 green:0 blue:0 alpha:1.0];
    [self.view addSubview:_imageView];
    
    UILabel* debug = [[UILabel alloc] initWithFrame:self.view.bounds];
    debug.numberOfLines = 2;
    [self.view addSubview:debug];
    debug.textColor = [UIColor whiteColor];
    _debug = debug;
    
    CGRect rect = self.view.bounds;
    rect.origin.y += 40;
    UILabel* error = [[UILabel alloc] initWithFrame:rect];
    error.numberOfLines = 2;
    [self.view addSubview:error];
    error.textColor = [UIColor redColor];
    _error = error;

}

- (void)setupDanmuTable{
    _danmu_table.delegate = self;
    _danmu_table.dataSource = self;
    _danmu_table.backgroundColor = [UIColor clearColor];

    [self.danmu_table registerNib:[UINib nibWithNibName:@"DanmuCell" bundle:nil] forCellReuseIdentifier:@"DanmuCellID"];
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
    _debug.text = [NSString stringWithFormat:@"%d", ((char*)buffer)[0]];
}

#pragma mark -
#pragma mark DanmuDatasourceDelegate
- (void)dataHasChanged:(NSArray<Danmu *> *)danmus{
    [self.danmu_table reloadData];
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
@end
