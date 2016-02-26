//
//  LineLayOut.m
//  好用的一些布局
//
//  Created by SZT on 16/1/26.
//  Copyright © 2016年 SZT. All rights reserved.
//

#import "LineLayOut.h"

@implementation LineLayOut

static const CGFloat HMItemWH = 100;


- (instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}


- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    
    CGRect lastRect;
    lastRect.origin = proposedContentOffset;
    lastRect.size = self.collectionView.frame.size;
    
    
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    
       NSArray *array = [self layoutAttributesForElementsInRect:lastRect];
    
  
    CGFloat adjustOffsetX = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (ABS(attrs.center.x - centerX) < ABS(adjustOffsetX)) {
            adjustOffsetX = attrs.center.x - centerX;
        }
    }
    
    return CGPointMake(proposedContentOffset.x + adjustOffsetX, proposedContentOffset.y);
}


- (void)prepareLayout
{
    [super prepareLayout];
    
    
    self.itemSize = CGSizeMake(HMItemWH, HMItemWH);
    CGFloat inset = (self.collectionView.frame.size.width - HMItemWH) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = HMItemWH * 0.7;
    
    
}


static CGFloat const HMActiveDistance = 150;

static CGFloat const HMScaleFactor = 0.6;

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    CGRect visiableRect;
    visiableRect.size = self.collectionView.frame.size;
    visiableRect.origin = self.collectionView.contentOffset;
    

    NSArray *array = [super layoutAttributesForElementsInRect:rect];

    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    

    for (UICollectionViewLayoutAttributes *attrs in array) {

        if (!CGRectIntersectsRect(visiableRect, attrs.frame)) continue;
        

        CGFloat itemCenterX = attrs.center.x;
        
        
        CGFloat scale = 1 + HMScaleFactor * (1 - (ABS(itemCenterX - centerX) / HMActiveDistance));
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return array;
}


@end
