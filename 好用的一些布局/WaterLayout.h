//
//  WaterLayout.h
//  好用的一些布局
//
//  Created by SZT on 16/1/18.
//  Copyright © 2016年 SZT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WaterLayout;

@protocol WaterFlowLayoutdelegate <NSObject>

- (CGFloat)waterflowLayout:(WaterLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;

@end

@interface WaterLayout : UICollectionViewLayout



@property(nonatomic,assign)UIEdgeInsets sectionInset;

@property(nonatomic,assign)CGFloat columnSpace;

@property(nonatomic,assign)CGFloat rowSpace;

@property(nonatomic,assign)int columucount;

@property(nonatomic,assign)id<WaterFlowLayoutdelegate> delegate;





@end
