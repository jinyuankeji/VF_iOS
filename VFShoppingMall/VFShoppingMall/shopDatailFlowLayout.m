//
//  shopDatailFlowLayout.m
//  VFShoppingMall
//
//  Created by gushi on 16/10/1.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import "shopDatailFlowLayout.h"
#import "FrameMainLFL.h"


@implementation shopDatailFlowLayout


-(instancetype)init{
    if (self=[super init]) {
        
        //设置collectionView中每个单元格的大小
        //        self.itemSize = CGSizeMake((DEVICE_WIDTH-20)/2, (DEVICE_WIDTH-20)/2+50);
        self.itemSize = SizeMake_LFL((375-10)/2, (375-10)/2*27/20);
        //设置滚动方向
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        //设置collectionView中每个单元格之间的最小行间距
        self.minimumLineSpacing = 1;
        
        //设置collectionView中整体单元格上左下右的空白区域大小
        self.sectionInset = UIEdgeInsetsMake(0, 0, 1, 1 );
    }
    return  self;
}

@end
