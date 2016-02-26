//
//  ViewController.m
//  好用的一些布局
//
//  Created by SZT on 16/1/18.
//  Copyright © 2016年 SZT. All rights reserved.
//

#import "ViewController.h"
#import "WaterLayout.h"
#import "Shop.h"
#import "ShopCell.h"

static NSString *const identifier = @"cell";

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,WaterFlowLayoutdelegate>

@property(nonatomic,retain)NSMutableArray  *modelArray;

@property(nonatomic,strong)UICollectionView  *collectionView;

@end

@implementation ViewController

-(NSMutableArray *)modelArray{
    if (!_modelArray) {
        self.modelArray = [NSMutableArray array];
        NSString *path = [[NSBundle mainBundle]pathForResource:@"1" ofType:@"plist"];
        NSMutableArray *rootArray = [NSMutableArray arrayWithContentsOfFile:path];
        for (NSDictionary *dict in rootArray) {
            Shop *shop = [[Shop alloc]init];
            [shop setValuesForKeysWithDictionary:dict];
            [self.modelArray  addObject:shop];
        }
    }
    return _modelArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    WaterLayout *waterLayout = [[WaterLayout alloc]init];
    waterLayout.delegate = self;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:waterLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerNib:[UINib nibWithNibName:@"ShopCell" bundle:nil] forCellWithReuseIdentifier:identifier];
    
}


#pragma mark------------collectionView------------------


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.modelArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    Shop *shop = self.modelArray[indexPath.item];
    cell.shop = shop;
    return cell;
}

- (CGFloat)waterflowLayout:(WaterLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath
{
    Shop *shop = self.modelArray[indexPath.item];
    return shop.h/shop.w*width;
}




@end
