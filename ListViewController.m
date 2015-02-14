//
//  ListViewController.m
//  Uni app
//
//  Created by Imtiaz Hossain on 11/28/14.
//  Copyright (c) 2014 Imtiaz Hossain. All rights reserved.
//

#import "ListViewController.h"
#import "SWRevealViewController.h"
#import "EventTraditionViewController.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface ListViewController (){
    
    NSString *data;
    NSString* userCacheEmail;
    
    // this is used for sague passing
    NSMutableArray* myArray;
    NSMutableArray* uIDArray;
    NSMutableArray* uNameArray;
    NSMutableArray* uDescriptionArray;
    NSMutableArray* uImgArray;
    
    NSString* userInfo;
    NSString* eventInfo;
    NSString* userName;
    
    NSString* profileName;
    NSString* profileDescription;
    NSString* profileImage;
    NSString* profileId;
    
}

@end

@implementation ListViewController

@synthesize tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


/*-(void)saveUserSettings{
    NSString*   emailValue;
    [[NSUserDefaults standardUserDefaults] setObject:emailValue forKey:@"email"];
}

-(void)loadUserSettings{
    NSString*   emailValue;
    emailValue = [[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
    if(emailValue == nil){
        userCacheEmail = @" ";
    }else{
        userCacheEmail = emailValue;
    }
}*/

-(void) loadUserDefaultsData{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    userCacheEmail = [prefs stringForKey:@"email"];
    NSLog(@"userCacheEmail = %@",userCacheEmail);
}

-(void)getTraditionInfo{
    [self loadUserDefaultsData];
    NSString*ACCESS_KEY=@"emran4axiz";
    NSString*EMAIL_ID=userCacheEmail;
    
    NSString *post =[[NSString alloc] initWithFormat:@"ACCESS_KEY=%@&EMAIL_ID=%@",ACCESS_KEY,EMAIL_ID];
    //NSLog(post);
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
    NSLog(@"---data----%@",data);
    
    // this is used for dynamic array creation
    myArray = [NSMutableArray array];
    uIDArray = [NSMutableArray array];
    uDescriptionArray = [NSMutableArray array];
    uNameArray = [NSMutableArray array];
    uImgArray = [NSMutableArray array];
    
    int counter = 0;
    
    NSArray *jsonArray = (NSArray *)[NSJSONSerialization JSONObjectWithData:data options:nil error:&jsonError];
    //NSLog(@"---data----%@",[jsonArray valueForKey:@"leaderboard"]);
    
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
        [uIDArray addObject:[NSString stringWithFormat:@"%@", tID]];
        [uNameArray addObject:[NSString stringWithFormat:@"%@", tName]];
        [uDescriptionArray addObject:[NSString stringWithFormat:@"%@", tDescription]];
        [uImgArray addObject:[NSString stringWithFormat:@"%@", tLogoURL]];
        
    }
    //NSLog(@"---data----%@",[[jsonArray valueForKey:@"leaderboard"] valueForKey:@"5"]);
    NSLog(@"FINAL ARRAY = %@",uIDArray);
    NSLog(@"FINAL ARRAY = %@",uNameArray);
    NSLog(@"FINAL ARRAY = %@",uDescriptionArray);
    NSLog(@"FINAL ARRAY = %@",uImgArray);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Do any additional setup after loading the view.
    self.title = @"List View";
    
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:1.0f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    [self getTraditionInfo];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
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
    NSString *idvalue = uIDArray[indexPath.row];
    NSString *pointvalue = uDescriptionArray[indexPath.row];
    NSString *imgvalue = uImgArray[indexPath.row];
    
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
                    
                    //NSLog(@"---img===%@",imgData);
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

/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSIndexPath *indexPaths = [self.tableView indexPathForSelectedRow];
    
    //self.cellSelected = indexPath;
    NSLog(@"la : %@", indexPaths);
    [self performSegueWithIdentifier:@"showEventList" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //if ([segue.identifier isEqualToString:@"showEventList"]) {//showMyTraditionPhoto
        NSLog(@"welcome....");
        NSLog(@"sender = %@",sender);
        
        //NSArray *indexPaths = [self.tableView indexPaths.row];
        //NSLog(@"indexPathsForSelectedItems = %@",indexPaths);
//
//        //DetailTraditionViewController *destViewController = segue.destinationViewController;
//        
//        EventTraditionViewController *destViewController = segue.destinationViewController;
//        NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
//
//        NSLog(@"indexPath.row = %li",(long)indexPath.row);
//        NSLog(@"indexPath.section = %li",(long)indexPath.section);
//        NSLog(@"traditionPhotos = %@",myArray[indexPath.row]);
//        
//        destViewController.traditionImageName = uImgArray[indexPath.row];
//        destViewController.traditionImageId = [NSString stringWithFormat:@"%lu", (long)indexPath.row];
//        destViewController.traditionDescription = uDescriptionArray[indexPath.row];
//        [self.tableView deselectItemAtIndexPath:indexPath animated:NO];
    //}
    
}*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showEventList"])
    {
        NSLog(@"image array = %@",uIDArray[7]);
        NSLog(@"welcome....");
        NSArray *indexPaths = [self.tableView indexPathForSelectedRow];
        //NSLog(@"selected rows = %@",indexPaths);
        //NSIndexPath *indexPath1 = [indexPaths objectAtIndex:0];
        //NSLog(@"selected rows = %@",indexPath1);
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSLog(@"selected row = %ld",(long)indexPath.row);
        NSInteger* t = (long)indexPath.row;
        NSLog(@"image array = %@",uImgArray[(long)indexPath.row]);
        EventTraditionViewController *destViewController = segue.destinationViewController;
        destViewController.traditionImageName = uImgArray[indexPath.row];
        destViewController.traditionImageId = [NSString stringWithFormat:@"%lu", (long)indexPath.row];
        
    }
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    if ([segue.identifier isEqualToString:@"showMyTraditionPhoto"]) {
//        NSLog(@"welcome....");
//        
//        NSArray *indexPaths = [tableView indexPath];
//        NSLog(@"indexPathsForSelectedItems = %@",indexPaths);
//        
//        DetailTraditionViewController *destViewController = segue.destinationViewController;
//        NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
//        
//        NSLog(@"indexPath.row = %li",(long)indexPath.row);
//        NSLog(@"indexPath.section = %li",(long)indexPath.section);
//        NSLog(@"traditionPhotos = %@",traditionPhotos[indexPath.row]);
//        
//        destViewController.traditionImageName = myArray[indexPath.row];
//        destViewController.traditionImageId = [NSString stringWithFormat:@"%lu", (long)indexPath.row];
//        [self.collection deselectItemAtIndexPath:indexPath animated:NO];
//    }
//    
//}

@end
