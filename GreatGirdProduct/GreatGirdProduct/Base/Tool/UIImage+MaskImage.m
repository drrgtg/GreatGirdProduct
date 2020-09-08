//
//  UIImage+MaskImage.m
//  GreatGirdProduct
//
//  Created by 刘Sir on 2020/9/8.
//  Copyright © 2020 tutu. All rights reserved.
//

#import "UIImage+MaskImage.h"

@implementation UIImage (MaskImage)

+(UIImage *)creatImageWithMaskImage:(UIImage *)MaskImage andBackimage:(UIImage *)Backimage{
    
    CGRect rect;
    if (MaskImage.size.height>1000.0||MaskImage.size.width>1000.0)
    {
        rect = CGRectMake(0,
                          0,
                          MaskImage.size.width,
                          MaskImage.size.height);
    }else{
        rect = CGRectMake(0,
                          0,
                          MaskImage.size.width * 4.0,
                          MaskImage.size.height * 4.0);
    }
    CGImageRef imageRef = CGImageCreateWithImageInRect([Backimage CGImage], rect);
    UIImage *cutIMG = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    //遮罩图
    CGImageRef maskImage = MaskImage.CGImage;
    //原图
    CGImageRef originImage = cutIMG.CGImage;
    CGContextRef mainViewContentContext;
    CGColorSpaceRef colorSpace;
    colorSpace = CGColorSpaceCreateDeviceRGB();
    // create a bitmap graphics context the size of the image
    mainViewContentContext = CGBitmapContextCreate (NULL,
                                                    rect.size.width,
                                                    rect.size.height,
                                                    8,
                                                    0,
                                                    colorSpace,
                                                    kCGImageAlphaPremultipliedLast);
    // free the rgb colorspace
    CGColorSpaceRelease(colorSpace);
    if (mainViewContentContext==NULL)
    {
//        NSLog(@"error");
    }
    
    CGContextClipToMask(mainViewContentContext,
                        CGRectMake(0,
                                   0,
                                   rect.size.width,
                                   rect.size.height),
                        maskImage);
    
    CGContextDrawImage(mainViewContentContext,
                       CGRectMake(0,
                                  0,
                                  rect.size.width,
                                  rect.size.height),
                       originImage);
    
    
    CGContextSetAllowsAntialiasing(mainViewContentContext, true);//说是抗锯齿，但貌似没用
    CGContextSetShouldAntialias(mainViewContentContext, true);
    // Create CGImageRef of the main view bitmap content, and then
    // release that bitmap context
    CGImageRef mainViewContentBitmapContext = CGBitmapContextCreateImage(mainViewContentContext);
    
    CGContextRelease(mainViewContentContext);
    // convert the finished resized image to a UIImage
    UIImage *theImage = [UIImage imageWithCGImage:mainViewContentBitmapContext];
    // image is retained by the property setting above, so we can
    // release the original
    
    CGImageRelease(mainViewContentBitmapContext);
    return theImage;
    
}

@end
