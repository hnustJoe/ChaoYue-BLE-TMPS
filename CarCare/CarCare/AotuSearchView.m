//
//  AotuSearchView.m
//  CarCare
//
//  Created by joe on 2017/3/25.
//  Copyright © 2017年 chaoyue. All rights reserved.
//

#import "AotuSearchView.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface AotuSearchView()<CBCentralManagerDelegate>

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) UILabel *desLable;

@property (nonatomic,strong) CBCentralManager *centralmanager;

@property (nonatomic,assign) NSInteger index;


@property (nonatomic,assign) int time;

@end

@implementation AotuSearchView

- (instancetype)initWithindex:(NSInteger )index
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, WindowWidth, WindowHeight);
        self.index = index;
        
        UIView *bcView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWidth, WindowHeight)];
        [self addSubview:bcView];
        bcView.backgroundColor = [UIColor blackColor];
        bcView.alpha = 0.4;

        
        
        UILabel *desLable = [[UILabel alloc]init];
        desLable.text = [NSString stringWithFormat:@"%@......60S",NSLocalizedString(@"IDS_SEARCHING", @"搜索中")];
        desLable.textColor = mainColor;
        desLable.textAlignment = NSTextAlignmentCenter;
        desLable.layer.borderColor = mainColor.CGColor;
        desLable.layer.borderWidth = 1;
        desLable.layer.masksToBounds = YES;
        desLable.layer.cornerRadius = 10;
        [self addSubview:desLable];
        self.desLable = desLable;
        
        [desLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(20);
            make.right.equalTo(self.mas_right).offset(-20);
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
            make.height.equalTo(@60);
        }];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

- (void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.centralmanager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];

    
   self.time = 59;
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(count) userInfo:nil repeats:YES];
    
    

    
    
}


- (void)count{
    
    self.desLable.text = [NSString stringWithFormat:@"%@......%dS",NSLocalizedString(@"IDS_SEARCHING", @"搜索中"),(int)self.time];
    self.time--;
    
    
    
    
    if(self.time == 0){
        [self removeFromSuperview];
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)dismiss{
    [self removeFromSuperview];
    [self.centralmanager stopScan];
    
}


#pragma mark ble
#pragma mark CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    
    if(central.state == CBManagerStatePoweredOn)
    {
        
        [self.centralmanager scanForPeripheralsWithServices:nil  options:nil];
        
        
    }else{
    }
    
}


-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"自动扫描");
    NSDictionary *dic = advertisementData;
    NSLog(@"%@",dic);
    
    if ([dic objectForKey:@"kCBAdvDataManufacturerData"]) {
        
        NSData *data = [dic objectForKey:@"kCBAdvDataManufacturerData"];
        NSLog(@"服务是%@",peripheral.services);
        NSString *str = [CommonFunc convertDataToHexStr:data];
        
        NSLog(@"自动扫描%@",str);
        NSLog(@"lenght%ld",(unsigned long)str.length);
        
        if (str.length == 36 || str.length == 34) {
            
            
            [peripheral discoverServices:nil];
            
            NSString *macStr = [str substringWithRange:NSMakeRange(4, 12)];
            NSString *indexStr = [macStr substringWithRange:NSMakeRange(0, 2)];
            
            NSLog(@"macStr:%@ indexStr:%@ self.index:%ld",macStr,indexStr,(long)self.index);
            
            switch (self.index) {
                case 1:
                    if ([indexStr isEqualToString:@"80"]) {
                        [CommonFunc setWheahlmacstring:macStr];
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"findNewDevice" object:nil];
                        [self removeFromSuperview];
                        [self.centralmanager stopScan];
                    }
                    break;
                case 2:
                    if ([indexStr isEqualToString:@"81"]) {
                        [CommonFunc setWheah2macstring:macStr];
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"findNewDevice" object:nil];
                        [self removeFromSuperview];
                        [self.centralmanager stopScan];
                        
                    }
                    break;
                case 3:
                    if ([indexStr isEqualToString:@"82"]) {
                        [CommonFunc setWheah3macstring:macStr];
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"findNewDevice" object:nil];
                        [self removeFromSuperview];
                        [self.centralmanager stopScan];
                        
                    }
                    
                    break;
                case 4:
                    
                    if ([indexStr isEqualToString:@"83"]) {
                        [CommonFunc setWheah4macstring:macStr];
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"findNewDevice" object:nil];
                        [self removeFromSuperview];
                        [self.centralmanager stopScan];
                        
                    }
                    
                    break;
                    
                    
                default:
                    break;
            }

        }
        
        
        
        
    }
}

- (void)dealloc{
    NSLog(@"death");
}


@end
