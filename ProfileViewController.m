//
//  ProfileViewController.m
//  Uni app
//
//  Created by Imtiaz Hossain on 11/23/14.
//  Copyright (c) 2014 Imtiaz Hossain. All rights reserved.
//

#import "ProfileViewController.h"
#import "SWRevealViewController.h"
#import "Reachability.h"

//@implementation UINavigationBar (CustomImage) -(void)drawRect:(CGRect)rect {
//    
//    CGRect currentRect = CGRectMake(0,0,100,45);
//    UIImage *image = [UIImage imageNamed:@"Icon-72.png"];
//    [image drawInRect:currentRect];
//}
//@end

@interface ProfileViewController (){
    NSArray *traditionPhotos;
    
    NSString* profileName;
    NSString* profileDescription;
    NSString* profileImage;
    NSString* profileId;
    
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
    // --- this is for navigationbar image set --- start ---
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
//    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"uni-icon.png"]];
//    [image setFrame:CGRectMake(55, 15, 38, 17)];
//    [view addSubview:image];
//    [self.navigationController.navigationBar addSubview:view];
    // --- this is for navigationbar image set --- ends ---
    
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar-bg.png"] forBarMetrics:UIBarMetricsDefault];
    //self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Icon-72.png"]];
    //UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yourimage2.jpg"]]];
    //self.navigationItem.rightBarButtonItem = item;
    
    // Do any additional setup after loading the view.
//    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
//    self.profileImageView.layer.borderWidth = 3.0f;
//    self.profileImageView.layer.borderColor = [UIColor whiteColor].CGColor;
//    self.profileImageView.clipsToBounds = YES;
    
    self.title = @"Profile";
    
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
    
    
    Reachability *internetReach = [Reachability reachabilityForInternetConnection];
	NetworkStatus netStatus = [internetReach currentReachabilityStatus];
    if (netStatus == NotReachable)
    {
        UIAlertView *emailAlertMessage=[[UIAlertView alloc]initWithTitle:@"Failed!" message:@"Internet required to complete registration." delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [emailAlertMessage show];
	}
    else{
        //NSURL *url = [NSURL URLWithString:@"http://4axiz.com/tradition/api/User/getUserInfo"];
        NSURL *url = [NSURL URLWithString:@"http://www.imtikon.com/apps/uni/profile.php"];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        NSString *boundary = [NSString stringWithString:@"*****"];
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
        NSMutableData *body = [NSMutableData data];
        NSLog(@"--%@--",body);
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"ACCESS_KEY\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@",@"emran4axiz"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"EMAIL_ID\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@",@"user1@uni.edu"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [request setHTTPBody:body];
        
        NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        //NSLog(@"returnData = %@",returnData);
        
        
//        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
//        NSLog([NSString stringWithFormat:@"Image Return String: %@", returnString]);
        NSError *jsonParsingError = nil;
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:returnData //1
                              options:0
                              error:&jsonParsingError];
        //NSLog(@"NSJSONSerialization = %@",json);
        NSDictionary* tweet;
        //NSLog(@"count = %lu",(unsigned long)[json count]);
        if([json count]>0){
            profileName = [[json objectForKey:@"profile"] objectForKey:@"U_NAME"];
            profileId = [[json objectForKey:@"profile"] objectForKey:@"U_ID"];
            profileDescription = [[json objectForKey:@"profile"] objectForKey:@"U_SEMESTER"];
            profileImage = [[json objectForKey:@"profile"] objectForKey:@"U_IMAGE_URL"];
        }
        /*for(int i=0; i<[json count];i++)
        {
            //tweet = [json objectForKey:@"U_IMAGE_URL"];
            NSLog(@"Statuses: %@", [[json objectForKey:@"profile"] objectForKey:@"U_ID"]);
        }*/
        
    }
    
    NSLog(@"profileImage = %@",profileImage);
    // load image into uiimage from remote server
    id path = profileImage;
    NSURL *url = [NSURL URLWithString:path];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    
    self.profileImageView.image = img;
    self.myName.text = profileName;//@"  Karen Keeton"
    self.myBio.text = profileDescription;//@"  I am a Student."
    
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
    //NSLog(@"Count = %lu",(unsigned long)traditionPhotos.count);
    return traditionPhotos.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    //NSLog(@"CELL Rolling = %@",cell);
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
    return 1.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

// Layout: Set Edges
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    // return UIEdgeInsetsMake(0,8,0,8);  // top, left, bottom, right
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
