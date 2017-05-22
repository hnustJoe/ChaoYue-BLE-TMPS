//
//  CommonFunc.h
//  CarCare
//
//  Created by joe on 2017/3/13.
//  Copyright © 2017年 chaoyue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonFunc : NSObject

+ (NSString *)wheal1MacString;
+ (void)setWheahlmacstring:(NSString *)string;

+ (NSString *)wheal2MacString;
+ (void)setWheah2macstring:(NSString *)string;


+ (NSString *)wheal3MacString;
+ (void)setWheah3macstring:(NSString *)string;


+ (NSString *)wheal4MacString;
+ (void)setWheah4macstring:(NSString *)string;

+ (BOOL)hasSetSetting;
+ (void)setHasSetSetting;



+ (NSString *)yalidanwei;
+ (void)setyalidanwei:(NSString *)string;

+ (NSString *)wendudanwei;
+ (void)setwendudanwei:(NSString *)string;

+ (CGFloat)defaultYaliShang;
+ (void)setdefaultYaliShang:(CGFloat )defaultYaliShang;


+ (CGFloat)defaultYaliXia;
+ (void)setdefaultYaliXia:(CGFloat )defaultYaliXia;

+ (CGFloat)defaultWenduShang;
+ (void)setdefaultWenduShang:(CGFloat )defaultWenduShang;

+ (CGFloat)defaultdianliangXia;
+ (void)setdefaultdianliangXia:(CGFloat )dianliangXia;

+ (BOOL)isZhenDong;
+ (void)setisZhenDong:(BOOL )isZhenDong;

+ (NSString *)convertDataToHexStr:(NSData *)data;


+ (BOOL)isPlayVioce;
+ (void)setisPlayVioce:(BOOL )isPlayVioce;




+ (void)setWheahl1wendustring:(NSString *)wendustring yaliString:(NSString *)yaliString;
+ (NSString *)getWheahl1wendustring;
+ (NSString *)getWheahl1yaliString;

+ (void)setWheahl2wendustring:(NSString *)wendustring yaliString:(NSString *)yaliString;
+ (NSString *)getWheahl2wendustring;
+ (NSString *)getWheahl2yaliString;

+ (void)setWheahl3wendustring:(NSString *)wendustring yaliString:(NSString *)yaliString;
+ (NSString *)getWheahl3wendustring;
+ (NSString *)getWheahl3yaliString;

+ (void)setWheahl4wendustring:(NSString *)wendustring yaliString:(NSString *)yaliString;
+ (NSString *)getWheahl4wendustring;
+ (NSString *)getWheahl4yaliString;



+ (void)setWheahl4DataString:(NSString *)dataString;
+ (NSString *)getWheahl4DataString;

+ (void)setWheahl3DataString:(NSString *)dataString;
+ (NSString *)getWheahl3DataString;

+ (void)setWheahl2DataString:(NSString *)dataString;
+ (NSString *)getWheahl2DataString;

+ (void)setWheahl1DataString:(NSString *)dataString;
+ (NSString *)getWheahl1DataString;

@end
