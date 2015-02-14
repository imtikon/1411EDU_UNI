//
//  MyOwnListViewController.m
//  Uni app
//
//  Created by Imtiaz Hossain on 1/29/15.
//  Copyright (c) 2015 Imtiaz Hossain. All rights reserved.
//

#import "MyOwnListViewController.h"
#import "SWRevealViewController.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface MyOwnListViewController (){
    NSString* eventInfo;
    NSMutableArray *imageArray, *descriptionArray, *titleArray, *uIDArray, *dateArray, *venueArray, *tradArray, *eventArray;
    NSString* getId;
    NSString* userCacheEmail;
}
@end

@implementation MyOwnListViewController

@synthesize traditionImageName;
@synthesize traditionImageId;
@synthesize myTableView;


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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUserSettings];
    // Do any additional setup after loading the view.
    self.title = @"Create My Own";

    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:1.0f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    // Do any additional setup after loading the view.
    //self.traditionImageView.image = [UIImage imageNamed:self.traditionImageName];//traditionImageName;
    //NSLog(@"traditionImageId = %@",traditionImageId);
    //NSLog(@"traditionImageName = %@",traditionImageName);
    //self.traditionName.text = traditionImageName;
    
    [self getMyOwnTraditionInfo];
}

-(void)getMyOwnTraditionInfo{
    
    NSString* ACCESS_KEY=@"emran4axiz";
    NSString* EMAIL_ADDRESS=userCacheEmail;
    
    NSString *post =[[NSString alloc] initWithFormat:@"ACCESS_KEY=%@&EMAIL_ID=%@",ACCESS_KEY,EMAIL_ADDRESS];
    NSURL *url=[NSURL URLWithString:@"http://4axiz.com/tradition/api_iphone/get_mytradition_info"];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    eventInfo =[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    NSLog(@"---eventInfo----%@",eventInfo);
    //NSData* data = [eventInfo dataUsingEncoding:NSUTF8StringEncoding];
    //NSLog(@"----data=== %@",data);
    
    // this is used for dynamic array creation
    descriptionArray = [NSMutableArray array];
    titleArray = [NSMutableArray array];
    imageArray = [NSMutableArray array];
    uIDArray = [NSMutableArray array];
    dateArray = [NSMutableArray array];
    venueArray = [NSMutableArray array];
    tradArray = [NSMutableArray array];
    eventArray = [NSMutableArray array];
    int counter = 0;
    
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:urlData
                                                         options:kNilOptions
                                                           error:&error];
    
    //NSArray* latestLoans = [json objectForKey:@"eventinfo"];
    for (NSDictionary *dic in [json objectForKey:@"traditioninfo"]){
        
        NSString* C_PBLK = (NSString*) [dic objectForKey:@"C_PBLK"];
        //if([C_PBLK isEqual:@"0"]){
        NSString *cID = (NSString*) [dic valueForKey:@"C_ID"];
        //NSLog(@"C_ID = %@",cID);
        NSString *uID = (NSString*) [dic valueForKey:@"U_ID"];
        //NSLog(@"U_ID = %@",uID);
        NSString *cTrdName = (NSString*) [dic valueForKey:@"C_TRD_NAME"];
        NSLog(@"C_TRD_NAME = %@",cTrdName);
        NSString *cEventName = (NSString*) [dic valueForKey:@"C_EVNT_NAME"];
        //NSLog(@"C_EVNT_NAME = %@",cEventName);
        NSString *cPhotoURL = (NSString*) [dic valueForKey:@"C_PHOTO"];
        //NSLog(@"C_PHOTO = %@",cPhotoURL);
        NSString *cDescription = (NSString*) [dic valueForKey:@"C_DESCRIP"];
        //NSLog(@"C_DESCRIP = %@",cDescription);
        NSString *cDTDdate = (NSString*) [dic valueForKey:@"C_DT"];
        //NSLog(@"C_DT = %@",cDTDdate);
        
        counter++;
        //}
        //NSLog(@"counter = %d",counter);
        [uIDArray addObject:[NSString stringWithFormat:@"%@", cID]];
        [titleArray addObject:[NSString stringWithFormat:@"%@", cEventName]];
        [imageArray addObject:[NSString stringWithFormat:@"%@", cPhotoURL]];
        [dateArray addObject:[NSString stringWithFormat:@"%@", cDTDdate]];
        [venueArray addObject:[NSString stringWithFormat:@"%@", cTrdName]];
        [descriptionArray addObject:[NSString stringWithFormat:@"%@", cDescription]];
        //[tradArray addObject:[NSString stringWithFormat:@"%@", tDescription]];
        [eventArray addObject:[NSString stringWithFormat:@"%@", uID]];
        
    }
    NSLog(@"titleArray FINAL ARRAY = %@",titleArray);
    NSLog(@"imageArray FINAL ARRAY = %@",imageArray);
    NSLog(@"venueArray FINAL ARRAY = %@",venueArray);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)closePhotoWindow{
    [[self presentingViewController] dismissViewControllerAnimated:NO completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"count %lu",(unsigned long)[titleArray count]);
    return [titleArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ownTraditionCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //NSDictionary *dictionary = self.countries[indexPath.section];
    //NSArray *array = dictionary[@"countries"];
    NSLog(@"---table-index====image===%@",imageArray);
    
    NSString *namevalue = titleArray[indexPath.row];
    //NSString *idvalue = uIDArray[indexPath.row];
    //NSString *pointvalue = uPointArray[indexPath.row];
    //NSString *imgvalue = imageArray[indexPath.row];
    
    //  cell.textLabel.text = cellvalue;
    
    UILabel* nameLabel = (UILabel*)[cell viewWithTag:101];
    nameLabel.text = namevalue;//[NSString stringWithFormat:@"%lu",indexPath.row];
    UILabel* dateTimeLabel = (UILabel*)[cell viewWithTag:102];
    dateTimeLabel.text = dateArray[indexPath.row];
    
    // load IMAGE from url
    UIImageView *studentImageView = (UIImageView *)[cell viewWithTag:100];
    studentImageView.image = [UIImage imageNamed:@"Icon@2x.png"];
    NSLog(@"SINGLE IMAGE LINK = %@",[imageArray objectAtIndex:indexPath.row]);
    //    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [uImgArray objectAtIndex:indexPath.row]]];
    //    studentImageView.image = [UIImage imageWithData: imageData];
    
    
    dispatch_async(kBgQueue, ^{
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[imageArray objectAtIndex:indexPath.row]]]];
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

// ------------------------------------------------------------------- **
// DELEGATE: UITableView
// ------------------------------------------------------------------- **
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"Row Selected = %li",(long)indexPath.row);
    NSString* selectedValue = [NSString stringWithFormat:@"%li",(long)indexPath.row];
    [self performSegueWithIdentifier:@"photoScreen" sender:selectedValue];

    //[self performSegueWithIdentifier:@"photoScreen" sender:self.view];
    
}

//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    if ([segue.identifier isEqualToString:@"photoScreen"]) {
//        
//        NSIndexPath *indexPath = [self.myTableView indexPathForSelectedRow];
//        getId = uIDArray[indexPath.row];
//        NSLog(@"getId = %@",getId);
//        
//        DetailTraditionViewController *destViewController = segue.destinationViewController;//EventPhotoViewController
//        
//        destViewController.traditionImageId = uIDArray[indexPath.row];
//        destViewController.traditionImageName = imageArray[indexPath.row];
//        destViewController.Event_ID = eventArray[indexPath.row];
//        destViewController.Tradition_ID = tradArray[indexPath.row];
//        destViewController.traditionDescription = descriptionArray[indexPath.row];
//        destViewController.traditionName = titleArray[indexPath.row];
//        //NSLog(@"Segue - %@",[group.productName stripHtml]);
//        
//    }
//}

@end
