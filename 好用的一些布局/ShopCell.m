//
//  ShopCell.m
//  好用的一些布局
//
//  Created by SZT on 16/1/18.
//  Copyright © 2016年 SZT. All rights reserved.
//

#import "ShopCell.h"
#import "UIImageView+WebCache.h"

@implementation ShopCell

-(void)setImageUrl:(NSString *)imageUrl
{
    if (_imageUrl != imageUrl) {
        _imageUrl = imageUrl;
        [self.shopImage sd_setImageWithURL:[NSURL URLWithString:_imageUrl]];
    }
}

-(void)setShop:(Shop *)shop
{
    if (_shop != shop) {
        _shop = shop;
        [self.shopImage sd_setImageWithURL:[NSURL URLWithString:shop.img]];
        
        self.shopLabel.text = shop.price;
    }
}

- (void)awakeFromNib {
    // Initialization code
}

@end
