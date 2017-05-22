//
//  BindDeviceView.h
//  CarCare
//
//  Created by joe on 2017/3/13.
//  Copyright © 2017年 chaoyue. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BindDeviceView;

@protocol BindDeviceViewDelegate <NSObject>

@optional
- (void)certainClickView:(BindDeviceView *)view text:(NSString *)text;


@end

@interface BindDeviceView : UIView<UITextFieldDelegate>


@property (nonatomic,assign) id<BindDeviceViewDelegate> delegate;

@end
