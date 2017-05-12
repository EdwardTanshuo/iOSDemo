//
//  ParamsController.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 12/4/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "ParamsController.h"
#import "SettingSession.h"

@interface ParamsController ()
@property (strong, nonatomic) SettingSession* setting;

@property (weak, nonatomic) IBOutlet UISlider *resolution;
@property (weak, nonatomic) IBOutlet UISlider *bitrate;
@property (weak, nonatomic) IBOutlet UISlider *brightness;
@property (weak, nonatomic) IBOutlet UISlider *quality;
@property (weak, nonatomic) IBOutlet UISlider *fps;
@property (weak, nonatomic) IBOutlet UISwitch *facedetector;

@property (weak, nonatomic) IBOutlet UILabel *resolutionlabel;
@property (weak, nonatomic) IBOutlet UILabel *bitratelabel;
@property (weak, nonatomic) IBOutlet UILabel *brightnesslabel;
@property (weak, nonatomic) IBOutlet UILabel *qualitylabel;
@property (weak, nonatomic) IBOutlet UILabel *fpslabel;
@end

@implementation ParamsController

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"参数设置";
    
    [self setupUI];
    [self setupParams];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
     [cell setBackgroundColor:[UIColor clearColor]];
}

#pragma mark -
#pragma mark setups
- (void)setupUI{
    self.tableView.tableFooterView = [UIView new];
#ifdef TEST_MODE
    self.view.userInteractionEnabled = YES;
#else
    self.view.userInteractionEnabled = NO;
#endif
}

- (void)setupParams{
    self.setting = [SettingSession new];
    self.resolution.value = self.setting.width;
    self.bitrate.value = self.setting.bitrate / 1024;
    self.quality.value = self.setting.quality;
    self.fps.value = self.setting.fps;
    self.brightness.value = self.setting.brightness;
    self.facedetector.on = self.setting.faceDetectOn;
    [self adjustText];
}

#pragma mark -
#pragma mark methods
- (void)adjustText{
    self.resolutionlabel.text = [NSString stringWithFormat:@"%lu x %lu", (unsigned long)(self.resolution.value), (unsigned long)(self.resolution.value / 2.0)];
    self.bitratelabel.text = [NSString stringWithFormat:@"%luk", (unsigned long)(self.bitrate.value)];
    self.brightnesslabel.text = [NSString stringWithFormat:@"%.1f", self.brightness.value];
    NSInteger quality = (NSInteger)(self.quality.value);
    switch (quality) {
        case 0:
            self.qualitylabel.text = @"低";
            break;
        case 1:
            self.qualitylabel.text = @"中";
            break;
        case 2:
            self.qualitylabel.text = @"高";
            break;
        case 3:
            self.qualitylabel.text = @"原始";
            break;
        default:
            break;
    }
    self.fpslabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)(self.fps.value)];
}

#pragma mark -
#pragma mark actions
- (IBAction)resolutionAction:(id)sender {
    float newStep = roundf((_resolution.value) / 32);
    self.resolution.value = newStep * 32;
    self.resolutionlabel.text = [NSString stringWithFormat:@"%lu x %lu", (unsigned long)(self.resolution.value), (unsigned long)(self.resolution.value / 2.0)];
    self.setting.width = self.resolution.value;
    self.setting.height = self.resolution.value / 2;
}

- (IBAction)bitrateAction:(id)sender {
    float newStep = roundf((_bitrate.value) / 100);
    self.bitrate.value = newStep * 100;
    self.bitratelabel.text = [NSString stringWithFormat:@"%luk", (unsigned long)(self.bitrate.value)];
    self.setting.bitrate = self.bitrate.value * 1024;
}

- (IBAction)brightnessAction:(id)sender {
    float newStep = roundf((_brightness.value) / 0.1);
    self.brightness.value = newStep * 0.1;
    self.brightnesslabel.text = [NSString stringWithFormat:@"%.1f", self.brightness.value];
    self.setting.brightness = self.brightness.value;
}

- (IBAction)qualityAction:(id)sender {
    float newStep = roundf((_quality.value) / 1);
    self.quality.value = newStep * 1;
    NSInteger quality = (NSInteger)(self.quality.value);
    switch (quality) {
        case 0:
            self.qualitylabel.text = @"低";
            break;
        case 1:
            self.qualitylabel.text = @"中";
            break;
        case 2:
            self.qualitylabel.text = @"高";
            break;
        case 3:
            self.qualitylabel.text = @"原始";
            break;
        default:
            break;
    }
    self.setting.quality = self.quality.value;
}

- (IBAction)fpsAction:(id)sender {
    float newStep = roundf((_fps.value) / 1);
    self.fps.value = newStep * 1;
    self.fpslabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)(self.fps.value)];
    self.setting.fps = self.fps.value;
}

- (IBAction)faceDetectorOnAction:(id)sender {
    self.setting.faceDetectOn = self.facedetector.on;
}
    

@end
