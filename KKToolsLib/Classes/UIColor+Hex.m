//
//  UIColor+Hex.m
//  FileMusic
//  
//  Created by 陈德军 on 2024/1/23.
//  Copyright ©合肥维方科技有限公司. All rights reserved.
//  
//                      ____   ____      __
//                     / ___\ / _  \    / /
//                    / /    / / / /   / /
//                   / /___ / /_/ /?__/ /
//                  /_ -_-_/____,‘\____/
//
//
    

#import "UIColor+Hex.h"

@implementation UIColor (Hex)
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}

+ (NSArray*)getRGBWithColor:(NSString*)color {
    
    // 从六位数值中找到RGB对应的位数并转换
    
    NSRange range;
    
    range.location=0;
    
    range.length=2;
    
    //R、G、B
    
    NSString*rString = [color substringWithRange:range];
    
    range.location=2;
    
    NSString*gString = [color substringWithRange:range];
    
    range.location=4;
    
    NSString*bString = [color substringWithRange:range];
    
    // Scan values
    
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return@[@(r),@(g),@(b)];
    
}

+ (UIColor *)getRGBWithFromColor:(NSString*)fromColor toColor:(NSString*)toColor shade:(CGFloat)mShade {
    
    NSArray*fromeRgb = [self getRGBWithColor:fromColor];
    
    NSArray*toRgb = [self getRGBWithColor:toColor];
    
    int fromR = [fromeRgb[0] intValue];
    
    int fromG = [fromeRgb[1] intValue];
    
    int fromB = [fromeRgb[2] intValue];
    
    
    
    int toR = [toRgb[0] intValue];
    
    int toG = [toRgb[1] intValue];
    
    int toB = [toRgb[2] intValue];
    
    
    
    int diffR = toR - fromR;
    
    int diffG = toG - fromG;
    
    int diffB = toB - fromB;
    
    
    
    int red = fromR + (int) ((diffR * mShade));
    
    int green = fromG + (int) ((diffG * mShade));
    
    int blue = fromB + (int) ((diffB * mShade));
    
    
    NSArray *colorArr = @[@(red /255.0f),@(green /255.0f),@(blue /255.0f)];
    
    CGFloat red11 = [colorArr[0] floatValue];
    
    CGFloat green11 = [colorArr[1] floatValue];
    
    CGFloat blue11 = [colorArr[2] floatValue];
    
    UIColor *bgColor = [UIColor colorWithRed:red11 green:green11 blue:blue11 alpha:1.0f];
    
    return bgColor;
}

@end
