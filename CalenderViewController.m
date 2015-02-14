//
//  CalenderViewController.m
//  Uni app
//
//  Created by Imtiaz Hossain on 11/28/14.
//  Copyright (c) 2014 Imtiaz Hossain. All rights reserved.
//

#import "CalenderViewController.h"
#import "SWRevealViewController.h"
#import "EventTraditionViewController.h"
#import "DetailTraditionViewController.h"
#import "Reachability.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface CalenderViewController (){
    
    NSString *data;
    NSString* userCacheEmail;
    
    // this is used for sague passing
    NSMutableArray* myArray;
    NSMutableArray* uIDArray;
    NSMutableArray* uNameArray;
    NSMutableArray* uDescriptionArray;
    NSMutableArray* uImgArray;
    NSMutableArray* eIDArray;
    NSMutableArray* eNameArray;
    NSMutableArray* eDateArray;
    
    NSString* getId;
    
    NSString* userInfo;
    NSString* eventInfo;
    NSString* userName;
    
    NSString* profileName;
    NSString* profileDescription;
    NSString* profileImage;
    NSString* profileId;
    
}
@end

@implementation CalenderViewController

@synthesize tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) loadUserDefaultsData{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    userCacheEmail = [prefs stringForKey:@"email"];
    NSLog(@"userCacheEmail = %@",userCacheEmail);
}

-(void)getTraditionInfo{
    
    //NSString*ACCESS_KEY=@"emran4axiz";
    NSString*EMAIL_ID=userCacheEmail;
    
    //NSString *post =[[NSString alloc] initWithFormat:@"ACCESS_KEY=%@&EMAIL_ID=%@",ACCESS_KEY,EMAIL_ID];
    NSString *post =[[NSString alloc] initWithFormat:@"&EMAIL_ID=%@",EMAIL_ID];
    //NSLog(post);
    NSURL *url=[NSURL URLWithString:@"http://4axiz.com/tradition/api_iphone/getEventInfo?ACCESS_KEY=emran4axiz"];//?ACCESS_KEY=emran4axiz
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
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
    eIDArray = [NSMutableArray array];
    uDescriptionArray = [NSMutableArray array];
    uNameArray = [NSMutableArray array];
    uImgArray = [NSMutableArray array];
    eNameArray = [NSMutableArray array];
    eDateArray = [NSMutableArray array];
    
    
    int counter = 0;
    
    NSArray *jsonArray = (NSArray *)[NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];//nil
    //NSLog(@"---data----%@",[jsonArray valueForKey:@"leaderboard"]);
    
    for (NSDictionary *dic in [jsonArray valueForKey:@"eventinfo"]){
        // Now you have dictionary get value for key
        //We are casting to NSString because we know it will return a string. do this for every property...
        //NSLog(@"",dic);
        NSString *tID = (NSString*) [dic valueForKey:@"T_ID"];
        //NSLog(@"T_ID = %@",tID);
        NSString *eID = (NSString*) [dic valueForKey:@"E_ID"];
        //NSLog(@"E_ID = %@",eID);
        NSString *tDescription = (NSString*) [dic valueForKey:@"E_DESCRIPTION"];
        //NSLog(@"T_DESCRIPTION = %@",tDescription);
        NSString *tName = (NSString*) [dic valueForKey:@"T_NAME"];
        //NSLog(@"T_NAME = %@",tName);
        NSString *eName = (NSString*) [dic valueForKey:@"E_NAME"];
        //NSLog(@"E_NAME = %@",eName);
        NSString *tLogoURL = (NSString*) [dic valueForKey:@"E_LOGO_URL"];
        //NSLog(@"E_LOGO_URL = %@",tLogoURL);
        NSString *eDateTime = (NSString*) [dic valueForKey:@"E_DATE_TIME"];
        //NSLog(@"E_DATE_TIME = %@",eDateTime);
        
        counter++;
        //NSLog(@"counter = %d",counter);
        [uIDArray addObject:[NSString stringWithFormat:@"%@", tID]];
        [eIDArray addObject:[NSString stringWithFormat:@"%@", eID]];
        [uNameArray addObject:[NSString stringWithFormat:@"%@", tName]];
        [uDescriptionArray addObject:[NSString stringWithFormat:@"%@", tDescription]];
        [uImgArray addObject:[NSString stringWithFormat:@"%@", tLogoURL]];
        [eDateArray addObject:[NSString stringWithFormat:@"%@", eDateTime]];
        [eNameArray addObject:[NSString stringWithFormat:@"%@", eName]];
        
    }
    //NSLog(@"---data----%@",[[jsonArray valueForKey:@"leaderboard"] valueForKey:@"5"]);
    NSLog(@"FINAL ARRAY = %@",uIDArray);
    NSLog(@"FINAL ARRAY = %@",eIDArray);
    NSLog(@"FINAL ARRAY = %@",eDateArray);
    NSLog(@"FINAL ARRAY = %@",uImgArray);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadUserDefaultsData];
    
    self.title = @"Calender View";
    
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
    NSLog(@"CALENDER CELL COUNT = %lu",(unsigned long)[uIDArray count]);
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
    //NSLog(@"--%ld--",(long)indexPath.row);
    
    NSString *namevalue = eNameArray[indexPath.row];
    //NSString *idvalue = uIDArray[indexPath.row];
    NSString *pointvalue = eDateArray[indexPath.row];
    //NSString *imgvalue = uImgArray[indexPath.row];
    NSString *eDesvalue = uDescriptionArray[indexPath.row];
    
//    NSLog(@"--namevalue: %@==",namevalue);
//    NSLog(@"--idvalue: %@==",idvalue);
//    NSLog(@"--pointvalue: %@==",pointvalue);
//    NSLog(@"--imgvalue: %@==",imgvalue);
//    NSLog(@"--eDesvalue: %@==",eDesvalue);
    
    //  cell.textLabel.text = cellvalue;
    
    UILabel* nameLabel = (UILabel*)[cell viewWithTag:101];
    nameLabel.text = namevalue;
    UILabel* pointLabel = (UILabel*)[cell viewWithTag:102];
    pointLabel.text = eDesvalue;
    UILabel* dateLabel = (UILabel*)[cell viewWithTag:103];
    dateLabel.text = pointvalue;
    
    // load IMAGE from url
    UIImageView *studentImageView = (UIImageView *)[cell viewWithTag:100];
    studentImageView.image = [UIImage imageNamed:@"Icon@2x.png"];
    //NSLog(@"SINGLE IMAGE LINK = %@",[uImgArray objectAtIndex:indexPath.row]);
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
    
//    // this is where you set your color view
//    UIView *customColorView = [[UIView alloc] init];
//    customColorView.backgroundColor = [UIColor colorWithRed:180/255.0
//                                                      green:138/255.0
//                                                       blue:171/255.0
//                                                      alpha:0.5];
//    cell.selectedBackgroundView =  customColorView;
    
    return cell;
}

// ** ------------------------------------------------------------------- **
// ** DELEGATE: UITableView
// ** ------------------------------------------------------------------- **
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Row Selected = %li",(long)indexPath.row);
    NSString* selectedValue = [NSString stringWithFormat:@"%li",(long)indexPath.row];
    [self performSegueWithIdentifier:@"photoScreen" sender:selectedValue];
    //[self performSegueWithIdentifier:@"photoScreen" sender:self.view];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"photoScreen"]) {
        NSLog(@"Now ready to upload your challange photo");
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        getId = uIDArray[indexPath.row];
        NSLog(@"getId = %@",getId);
        
        DetailTraditionViewController *destViewController = segue.destinationViewController;//EventPhotoViewController
        destViewController.traditionImageId = uIDArray[indexPath.row];
        destViewController.traditionImageName = uImgArray[indexPath.row];
        destViewController.Event_ID = eIDArray[indexPath.row];
        destViewController.Tradition_ID = uIDArray[indexPath.row];
        destViewController.traditionDescription = uDescriptionArray[indexPath.row];
        destViewController.traditionName = uNameArray[indexPath.row];
        //NSLog(@"Segue - %@",[group.productName stripHtml]);
    }
}

-(void)closePhotoWindow{
    [[self presentingViewController] dismissViewControllerAnimated:NO completion:nil];
}

/*- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showEventList"])
    {
        //NSLog(@"image array = %@",uIDArray[7]);
        //NSLog(@"welcome....");
        NSArray *indexPaths = [self.tableView indexPathForSelectedRow];
        //NSLog(@"selected rows = %@",indexPaths);
        //NSIndexPath *indexPath1 = [indexPaths objectAtIndex:0];
        //NSLog(@"selected rows = %@",indexPath1);
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //NSLog(@"selected row = %ld",(long)indexPath.row);
        NSInteger* t = (long)indexPath.row;
        //NSLog(@"image array = %@",uImgArray[(long)indexPath.row]);
        EventTraditionViewController *destViewController = segue.destinationViewController;
        destViewController.traditionImageName = uImgArray[indexPath.row];
        destViewController.traditionImageId = [NSString stringWithFormat:@"%lu", (long)indexPath.row];
    }
}*/

/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"addToCartSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    //NSLog(@"segue from deals screen");
    //NSLog(@"sender = %@",sender);
    //addToCartViewContollerForItem
    if([[segue identifier] isEqualToString:@"addToCartSegue"]){
//        NSIndexPath *selectedRow = [[self tableView] index.row];
//        
//        Item *currentItem = [[Item alloc]init];
//        currentItem = [itemList objectAtIndex:[selectedRow row]];
//        
//        RESTAddToCartViewController *vc = [segue destinationViewController];
//        [vc setCurrentItem:currentItem];
    }
}
*/
@end
