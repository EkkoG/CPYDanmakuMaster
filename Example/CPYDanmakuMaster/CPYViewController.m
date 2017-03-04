//
//  CPYViewController.m
//  CPYDanmakuMaster
//
//  Created by cielpy on 02/27/2017.
//  Copyright (c) 2017 cielpy. All rights reserved.
//

#import "CPYViewController.h"
#import <CPYDanmakuMaster/CPYDanmakuMaster.h>

@interface CPYViewController ()

@property (nonatomic, strong) CPYDanmakuMaster *danmakuMaster;

@end

@implementation CPYViewController


- (CPYDanmakuMaster *)danmakuMaster {
	if (!_danmakuMaster) {
        _danmakuMaster = [[CPYDanmakuMaster alloc] init];
        _danmakuMaster.row = 10;
        _danmakuMaster.speed = 2;
	}
	return _danmakuMaster;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.danmakuMaster.previewView];
    self.danmakuMaster.previewView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 400);
    
    for (int i = 0; i < 1000; i++) {
        int a = arc4random() % 200;
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100 + a, 30)];
        l.textAlignment = NSTextAlignmentCenter;
        l.backgroundColor = [UIColor yellowColor];
        l.text = [NSString stringWithFormat:@"%d", i];
        [self.danmakuMaster addDanmaku:l];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
