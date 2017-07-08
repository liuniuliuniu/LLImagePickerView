//
//  UIImageView+LLMediaExt.m
//  LLImagePickerDemo
//
//  Created by liushaohua on 2017/6/1.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "UIImageView+LLMediaExt.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (LLMediaExt)

- (void)ll_setImageWithUrlString: (NSString *)urlString placeholderImage: (UIImage *)placeholderImage {
    [self sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:placeholderImage];
}


@end
