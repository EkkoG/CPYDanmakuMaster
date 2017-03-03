//
//  CPYDanmakuMaster.h
//  Pods
//
//  Created by ciel on 2017/2/27.
//
//

#import <Foundation/Foundation.h>

@interface CPYDanmakuMaster : NSObject

@property (nonatomic, assign) CGFloat speed;

@property (nonatomic, assign) NSInteger row;

@property (nonatomic, strong, readonly) UIView *previewView;

@property (nonatomic, assign) BOOL allowOverlay;

- (void)addDanmaku:(UIView *)danmakuView;

@end
