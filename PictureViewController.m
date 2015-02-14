//
//  PictureViewController.m
//  Uni app
//
//  Created by Imtiaz Hossain on 11/28/14.
//  Copyright (c) 2014 Imtiaz Hossain. All rights reserved.
//

#import "PictureViewController.h"
#import "SWRevealViewController.h"
#import "DetailTraditionViewController.h"
#import "EventTraditionViewController.h"
#import "Reachability.h"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface PictureViewController (){
    NSMutableArray *traditionPhotos;
    
    NSString* profileName;
    NSString* profileDescription;
    NSString* profileImage;
    NSString* profileId;
    
    NSString *data;
    NSString* userCacheEmail;
    
    NSString* userInfo;
    NSString* eventInfo;
    NSString* userName;
    
    NSMutableArray* myArray;
    NSMutableArray* titleArray;
    
}

@end

@implementation PictureViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)saveUserSettings{
    NSString*   emailValue;
    [[NSUserDefaults standardUserDefaults] setObject:emailValue forKey:@"sensativity"];
}

-(void)loadUserSettings{
    NSString*   emailValue;
    emailValue = [[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
    if(emailValue == nil){
        userCacheEmail = @" ";
    }else{
        userCacheEmail = emailValue;
    }
}

-(void)getEventInfo{
    
    NSString*ACCESS_KEY=@"emran4axiz";
    NSString*EMAIL_ID=@"user5@uni.edu";
    
    NSString *post =[[NSString alloc] initWithFormat:@"ACCESS_KEY=%@&EMAIL_ID=%@",ACCESS_KEY,EMAIL_ID];
    NSURL *url=[NSURL URLWithString:@"http://4axiz.com/tradition/api/Tradition/getTraditionInfo?ACCESS_KEY=emran4axiz"];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSError *error;
    NSError *jsonError = nil;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    eventInfo =[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    NSLog(@"---eventInfo----%@",eventInfo);
    NSData* data = [eventInfo dataUsingEncoding:NSUTF8StringEncoding];
    
    // this is used for dynamic array creation
    myArray = [NSMutableArray array];
    titleArray = [NSMutableArray array];
    //NSArray *myArray = [NSArray array];
    int counter = 0;
    
    NSArray *jsonArray = (NSArray *)[NSJSONSerialization JSONObjectWithData:data options:nil error:&jsonError];
    for (NSDictionary *dic in jsonArray){
        // Now you have dictionary get value for key
        //We are casting to NSString because we know it will return a string. do this for every property...
        NSString *tID = (NSString*) [dic valueForKey:@"T_ID"];
        NSLog(@"T_ID = %@",tID);
        NSString *tDescription = (NSString*) [dic valueForKey:@"T_DESCRIPTION"];
        NSLog(@"T_DESCRIPTION = %@",tDescription);
        NSString *tName = (NSString*) [dic valueForKey:@"T_NAME"];
        NSLog(@"T_NAME = %@",tName);
        NSString *tLogoURL = (NSString*) [dic valueForKey:@"T_LOGO_URL"];
        NSLog(@"T_LOGO_URL = %@",tLogoURL);
        
        counter++;
        NSLog(@"counter = %d",counter);
        [myArray addObject:[NSString stringWithFormat:@"%@", tLogoURL]];
        [titleArray addObject:[NSString stringWithFormat:@"%@", tName]];
    }
    
    NSLog(@"FINAL ARRAY = %@",myArray);
    NSLog(@"FINAL ARRAY = %@",titleArray);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Do any additional setup after loading the view.
    self.title = @"Picture View";
    
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:1.0f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    _collection.delegate = self;
    _collection.dataSource = self;
}

- (void)viewDidAppear:(BOOL)animated{
    //initializeArrays is the function that initializes the arrays
    Reachability *internetReach = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
    if (netStatus == NotReachable)
    {
        //no connection of Internet
        UIAlertView *emailAlertMessage=[[UIAlertView alloc]initWithTitle:@"Failed!" message:@"Internet required to complete registration." delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [emailAlertMessage show];
    }
    else{
        NSLog(@"Net ache");
        [self getEventInfo];
        [self.collection reloadData];
        //[self.activityIndicatorView stopAnimating];
    }
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
    //NSLog(@"Count = %lu",(unsigned long)traditionPhotos.count);
    NSLog(@"Count = %lu",(unsigned long)myArray.count);
    //return traditionPhotos.count;
    return myArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    //NSLog(@"CELL Rolling = %@",cell);
    //UIImageView *myCellImage = (UIImageView *)[cell viewWithTag:100];
    
    //myCellImage.image = [UIImage imageNamed:(NSString*)[traditionPhotos objectAtIndex:indexPath.row]];
    //[myCellImage setImage:[UIImage imageNamed:(NSString*)[traditionPhotos objectAtIndex:indexPath.row]]];
    //NSLog(@"recipeImageView.image = %@",myCellImage.image);
    
    
    //    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    //    recipeImageView.image = [UIImage imageNamed:[traditionPhotos objectAtIndex:indexPath.row]];
    //recipeImageView.image = [UIImage imageNamed:[myArray objectAtIndex:indexPath.row]];
    
    // load IMAGE from url
    //    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    //    NSLog(@"SINGLE IMAGE LINK = %@",[myArray objectAtIndex:indexPath.row]);
    //    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [myArray objectAtIndex:indexPath.row]]];
    //    recipeImageView.image = [UIImage imageWithData: imageData];
    
    //    // load IMAGE from url another way
    //    id path = [myArray objectAtIndex:indexPath.row];
    //    NSURL *url = [NSURL URLWithString:path];
    //    NSData *data = [NSData dataWithContentsOfURL:url];
    //    //UIImage *img = [[UIImage alloc] initWithData:data cache:NO];
    //    recipeImageView.image = [UIImage imageWithData: imageData];
    
    
    //    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    //    cell.tag=[traditionPhotos objectAtIndex:indexPath.row];
    //    NSLog(@"cell = %@",[traditionPhotos objectAtIndex:indexPath.row]);
    
    // Load label-name
    UILabel *traditionLabelView = (UILabel *)[cell viewWithTag:120];
    
    //Calculate the expected size based on the font and linebreak mode of your label
    // FLT_MAX here simply means no constraint in height
//    CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
//    CGSize expectedLabelSize = [[titleArray objectAtIndex:indexPath.row] sizeWithFont:traditionLabelView.font constrainedToSize:maximumLabelSize lineBreakMode:traditionLabelView.lineBreakMode];
    //adjust the label the the new height.
//    CGRect newFrame = traditionLabelView.frame;
//    newFrame.size.height = expectedLabelSize.height;
//    traditionLabelView.frame = newFrame;
    //traditionLabelView.frame = [self setDynamicHeightForLabel:traditionLabelView andMaxWidth:150.0];
    traditionLabelView.numberOfLines = 0;
    [traditionLabelView sizeToFit];
    traditionLabelView.text = [NSString stringWithFormat:@"%@", [titleArray objectAtIndex:indexPath.row]];
    
    // Load the image with an GCD block executed in another thread
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    recipeImageView.image = [UIImage imageNamed:@"Icon@2x.png"];
    
    dispatch_async(kBgQueue, ^{
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[myArray objectAtIndex:indexPath.row]]]];
        if (imgData) {
            UIImage *image = [UIImage imageWithData:imgData];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    //recipeImageView.image = image;
                    
                    UICollectionViewCell *updateCell = [_collection cellForItemAtIndexPath:indexPath];
                    
                    if (updateCell) {
                        recipeImageView.image = image;
                        
                    }
                });
            }
        }
    });
    
    return cell;
}


-(CGRect)setDynamicHeightForLabel:(UILabel*)_lbl andMaxWidth:(float)_width{
    CGSize maximumLabelSize = CGSizeMake(_width, FLT_MAX);
    
    CGSize expectedLabelSize = [_lbl.text sizeWithFont:_lbl.font constrainedToSize:maximumLabelSize lineBreakMode:_lbl.lineBreakMode];
    
    //adjust the label the the new height.
    CGRect newFrame = _lbl.frame;
    newFrame.size.height = expectedLabelSize.height;
    NSLog(@"%f",newFrame.size.height);
    return newFrame;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showEventList"]) {//showMyTraditionPhoto
        NSLog(@"welcome....");
        
        NSArray *indexPaths = [_collection indexPathsForSelectedItems];
        NSLog(@"indexPathsForSelectedItems = %@",indexPaths);
        
        //DetailTraditionViewController *destViewController = segue.destinationViewController;
        
        EventTraditionViewController *destViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
        
        NSLog(@"indexPath.row = %li",(long)indexPath.row);
        NSLog(@"indexPath.section = %li",(long)indexPath.section);
        NSLog(@"traditionPhotos = %@",myArray[indexPath.row]);
        
        destViewController.traditionImageName = myArray[indexPath.row];
        destViewController.traditionImageId = [NSString stringWithFormat:@"%lu", (long)indexPath.row];
        [self.collection deselectItemAtIndexPath:indexPath animated:NO];
    }
    
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
    return 1.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

// Layout: Set Edges
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0,0,0,0);  // top, left, bottom, right
}

#pragma mark - UICollectionViewDelegate

//- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
//
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
//    
//}

@end
