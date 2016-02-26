//
//  ShopCell.h
//  好用的一些布局
//
//  Created by SZT on 16/1/18.
//  Copyright © 2016年 SZT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shop.h"

@interface ShopCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *shopImage;
@property (weak, nonatomic) IBOutlet UILabel *shopLabel;

@property(nonatomic,copy)NSString *imageUrl;

@property(nonatomic,strong)Shop *shop;

@end
