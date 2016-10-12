//
//  goodsSortBtn.m
//  VFShoppingMall
//
//  Created by gushi on 16/9/29.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import "goodsSortBtn.h"

@implementation goodsSortBtn

//50*65


//修改Button内部子视图的位置，需要重写几个以rect结尾的方法
- (CGRect)	imageRectForContentRect:(CGRect)contentRect
{//contentRectg是按钮的bounds，需要返回imageView的frame
    CGFloat x, y, w, h;
    h = contentRect.size.height*50/65;
    w = contentRect.size.width*9/10;
    y = 0;
    x = 0;
    return CGRectMake(x, y, w, h);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{//contentRect是按钮的bounds，需要返回label的frame
    CGFloat x, y, w, h;
    h = contentRect.size.height*15/65;
    w = contentRect.size.width*42/50;
    x = contentRect.size.width*6/50;
    y = contentRect.size.height*50/65;
    return CGRectMake(x, y, w, h);
}

@end
