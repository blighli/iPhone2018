//
//  NearbyPhotoCollectionViewController.m
//  游园
//
//  Created by Ray on 15/12/9.
//  Copyright © 2015年 Ray. All rights reserved.
//

#import "NearbyPhotoCollectionViewController.h"

struct buildings
{
    float longitude;
    float latitude;
    __unsafe_unretained NSString *titleForLocation;//建筑名并且图片名
    __unsafe_unretained NSString *subtitleForLocation;
}build[53] = {
    {120.014262,30.288625, @"恕园1号楼" , @"aaa" },
    {120.013533,30.289366,@"恕园2号楼",@"bbb"},
    {120.012449,30.288087,@"恕园3号楼",@"ccc"},
    {120.011408,30.287763,@"恕园4号楼",@"ddd"},
    {120.010732,30.287596,@"恕园5号楼",@""},
    {120.010271,30.28742,@"恕园6号楼",@""},
    {120.012546,30.289097,@"恕园7号楼",@""},
    {120.011762,30.289005,@"恕园8号楼",@""},
    {120.014219,30.290524,@"恕园9号楼",@""},
    {120.013951,30.290756,@"恕园10号楼",@""},
    {120.013447,30.290126,@"恕园11号楼",@""},
    {120.013468,30.290468,@"恕园12号楼",@""},
    {120.012589,30.290153,@"恕园13号楼",@""},
    {120.0129,30.290413,@"恕园14号楼",@""},
    {120.014305,30.290885,@"恕园15号楼",@""},
    {120.014037,30.291302,@"恕园16号楼",@""},
    {120.013382,30.290885,@"恕园17号楼",@""},
    {120.01187,30.290237,@"恕园18号楼",@""},
    {120.011516,30.290533,@"恕园19号楼",@""},
    {120.013629,30.291441,@"恕园20号楼",@""},
    {120.013286,30.291228,@"恕园21号楼",@""},
    {120.012696,30.291256,@"恕园22号楼",@""},
    {120.01188,30.291172,@"恕园23号楼",@""},
    {120.011011,30.290561,@"恕园24号楼",@""},
    {120.010872,30.290746,@"恕园25号楼",@""},
    {120.011162,30.290839,@"恕园26号楼",@""},
    {120.013812,30.291802,@"恕园27号楼",@""},
    {120.013393,30.29183,@"恕园28号楼",@""},
    {120.012921,30.291654,@"恕园29号楼",@""},
    {120.012192,30.29171,@"恕园30号楼",@""},
    {120.011923,30.292043,@"恕园31号楼",@""},
    {120.01158,30.291478,@"恕园32号楼",@""},
    {120.011086,30.291237,@"恕园33号楼",@""},
    {120.011505,30.291895,@"恕园34号楼",@""},
    {120.011129,30.291756,@"恕园35号楼",@""},
    {120.010346,30.291256,@"恕园36号楼",@""},
    {120.010657,30.291469,@"恕园37号楼",@""},
    {120.008404,30.291321,@"恕园38号楼",@""},
    {120.010947,30.288356,@"博文苑1号楼",@""},
    {120.0107,30.288884,@"博文苑2号楼",@""},
    {120.009681,30.288245,@"博文苑3号楼",@""},
    {120.009338,30.288754,@"博文苑4号楼",@""},
    {120.010207,30.289357,@"博文苑5号楼",@""},
    {120.010014,30.289857,@"博文苑6号楼",@""},
    {120.008447,30.289635,@"博文苑7号楼",@""},
    {120.008254,30.29019,@"博文苑8号楼",@""},
    {120.009488,30.290255,@"博文苑9号楼",@""},
    {120.009134,30.290728,@"博文苑10号楼",@""},
    {120.006194,30.290329,@"网球场",@""},
    {120.005261,30.290051,@"篮球场",@""},
    {120.006999,30.288801,@"操场",@""},
    {120.008973,30.289227,@"小足球场",@""},
    {120.013168,30.288301,@"校门",@""},
};

@implementation NearbyPhotoCollectionViewController

-(void)viewDidLoad
{
    [self setUpCollection];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CONTENT"];

    
    //避免遮住最下面的导航栏
    UIEdgeInsets contentInset = self.collectionView.contentInset;
    contentInset.bottom = 60;
    [self.collectionView setContentInset:contentInset];
}

-(void)setUpCollection
{
    self.photos = [NSMutableArray array];
    for(NSInteger index = 0;index < 9; index++)
    {
        UIImage *image = [UIImage imageNamed:@"校门"];
        [self.photos addObject:image];
    }
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 53;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CONTENT" forIndexPath:indexPath];

//    UIImage *image = self.photos[indexPath.row];
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:build[indexPath.row].titleForLocation]];
    imageV.frame = CGRectMake(0, 0, 96, 100);
    imageV.bounds = CGRectMake(0, 0, 96, 100);

    
    [cell.contentView addSubview:imageV];
    cell.backgroundColor = [UIColor blackColor];
    return cell;
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(96, 100);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    //跳转到下个界面
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ShowPhotoViewController *nextController = [mainStoryboard instantiateViewControllerWithIdentifier:@"ShowPhoto"];
    nextController.num = indexPath.row;
    [self.navigationController pushViewController:nextController animated:YES];
    
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

@end
