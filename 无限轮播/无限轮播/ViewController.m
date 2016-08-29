//
//  ViewController.m
//  无限轮播
//
//  Created by 陈亮 on 16/8/29.
//  Copyright © 2016年 wanjia. All rights reserved.
//

#import "ViewController.h"
#import "BannerCell.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)NSMutableArray *array;
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectV;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.myCollectV registerNib:[UINib nibWithNibName:@"BannerCell" bundle:nil] forCellWithReuseIdentifier:@"BannerCellIdentify"];
    self.array=[NSMutableArray array];
    for (int i=0; i<6; i++) {
        int j=0;
        if (i==0) {
            j=4;
        }else if(i==5){
            j=1;
        }else{
            j=i; 
        }
        NSString *picName=[NSString stringWithFormat:@"%d.jpg",j];
        [_array addObject:picName];
    }
    self.pageControl.numberOfPages=_array.count-2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.array.count;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height);
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BannerCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"BannerCellIdentify" forIndexPath:indexPath];
    cell.imgV.image=[UIImage imageNamed:self.array[indexPath.row]];
    return cell;
}
#pragma mark-UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float width=[UIScreen mainScreen].bounds.size.width;
    float offsetX=scrollView.contentOffset.x;
    if (offsetX==0) {
        scrollView.contentOffset=CGPointMake(width*4, 0);
    }
    if (offsetX==width*5.0) {
        scrollView.contentOffset=CGPointMake(width, 0);
    }
    float currentPage=scrollView.contentOffset.x/width-0.5;
    self.pageControl.currentPage=ceil(currentPage)-1;
}
@end
