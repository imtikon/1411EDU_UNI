//
//  LeaderBoardViewController.m
//  Uni app
//
//  Created by Imtiaz Hossain on 11/24/14.
//  Copyright (c) 2014 Imtiaz Hossain. All rights reserved.
//

#import "LeaderBoardViewController.h"
#import "SWRevealViewController.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface LeaderBoardViewController (){
    
    NSString *data;
    NSString* userCacheEmail;
    NSMutableArray* myArray;
    
    NSMutableArray* uIDArray;
    NSMutableArray* uNameArray;
    NSMutableArray* uPointArray;
    NSMutableArray* uImgArray;
    
    NSString* userInfo;
    NSString* eventInfo;
    NSString* userName;
    
    NSString* profileName;
    NSString* profileDescription;
    NSString* profileImage;
    NSString* profileId;
    
    NSString* myPoint;
    NSString* myPhoto;
}

@end

@implementation LeaderBoardViewController

@synthesize rankingPosition;
@synthesize myOwnImageView;
@synthesize totalPoints;

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
    NSLog(@"userCacheEmail = %@",userCacheEmail);
}

-(void)getLeaderBoardInfo{
    
    NSString*ACCESS_KEY=@"emran4axiz";
    NSString*EMAIL_ID=userCacheEmail;
    
    NSString *post =[[NSString alloc] initWithFormat:@"ACCESS_KEY=%@&EMAIL_ADDRESS=%@",ACCESS_KEY,EMAIL_ID];
    NSURL *url=[NSURL URLWithString:@"http://4axiz.com/tradition/api_iphone/get_leaderboard"];
    
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
    //NSLog(@"---data----%@",data);
    
    // this is used for dynamic array creation
    myArray = [NSMutableArray array];
    uIDArray = [NSMutableArray array];
    uPointArray = [NSMutableArray array];
    uNameArray = [NSMutableArray array];
    uImgArray = [NSMutableArray array];
    
    int counter = 0;
    
    NSArray *jsonArray = (NSArray *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];//nil
    
    if([jsonArray valueForKey:@"user_point"]){
        for (NSDictionary *dic in [jsonArray valueForKey:@"user_point"]){
            if ([[dic valueForKey:@"UE_SUM"] isKindOfClass:[NSNull class]]){
                myPoint = @"0";
            }else{
                myPoint = (NSString*) [dic valueForKey:@"UE_SUM"];
            }
            //UE_PHOTO
            if ([[dic valueForKey:@"UE_PHOTO"] isKindOfClass:[NSNull class]]){
                myPhoto = @" ";
            }else{
                myPhoto = (NSString*) [dic valueForKey:@"UE_PHOTO"];
            }
        }
    }
    
    NSString* owner_position = [jsonArray valueForKey:@"owner_position"];
    NSLog(@"owner_position = %@",owner_position);
    
    //NSLog(@"---data----%@",[jsonArray valueForKey:@"leaderboard"]);
    if([[jsonArray valueForKey:@"message"] isEqualToString:@"success"]){
        
        for (NSDictionary *dic in [jsonArray valueForKey:@"others_point"]){
            // Now you have dictionary get value for key
            //We are casting to NSString because we know it will return a string. do this for every property...
            NSString *tID = (NSString*) [dic valueForKey:@"UE_ID"];
            NSLog(@"T_ID = %@",tID);
            NSString *tDescription;
            if ([[dic valueForKey:@"UE_SUM"] isKindOfClass:[NSNull class]]){
                tDescription = @"0";
            }else{
                tDescription = (NSString*) [dic valueForKey:@"UE_SUM"];
            }
            NSLog(@"T_DESCRIPTION = %@",tDescription);
            NSString *tName = (NSString*) [dic valueForKey:@"UE_NAME"];
            NSLog(@"T_NAME = %@",tName);
            NSString *tLogoURL = (NSString*) [dic valueForKey:@"UE_PHOTO"];
            NSLog(@"T_LOGO_URL = %@",tLogoURL);
        
            counter++;
            NSLog(@"counter = %d",counter);
            [uIDArray addObject:[NSString stringWithFormat:@"%@", tID]];
            [uNameArray addObject:[NSString stringWithFormat:@"%@", tName]];
            [uPointArray addObject:[NSString stringWithFormat:@"%@", tDescription]];
            if([tLogoURL isEqualToString:@"No image"]){
                [uImgArray addObject:[NSString stringWithFormat:@"%@", @""]];
            }else{
                [uImgArray addObject:[NSString stringWithFormat:@"%@", tLogoURL]];
            }
        
        }
    }
    //NSLog(@"---data----%@",[[jsonArray valueForKey:@"leaderboard"] valueForKey:@"5"]);
    NSLog(@"FINAL ARRAY = %@",uIDArray);
    NSLog(@"FINAL ARRAY = %@",uNameArray);
    NSLog(@"FINAL ARRAY = %@",uPointArray);
    NSLog(@"FINAL ARRAY = %@",uImgArray);
    
    totalPoints.text = [NSString stringWithFormat:@"Total Points %@ pts",myPoint];
    totalPoints.numberOfLines = 1;
    totalPoints.textAlignment = NSTextAlignmentCenter;
    totalPoints.lineBreakMode = NSLineBreakByWordWrapping;
    
    rankingPosition.text = [NSString stringWithFormat:@"%@",owner_position];
    
    // load IMAGE from url
    //UIImageView *myOwnImageView = (UIImageView *)[cell viewWithTag:109];
    myOwnImageView.image = [UIImage imageNamed:@"Icon@2x.png"];
    myOwnImageView.layer.borderWidth = 3.0f;
    myOwnImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    myOwnImageView.clipsToBounds = YES;
    NSLog(@"MY PROFILE IMAGE LINK = %@",myPhoto);
    //    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [uImgArray objectAtIndex:indexPath.row]]];
    //    studentImageView.image = [UIImage imageWithData: imageData];
    
    
    dispatch_async(kBgQueue, ^{
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",myPhoto]]];
        if (imgData) {
            UIImage *image = [UIImage imageWithData:imgData];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    //recipeImageView.image = image;
                    
                    //UITableViewCell *updateCell = [self.tableView cellForItemAtIndexPath:indexPath];
                    
                    //if (updateCell) {
                    // Do any additional setup after loading the view.
                    myOwnImageView.layer.cornerRadius = myOwnImageView.frame.size.width / 2;
                    myOwnImageView.image = image;
                    
                    //}
                });
            }
        }
    });
    
}

-(void)reloadDatas
{
    //dispatch_queue_t concurrentQueue = dispatch_get_main_queue();
    dispatch_queue_t mainThreadQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self getLeaderBoardInfo];
        //[self.tableView reloadData];
    });
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadUserSettings];
    // Do any additional setup after loading the view.
    [self getLeaderBoardInfo];
//    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(reloadDatas) userInfo:nil repeats:YES];
//    dispatch_queue_t queue = dispatch_get_main_queue();
//    dispatch_async(queue, ^{
//        [self reloadDatas];
//    });
    
    // Do any additional setup after loading the view.
    self.title = @"Leader Board";
    
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:1.0f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    //self.countries = [[NSMutableArray alloc] init];
    
    //
	
//	NSArray *countriesInEurope = @[@"France",@"Spain",@"Germany",@"Great Britain", @"Italy", @"Portugal",@"Japan", @"China",@"India",@"Indonesia",@"Argentinia", @"Brasil",@"Chile"];
//    NSDictionary *europeCountriesDict = @{@"countries" : countriesInEurope};
//	[self.countries addObject:europeCountriesDict];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    //initializeArrays is the function that initializes the arrays
    //[self getLeaderBoardInfo];
    
    //[self.activityIndicatorView stopAnimating];
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	//NSDictionary *dictionary = self.countries[section];
	//NSArray *array = dictionary[@"countries"];
	return [uIDArray count];
}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//	return [self.countries count];
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"cellIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (!cell)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
	}
	
	//NSDictionary *dictionary = self.countries[indexPath.section];
	//NSArray *array = dictionary[@"countries"];
    
    
    NSString *namevalue = uNameArray[indexPath.row];
    //NSString *idvalue = uIDArray[indexPath.row];
    NSString *pointvalue = uPointArray[indexPath.row];
    //NSString *imgvalue = uImgArray[indexPath.row];
    
//  cell.textLabel.text = cellvalue;
    
    UILabel* nameLabel = (UILabel*)[cell viewWithTag:101];
    nameLabel.text = namevalue;
    UILabel* pointLabel = (UILabel*)[cell viewWithTag:102];
    pointLabel.text = pointvalue;
    
    // load IMAGE from url
    UIImageView *studentImageView = (UIImageView *)[cell viewWithTag:100];
    studentImageView.image = [UIImage imageNamed:@"Icon@2x.png"];
    NSLog(@"SINGLE IMAGE LINK = %@",[uImgArray objectAtIndex:indexPath.row]);
//    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [uImgArray objectAtIndex:indexPath.row]]];
//    studentImageView.image = [UIImage imageWithData: imageData];
    
    
    dispatch_async(kBgQueue, ^{
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[uImgArray objectAtIndex:indexPath.row]]]];
        if (imgData) {
            UIImage *image = [UIImage imageWithData:imgData];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    //recipeImageView.image = image;
                    
                    //UITableViewCell *updateCell = [self.tableView cellForItemAtIndexPath:indexPath];
                    
                    //if (updateCell) {
                        // Do any additional setup after loading the view.
                        studentImageView.layer.cornerRadius = studentImageView.frame.size.width / 2;
                        studentImageView.layer.borderWidth = 3.0f;
                        studentImageView.layer.borderColor = [UIColor whiteColor].CGColor;
                        studentImageView.clipsToBounds = YES;
                        studentImageView.image = image;
                        
                    //}
                });
            }
        }
    });

    // this is where you set your color view
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = [UIColor colorWithRed:180/255.0
                                                      green:138/255.0
                                                       blue:171/255.0
                                                      alpha:0.5];
    cell.selectedBackgroundView =  customColorView;
	
	return cell;
}

/*- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:
								 CGRectMake(0, 0, tableView.frame.size.width, 50.0)];
    sectionHeaderView.backgroundColor = [UIColor colorWithRed:61.0f/255.0f
                                                        green:33.0f/255.0f
                                                         blue:96.0f/255.0f
                                                        alpha:1.0f];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:
                            CGRectMake(3, 3, sectionHeaderView.frame.size.width, 25.0)];
    
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    [headerLabel setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]];
    [headerLabel setFont:[UIFont fontWithName:@"Verdana" size:14.0]];
    [sectionHeaderView addSubview:headerLabel];
    
    switch (section) {
        case 0:
            //NSString* points =  [NSString stringWithString:@"500"];
            headerLabel.text = [NSString stringWithFormat:@"Total Points %@ pts",myPoint];
            headerLabel.numberOfLines = 2;
            headerLabel.textAlignment = NSTextAlignmentCenter;
            headerLabel.lineBreakMode = NSLineBreakByWordWrapping;
            
            return sectionHeaderView;
            break;
        case 1:
            headerLabel.text = @"Asia";
            return sectionHeaderView;
            break;
        case 2:
            headerLabel.text = @"South America";
            return sectionHeaderView;
            break;
        default:
            break;
    }
    
    return sectionHeaderView;
}
 /*

/*- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
	UIImage *myImage = [UIImage imageNamed:@"gradient.png"];
	UIImageView *imageView = [[UIImageView alloc] initWithImage:myImage];
	imageView.frame = CGRectMake(10,10,1,30);
	
	return imageView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 30.0f;
}*/
/*
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 30.0f;
}
*/
/*
 - (void)viewDidAppear:(BOOL)animated {
 
 
 
 Reachability *internetReach = [Reachability reachabilityForInternetConnection];
	NetworkStatus netStatus = [internetReach currentReachabilityStatus];
 if (netStatus == NotReachable)
 {
 //net nai.
 
 
 messages = [ReadNWrite readFromDoucmentDirectory:@"Anouncement.plist"];
 // NSLog(@"messages== %@", [messages description]);
 
 UIAlertView *errorMessage=[[UIAlertView alloc] initWithTitle:@"..Announcement.." message:@"Internet connection required for announcement updates!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
 [errorMessage show];
 
	}
 else{
 // Net ache
 
 
 dispatch_async(kBgQueue, ^{
 NSData* data = [NSData dataWithContentsOfURL:
 kLatestKivaLoansURL];
 [self performSelectorOnMainThread:@selector(fetchedData:)
 withObject:data waitUntilDone:YES];
 });
 
 }
 
 }
 */

@end
