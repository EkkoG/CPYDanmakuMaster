//
//  CPYDanmakuMaster.m
//  Pods
//
//  Created by ciel on 2017/2/27.
//
//

#import "CPYDanmakuMaster.h"
#import "UIView+CPY_Utils.h"
#import "NSTimer+CPY_EZ_Helper.h"

static NSString const *kCPYDanmakuRowIdentifier = @"com.ciepy.danmaku.view.row.identifier";

static CGFloat const kCPYDanmakuTimeInterval = 0.02;
static NSInteger const kCPYDanmakuNoEmptyIndentier = -1;

@interface CPYDanmakuMaster ()

@property (nonatomic, strong, readwrite) UIView *previewView;

@property (nonatomic, strong) NSMutableArray *danmakus;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSArray *emptyIdentifiers;

@end

@implementation CPYDanmakuMaster

- (void)dealloc
{
    [self.timer invalidate];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self setDefaultConfig];
    [self setupTimer];
    [self setupEmptyIdentifiers];
}

- (void)setDefaultConfig {
    self.row = 3;
    self.speed = 2;
}

- (void)setupTimer {
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer cpy_ez_scheduledTimerWithTimeInterval:kCPYDanmakuTimeInterval block:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf showDanmaku];
    } repeats:YES];
}

- (void)setupEmptyIdentifiers {
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < self.row; i++) {
        [arr addObject:@YES];
    }
    self.emptyIdentifiers = [arr copy];
}

- (void)setEmptyIdentifer:(BOOL)identifier atIndex:(NSInteger)index {
    NSMutableArray *arr = [self.emptyIdentifiers mutableCopy];
    arr[index] = @(identifier);
    self.emptyIdentifiers = [arr copy];
}

- (void)showDanmaku {
    if (![self haveEmpty]) {
        return;
    }
    
    if (!self.danmakus.count) {
        return;
    }
    
    NSInteger nextLine = [self getAnEmptyRow];
    [self setEmptyIdentifer:NO atIndex:nextLine];
    
    UIView *v = self.danmakus.firstObject;
    
    [self.previewView addSubview:v];
    
    CGPoint p = CGPointMake(CGRectGetWidth(self.previewView.bounds), CGRectGetHeight(self.previewView.bounds) / self.row * nextLine) ;
    [v cpy_origin:p];
    
    [UIView animateWithDuration:self.speed delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        CGPoint p = CGPointMake(-CGRectGetWidth(v.frame), CGRectGetHeight(self.previewView.bounds) / self.row * nextLine) ;
        [v cpy_origin:p];
    } completion:^(BOOL finished) {
        [v removeFromSuperview];
    }];
    CGFloat interval = CGRectGetWidth(v.frame) / (CGRectGetWidth(v.frame) + CGRectGetWidth(self.previewView.frame)) * self.speed;// + 0.08;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setEmptyIdentifer:YES atIndex:nextLine];
    });
    [self.danmakus removeObject:v];
}

- (BOOL)haveEmpty {
    return [self getAnEmptyRow] != kCPYDanmakuNoEmptyIndentier;
}

- (NSInteger)getAnEmptyRow {
    __block NSInteger emptyRow = kCPYDanmakuNoEmptyIndentier;
    [self.emptyIdentifiers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj boolValue]) {
            emptyRow = idx;
            *stop = YES;
        }
    }];
    return emptyRow;
}

- (void)addDanmaku:(UIView *)danmakuView {
    if (![danmakuView cpy_haveSize]) {
        return;
    }
    [self.danmakus addObject:danmakuView];
}

- (void)setSpeed:(CGFloat)speed {
    _speed = speed;
}

- (void)setRow:(NSInteger)row {
    _row = row;
    [self setupEmptyIdentifiers];
}

- (UIView *)previewView {
	if (!_previewView) {
        _previewView = [[UIView alloc] init];
	}
	return _previewView;
}

- (NSMutableArray *)danmakus {
	if (!_danmakus) {
        _danmakus = [[NSMutableArray alloc] init];
	}
	return _danmakus;
}

@end
