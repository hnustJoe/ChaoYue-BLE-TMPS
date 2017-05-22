//
//  CommonFunc.m
//  CarCare
//
//  Created by joe on 2017/3/13.
//  Copyright © 2017年 chaoyue. All rights reserved.
//

#import "CommonFunc.h"

@implementation CommonFunc


+ (NSString *)wheal1MacString{
   NSString *str =  [[NSUserDefaults standardUserDefaults]objectForKey:@"wheal1MacString"];
    return str;
}


+ (void)setWheahlmacstring:(NSString *)string{
    [[NSUserDefaults standardUserDefaults]setObject:[string uppercaseString] forKey:@"wheal1MacString"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


+ (NSString *)wheal2MacString{
   NSString *str =  [[NSUserDefaults standardUserDefaults]objectForKey:@"wheal2MacString"];
    return str;
}


+ (void)setWheah2macstring:(NSString *)string{
    [[NSUserDefaults standardUserDefaults]setObject:[string uppercaseString] forKey:@"wheal2MacString"];
    [[NSUserDefaults standardUserDefaults]synchronize];

}



+ (NSString *)wheal3MacString{
    NSString *str =  [[NSUserDefaults standardUserDefaults]objectForKey:@"wheal3MacString"];
    return str;
}


+ (void)setWheah3macstring:(NSString *)string{
    [[NSUserDefaults standardUserDefaults]setObject:[string uppercaseString] forKey:@"wheal3MacString"];
    [[NSUserDefaults standardUserDefaults]synchronize];

}



+ (NSString *)wheal4MacString{
    NSString *str =  [[NSUserDefaults standardUserDefaults]objectForKey:@"wheal4MacString"];
    return str;
}


+ (void)setWheah4macstring:(NSString *)string{
    [[NSUserDefaults standardUserDefaults]setObject:[string uppercaseString] forKey:@"wheal4MacString"];
    [[NSUserDefaults standardUserDefaults]synchronize];

}

+ (BOOL)hasSetSetting{
   return [[NSUserDefaults standardUserDefaults]boolForKey:@"hasSetSetting"];
}


+ (void)setHasSetSetting{
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"hasSetSetting"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}



+ (NSString *)yalidanwei{
    NSString *str =  [[NSUserDefaults standardUserDefaults]stringForKey:@"yalidanwei"];
    return str;
}


+ (void)setyalidanwei:(NSString *)string{
    [[NSUserDefaults standardUserDefaults]setObject:string forKey:@"yalidanwei"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


+ (NSString *)wendudanwei{
    NSString *str =  [[NSUserDefaults standardUserDefaults]stringForKey:@"wendudanwei"];
    return str;
}


+ (void)setwendudanwei:(NSString *)string{
    [[NSUserDefaults standardUserDefaults]setObject:string forKey:@"wendudanwei"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


+ (CGFloat)defaultYaliShang{
    return  [[NSUserDefaults standardUserDefaults]floatForKey:@"defaultYaliShang"];
}


+ (void)setdefaultYaliShang:(CGFloat )defaultYaliShang{
    [[NSUserDefaults standardUserDefaults]setFloat:defaultYaliShang forKey:@"defaultYaliShang"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



+ (CGFloat)defaultYaliXia{
    return  [[NSUserDefaults standardUserDefaults]floatForKey:@"defaultYaliXia"];
}


+ (void)setdefaultYaliXia:(CGFloat )defaultYaliXia{
    [[NSUserDefaults standardUserDefaults]setFloat:defaultYaliXia forKey:@"defaultYaliXia"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (CGFloat)defaultWenduShang{
    return  [[NSUserDefaults standardUserDefaults]floatForKey:@"WenduShang"];
}


+ (void)setdefaultWenduShang:(CGFloat )defaultWenduShang{
    [[NSUserDefaults standardUserDefaults]setFloat:defaultWenduShang forKey:@"WenduShang"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (CGFloat)defaultdianliangXia{
    return  [[NSUserDefaults standardUserDefaults]floatForKey:@"dianliangXia"];
}


+ (void)setdefaultdianliangXia:(CGFloat )dianliangXia{
    [[NSUserDefaults standardUserDefaults]setFloat:dianliangXia forKey:@"dianliangXia"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (BOOL)isZhenDong{
    return  [[NSUserDefaults standardUserDefaults]boolForKey:@"isZhenDong"];
}


+ (void)setisZhenDong:(BOOL )isZhenDong{
    [[NSUserDefaults standardUserDefaults]setBool:isZhenDong forKey:@"isZhenDong"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}


+ (BOOL)isPlayVioce{
    BOOL b =  [[NSUserDefaults standardUserDefaults]boolForKey:@"isPlayVioce"];
    return b;
}


+ (void)setisPlayVioce:(BOOL )isPlayVioce{
    [[NSUserDefaults standardUserDefaults]setBool:isPlayVioce forKey:@"isPlayVioce"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


//保存上一次的显示值
+ (void)setWheahl1wendustring:(NSString *)wendustring yaliString:(NSString *)yaliString{
    [[NSUserDefaults standardUserDefaults]setObject:wendustring forKey:@"wendu1String"];
    [[NSUserDefaults standardUserDefaults]setObject:yaliString forKey:@"yali1String"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getWheahl1wendustring{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"wendu1String"];
}

+ (NSString *)getWheahl1yaliString{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"yali1String"];
}


+ (void)setWheahl2wendustring:(NSString *)wendustring yaliString:(NSString *)yaliString{
    [[NSUserDefaults standardUserDefaults]setObject:wendustring forKey:@"wendu2String"];
    [[NSUserDefaults standardUserDefaults]setObject:yaliString forKey:@"yali2String"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getWheahl2wendustring{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"wendu2String"];
}

+ (NSString *)getWheahl2yaliString{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"yali2String"];
}


+ (void)setWheahl3wendustring:(NSString *)wendustring yaliString:(NSString *)yaliString{
    [[NSUserDefaults standardUserDefaults]setObject:wendustring forKey:@"wendu3String"];
    [[NSUserDefaults standardUserDefaults]setObject:yaliString forKey:@"yali3String"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getWheahl3wendustring{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"wendu3String"];
}

+ (NSString *)getWheahl3yaliString{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"yali3String"];
}


+ (void)setWheahl4wendustring:(NSString *)wendustring yaliString:(NSString *)yaliString{
    [[NSUserDefaults standardUserDefaults]setObject:wendustring forKey:@"wendu4String"];
    [[NSUserDefaults standardUserDefaults]setObject:yaliString forKey:@"yali4String"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getWheahl4wendustring{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"wendu4String"];
}

+ (NSString *)getWheahl4yaliString{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"yali4String"];
}



+ (void)setWheahl4DataString:(NSString *)dataString{
    [[NSUserDefaults standardUserDefaults]setObject:dataString forKey:@"Wheahl4DataString"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getWheahl4DataString{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"Wheahl4DataString"];
}


+ (void)setWheahl3DataString:(NSString *)dataString{
    [[NSUserDefaults standardUserDefaults]setObject:dataString forKey:@"Wheahl3DataString"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getWheahl3DataString{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"Wheahl3DataString"];
}

+ (void)setWheahl2DataString:(NSString *)dataString{
    [[NSUserDefaults standardUserDefaults]setObject:dataString forKey:@"Wheahl2DataString"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getWheahl2DataString{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"Wheahl2DataString"];
}


+ (void)setWheahl1DataString:(NSString *)dataString{
    [[NSUserDefaults standardUserDefaults]setObject:dataString forKey:@"Wheahl1DataString"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getWheahl1DataString{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"Wheahl1DataString"];
}




@end
