//
//  UIImage+LLGif.m
//  LLImagePickerDemo
//
//  Created by liushaohua on 2017/6/1.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "UIImage+LLGif.h"
#import "UIImage+GIF.h"

@implementation UIImage (LLGif)

+ (UIImage *)ll_setGifWithName: (NSString *)name {
    return [self sd_animatedGIFNamed:name];
}

+ (UIImage *)ll_setGifWithData: (NSData *)data {
    return [self sd_animatedGIFWithData:data];
}


@end
