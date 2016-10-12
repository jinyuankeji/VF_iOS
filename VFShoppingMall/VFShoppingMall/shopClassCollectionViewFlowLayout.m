//
//  shopClassCollectionViewFlowLayout.m
//  VFShoppingMall
//
//  Created by gushi on 16/9/29.
//  Copyright © 2016年 jinyuankeji. All rights reserved.
//

#import "shopClassCollectionViewFlowLayout.h"
#import "FrameMainLFL.h"

@implementation shopClassCollectionViewFlowLayout

-(instancetype)init{
    if (self=[super init]) {
        
        //设置collectionView中每个单元格的大小
//        self.itemSize = CGSizeMake((DEVICE_WIDTH-20)/2, (DEVICE_WIDTH-20)/2+50);
        self.itemSize = SizeMake_LFL((375-80)/3-8, ((375-80)/3-8)*1.3);
        //设置滚动方向
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        //设置collectionView中每个单元格之间的最小行间距
        self.minimumLineSpacing = 2;
        
        //设置collectionView中整体单元格上左下右的空白区域大小
        self.sectionInset = UIEdgeInsetsMake(0, 2, 2, 2 );
    }
    return  self;
}


@end
