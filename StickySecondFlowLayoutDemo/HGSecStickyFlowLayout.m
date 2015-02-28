//
//  HGSecStickyFlowLayout.m
//  StickySecondFlowLayoutDemo
//
//  Created by 汤海波 on 2/27/15.
//  Copyright (c) 2015 iHugo. All rights reserved.
//

#import "HGSecStickyFlowLayout.h"

@implementation HGSecStickyFlowLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    CGFloat firstHeight = 200;
    CGFloat secondHeight = 200;
    CGRect firstRect = CGRectMake(0, 0, 320, firstHeight);
    CGRect secondRect = CGRectMake(0, CGRectGetMaxY(firstRect), 320, secondHeight);
    
    // The rect should compensate the header size
    CGRect adjustedRect = rect;
    adjustedRect.origin.y -= CGRectGetHeight(firstRect);
    adjustedRect.origin.y -= CGRectGetHeight(secondRect);
    
    NSMutableArray *allItems = [[super layoutAttributesForElementsInRect:adjustedRect] mutableCopy];
    
    // 除了Preview之外，其他都下移
    for (UICollectionViewLayoutAttributes *attributes in allItems) {
        CGRect frame = attributes.frame;
        frame.origin.y += firstHeight + secondHeight;
        attributes.frame = frame;
        
        attributes.zIndex = 1;
    }
    
    // PreviewSupplementView
    UICollectionViewLayoutAttributes *previewAttribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:@"PreviewSupplementView" withIndexPath:[NSIndexPath indexPathWithIndex:0]];
    previewAttribute.frame = firstRect;
    previewAttribute.zIndex = 1024;
    [allItems addObject:previewAttribute];
    
    // MapSupplementView
    UICollectionViewLayoutAttributes *mapAttribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:@"MapSupplementView" withIndexPath:[NSIndexPath indexPathWithIndex:0]];
    mapAttribute.frame = secondRect;
    mapAttribute.zIndex = 1024;
    [allItems addObject:mapAttribute];
    
    if (self.collectionView.contentOffset.y > CGRectGetMaxY(firstRect)) {
        CGRect frame = mapAttribute.frame;
        frame.origin.y = self.collectionView.contentOffset.y + self.collectionView.contentInset.top;
        mapAttribute.frame = frame;
    }
    
    
    return allItems;
}

- (CGSize)collectionViewContentSize {
    CGSize size = [super collectionViewContentSize];
    size.height += 400;
    return size;
}


@end
