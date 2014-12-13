//
//  ProfileViewController.m
//  Uni app
//
//  Created by Imtiaz Hossain on 11/23/14.
//  Copyright (c) 2014 Imtiaz Hossain. All rights reserved.
//

#import "ProfileViewController.h"
#import "SWRevealViewController.h"

@interface ProfileViewController (){
    NSArray *traditionPhotos;
}
@end

@implementation ProfileViewController

@synthesize profileImageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
    self.profileImageView.layer.borderWidth = 3.0f;
    self.profileImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.profileImageView.clipsToBounds = YES;
    
    self.title = @"Home";
    
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
    
    self.myPhoto.image = [UIImage imageNamed:(NSString*)@"according-to-science-these-are-the-best-photos-to-use-in-your-dating-profile.png"];
    self.myName.text = @"  Karen Keeton";
    self.myBio.text = @"  I am a Student.";
    
    _collection.delegate = self;
    _collection.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"Count = %lu",(unsigned long)traditionPhotos.count);
    return traditionPhotos.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    NSLog(@"CELL Rolling = %@",cell);
    //UIImageView *myCellImage = (UIImageView *)[cell viewWithTag:100];
    
    //myCellImage.image = [UIImage imageNamed:(NSString*)[traditionPhotos objectAtIndex:indexPath.row]];
    //[myCellImage setImage:[UIImage imageNamed:(NSString*)[traditionPhotos objectAtIndex:indexPath.row]]];
    //NSLog(@"recipeImageView.image = %@",myCellImage.image);
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    recipeImageView.image = [UIImage imageNamed:[traditionPhotos objectAtIndex:indexPath.row]];
    
    
    //    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    //    cell.tag=[traditionPhotos objectAtIndex:indexPath.row];
    //    NSLog(@"cell = %@",[traditionPhotos objectAtIndex:indexPath.row]);
    
    return cell;
}

/*- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
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
 
 }*/

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

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    
}


@end
