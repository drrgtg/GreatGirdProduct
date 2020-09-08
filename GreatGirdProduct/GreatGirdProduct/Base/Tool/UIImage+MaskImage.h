//
//  UIImage+MaskImage.h
//  GreatGirdProduct
//
//  Created by 刘Sir on 2020/9/8.
//  Copyright © 2020 tutu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (MaskImage)

+(UIImage *)creatImageWithMaskImage:(UIImage *)MaskImage andBackimage:(UIImage *)Backimage;

@end

NS_ASSUME_NONNULL_END
