//
//  BindDeviceView.m
//  CarCare
//
//  Created by joe on 2017/3/13.
//  Copyright © 2017年 chaoyue. All rights reserved.
//

#import "BindDeviceView.h"

@interface BindDeviceView ()

@property (nonatomic,strong) UITextField *macStringtextField;

@end


@implementation BindDeviceView

- (instancetype)init{
    
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, WindowWidth, WindowHeight);
        UIView *bcView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWidth, WindowHeight)];
        bcView.backgroundColor = [UIColor blackColor];
        bcView.alpha = 0.8;
        [self addSubview:bcView];
    
        
        
        UIImage *boxImage = [UIImage imageNamed:@"提示框"];
        UIImageView *boxImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, boxImage.size.width, boxImage.size.height)];
        boxImageView.center = CGPointMake(WindowWidth/2.0, WindowHeight/2.0);
        boxImageView.image =boxImage;
        [self addSubview:boxImageView];
        boxImageView.userInteractionEnabled = YES;
        
        
        UILabel *des1Lable = [[UILabel alloc]init];
        des1Lable.text = NSLocalizedString(@"IDS_INPUT_WHEAL_CODE", @"请输入轮胎编码\n(由0-9，a-f，A-F组成)");
        des1Lable.textColor = mainColor;
        des1Lable.numberOfLines = 0;
        des1Lable.textAlignment = NSTextAlignmentCenter;
        [boxImageView addSubview:des1Lable];
        [des1Lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(boxImageView.mas_centerX);
            make.top.equalTo(boxImageView.mas_top).offset(25);
        }];
        
        
        
        UITextField *macStringtextField = [[UITextField alloc]init];
        [boxImageView addSubview:macStringtextField];
        macStringtextField.keyboardType = UIKeyboardTypeASCIICapable;
        macStringtextField.textColor = [UIColor whiteColor];
        [macStringtextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(boxImageView.mas_left).offset(20);
            make.right.equalTo(boxImageView.mas_right).offset(-20);
            make.top.equalTo(des1Lable.mas_bottom).offset(30);
        }];
        macStringtextField.delegate = self;
        self.macStringtextField = macStringtextField;
        
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = mainColor;
        [boxImageView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(macStringtextField.mas_left);
            make.right.equalTo(macStringtextField.mas_right);
            make.bottom.equalTo(macStringtextField.mas_bottom);
            make.width.equalTo(macStringtextField.mas_width);
            make.height.equalTo(@1);
        }];
        
        
        UIButton *cancelBtn = [[UIButton alloc]init];
        [cancelBtn setTitle: NSLocalizedString(@"IDS_CANCEL", @"取消") forState:UIControlStateNormal];
        [self addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(boxImageView.mas_left).mas_offset(75 * WindowWidth/375.0);
            make.bottom.equalTo(boxImageView.mas_bottom).offset(-15);
        }];
        [cancelBtn addTarget:self action:@selector(cancelBtn_clicked) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *certainBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        [certainBtn setTitle:NSLocalizedString(@"IDS_ENSURE", @"确定") forState:UIControlStateNormal];
        [self addSubview:certainBtn];
        certainBtn.center = CGPointMake(100, 100);
        [certainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(boxImageView.mas_right).mas_offset(-75 * WindowWidth/375.0);
            make.bottom.equalTo(boxImageView.mas_bottom).offset(-15);
        }];
        [certainBtn addTarget:self action:@selector(certainBtn_clicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


- (void)cancelBtn_clicked{
    
    [self removeFromSuperview];


}


- (void)certainBtn_clicked{
    
    
    if (self.macStringtextField.text.length != 6) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"IDS_INPUT_RIGHT_CODE", @"请输入正确的编号") message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"IDS_ENSURE", @"确定"), nil];
        [alert show];
        return;
    }
    
    
    if (([CommonFunction wheal1MacString].length > 6 && [self.macStringtextField.text isEqualToString:[[CommonFunction wheal1MacString] substringFromIndex:6]]) ||
        ([CommonFunction wheal2MacString].length > 6 && [self.macStringtextField.text isEqualToString:[[CommonFunction wheal2MacString] substringFromIndex:6]]) ||
        ([CommonFunction wheal3MacString].length > 6 && [self.macStringtextField.text isEqualToString:[[CommonFunction wheal3MacString] substringFromIndex:6]]) ||
        ([CommonFunction wheal4MacString].length > 6 && [self.macStringtextField.text isEqualToString:[[CommonFunction wheal4MacString] substringFromIndex:6]])) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"IDS_DEVICE_HAS_BEEN_BIND", @"设备已经被绑定") message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"IDS_ENSURE", @"确定"), nil];
        [alert show];
        return;

    }
    
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(certainClickView:text:)]) {
        [self.delegate certainClickView:self text:self.macStringtextField.text];
    }
    
    
    [self removeFromSuperview];

    

}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
    }
    
    
    
    if (textField.text.length == 6 && ![string isEqualToString:@""]) {
        return NO;
    }
    
    return YES;
}




@end
