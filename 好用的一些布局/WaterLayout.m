//
//  WaterLayout.m
//  好用的一些布局
//
//  Created by SZT on 16/1/18.
//  Copyright © 2016年 SZT. All rights reserved.
//

#import "WaterLayout.h"

@interface WaterLayout()

@property(nonatomic,retain)NSMutableArray  *attrArray;

@property(nonatomic,strong)NSMutableDictionary *maxYDict;



@end

@implementation WaterLayout

-(void)prepareLayout
{
    [super prepareLayout];
    
    // 1.清空最大的Y值
    for (int i = 0; i<self.columucount; i++) {
        NSString *column = [NSString stringWithFormat:@"%d", i];
        self.maxYDict[column] = @(self.sectionInset.top);
    }
     
    [self.attrArray removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attrArray addObject:attr];
    }

    
}

-(NSMutableArray *)attrArray{
    if (!_attrArray) {
        _attrArray = [[NSMutableArray alloc]init];
    }
    return _attrArray;
}


/**
 *  返回所有的尺寸
 */
- (CGSize)collectionViewContentSize
{
    __block NSString *maxColumn = @"0";
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue] > [self.maxYDict[maxColumn] floatValue]) {
            maxColumn = column;
        }
    }];
    return CGSizeMake(0, [self.maxYDict[maxColumn] floatValue] + self.sectionInset.bottom);
}

-(NSMutableDictionary *)maxYDict{
    if (!_maxYDict) {
        _maxYDict = [[NSMutableDictionary alloc]init];
        for (int i = 0; i < self.columucount; i++) {
            NSString *column = [NSString stringWithFormat:@"%d",i];
            self.maxYDict[column] = @0;
        }
    }
    return _maxYDict;
}



-(instancetype)init{
    if (self = [super init]) {
        self.columnSpace = 10;
        self.rowSpace = 10;
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.columucount = 3;
    }
    return self;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
       return self.attrArray;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //假设最短的那一列是第0列
    __block NSString *minColumn = @"0";
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber  *maxY, BOOL * _Nonnull stop) {
       
        if ([maxY floatValue] < [self.maxYDict[minColumn] floatValue]) {
            minColumn = column;
        }
    }];
    
    CGFloat width = (self.collectionView.frame.size.width - self.sectionInset.right-self.sectionInset.right-(self.columucount - 1)*self.columnSpace)/self.columucount;
    CGFloat height = [self.delegate waterflowLayout:self heightForWidth:width atIndexPath:indexPath];
    
//    计算位置
    
    CGFloat x = self.sectionInset.left + (width + self.columnSpace)*[minColumn intValue];
    CGFloat y = [self.maxYDict[minColumn] floatValue]+self.rowSpace;
    
//    更新最大的y值
    self.maxYDict[minColumn] = @(y+height);
    
//    创建属性
    
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.frame = CGRectMake(x, y, width, height);
    
    return  attrs;
}


@end
