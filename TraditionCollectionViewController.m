//
//  TraditionCollectionViewController.m
//  SliderMenu
//
//  Created by Imtiaz Hossain on 11/23/14.
//  Copyright (c) 2014 Imtiaz Hossain. All rights reserved.
//

#import "TraditionCollectionViewController.h"
#import "DetailTraditionViewController.h"
#import "SWRevealViewController.h"

@interface TraditionCollectionViewController () {
    NSArray *traditionPhotos;
}
@end

@implementation TraditionCollectionViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    
    // Initialize recipe image array
    traditionPhotos = [NSArray arrayWithObjects:@"tradition1.png", @"tradition2.png", @"tradition3.png", @"tradition4.png", @"tradition5.png", @"tradition6.png", @"tradition7.png", @"tradition8.png", @"tradition9.png", @"tradition10.png", @"tradition11.png", @"tradition12.png", @"tradition13.png", @"tradition1.png", @"tradition2.png", @"tradition3.png", nil];
    NSLog(@"traditionPhotos = %@",traditionPhotos);
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"Count = %lu",(unsigned long)traditionPhotos.count);
    return traditionPhotos.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    recipeImageView.image = [UIImage imageNamed:[traditionPhotos objectAtIndex:indexPath.row]];
    NSLog(@"recipeImageView.image = %@",recipeImageView.image);
    return cell;
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showTraditionPhoto"]) {
        
        NSLog(@"welcome....");
        
        NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
        NSLog(@"indexPathsForSelectedItems = %@",indexPaths);
     
        DetailTraditionViewController *destViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
    
        NSLog(@"indexPath.row = %li",(long)indexPath.row);
        NSLog(@"indexPath.section = %li",indexPath.section);
        NSLog(@"traditionPhotos = %@",traditionPhotos[indexPath.row]);
        
        destViewController.traditionImageName = traditionPhotos[indexPath.row];
        destViewController.traditionImageId = [NSString stringWithFormat:@"%lu", indexPath.row];
        [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
    }
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}

// Layout: Set Edges
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    // return UIEdgeInsetsMake(0,8,0,8);  // top, left, bottom, right
    return UIEdgeInsetsMake(0,0,0,0);  // top, left, bottom, right
}


@end
