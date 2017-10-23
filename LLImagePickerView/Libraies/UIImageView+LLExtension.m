//
//  UIImageView+LLExtension.m
//  LLImagePickerDemo
//
//  Created by liushaohua on 2017/6/1.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "UIImageView+LLExtension.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (LLExtension)

- (void)ll_setImageWithUrlString: (NSString *)urlString placeholderImage: (UIImage *)placeholderImage {
    [self sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:placeholderImage];
}


@end
