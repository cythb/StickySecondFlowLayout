//
//  ViewController.m
//  StickySecondFlowLayoutDemo
//
//  Created by 汤海波 on 2/27/15.
//  Copyright (c) 2015 iHugo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UINib *preNib = [UINib nibWithNibName:@"PreviewSupplementView" bundle:nil];
    UINib *mapNib = [UINib nibWithNibName:@"MapSupplementView" bundle:nil];
    [self.collectionView registerNib:preNib
          forSupplementaryViewOfKind:@"PreviewSupplementView"
                 withReuseIdentifier:@"PreviewSupplementView"];
    [self.collectionView registerNib:mapNib 
          forSupplementaryViewOfKind:@"MapSupplementView" 
                 withReuseIdentifier:@"MapSupplementView"];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    UILabel *label = (id)[cell viewWithTag:1];
    label.text = [NSString stringWithFormat:@"cell-%d", indexPath.item];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = kind;
    UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
    return reusableView;
}

@end
