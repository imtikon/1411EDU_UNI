//
//  EventTraditionViewController.m
//  Uni app
//
//  Created by Imtiaz Hossain on 1/24/15.
//  Copyright (c) 2015 Imtiaz Hossain. All rights reserved.
//

#import "EventTraditionViewController.h"
#import "DetailTraditionViewController.h"
#import "EventPhotoViewController.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface EventTraditionViewController (){
    NSString* eventInfo;
    NSMutableArray *imageArray, *descriptionArray, *titleArray, *uIDArray, *dateArray, *venueArray, *tradArray, *eventArray;
    NSString* getId;
}
@end

@implementation EventTraditionViewController

@synthesize traditionImageName;
@synthesize traditionImageId;
@synthesize traditionDescription;
@synthesize myTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.traditionImageView.image = [UIImage imageNamed:self.traditionImageName];//traditionImageName;
    NSLog(@"traditionImageId = %@",traditionImageId);
    NSLog(@"traditionImageName = %@",traditionImageName);
    //self.traditionName.text = traditionImageName;
    
    [self getEventInfo];
    
    // change color : IOS 7 Navigation Bar text and arrow color
    // http://stackoverflow.com/questions/19029833/ios-7-navigation-bar-text-and-arrow-color
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //    [self.navigationController.navigationBar
    //     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    //    self.navigationController.navigationBar.translucent = NO;
    
}

/*-(void)reloadDatas
{
    //dispatch_queue_t concurrentQueue = dispatch_get_main_queue();
    dispatch_queue_t mainThreadQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self getEventInfo];
        //[self.tableView reloadData];
    });
}*/

-(void)getEventInfo{
    
    NSString* ACCESS_KEY=@"emran4axiz";
    NSString* TRADITION_ID=traditionImageId;
    
    NSString *post =[[NSString alloc] initWithFormat:@"ACCESS_KEY=%@&TRADITION_ID=%@",ACCESS_KEY,TRADITION_ID];
    NSURL *url=[NSURL URLWithString:@"http://4axiz.com/tradition/api_iphone/getEvent_ByTradiID"];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSError *error = nil;
    //NSError *jsonError = nil;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    eventInfo =[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    NSLog(@"---eventInfo----%@",eventInfo);
   // NSData* data = [eventInfo dataUsingEncoding:NSUTF8StringEncoding];
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
    for (NSDictionary *dic in [json objectForKey:@"eventinfo"]){
        NSString *tID = (NSString*) [dic valueForKey:@"T_ID"];
        NSString *eID = (NSString*) [dic valueForKey:@"E_ID"];
        //NSLog(@"E_ID = %@",tID);
        NSString *tDescription = (NSString*) [dic valueForKey:@"E_DESCRIPTION"];
        NSLog(@"E_DESCRIPTION = %@",tDescription);
        NSString *tName = (NSString*) [dic valueForKey:@"E_NAME"];
        //NSLog(@"E_NAME = %@",tName);
        NSString *tLogoURL = (NSString*) [dic valueForKey:@"E_LOGO_URL"];
        //NSLog(@"E_LOGO_URL = %@",tLogoURL);
        NSString *tVenue = (NSString*) [dic valueForKey:@"E_VENUE"];
        NSString *tDdate = (NSString*) [dic valueForKey:@"E_DATE_TIME"];
        
        counter++;
        //NSLog(@"counter = %d",counter);
        [uIDArray addObject:[NSString stringWithFormat:@"%@", eID]];
        [titleArray addObject:[NSString stringWithFormat:@"%@", tName]];
        [imageArray addObject:[NSString stringWithFormat:@"%@", tLogoURL]];
        [dateArray addObject:[NSString stringWithFormat:@"%@", tDdate]];
        [venueArray addObject:[NSString stringWithFormat:@"%@", tVenue]];
        [descriptionArray addObject:[NSString stringWithFormat:@"%@", tDescription]];
        [tradArray addObject:[NSString stringWithFormat:@"%@", tID]];
        [eventArray addObject:[NSString stringWithFormat:@"%@", eID]];
        
    }
    
    //NSLog(@"loans: %@", [latestLoans valueForKey:@"E_DESCRIPTION"]);
    
    //NSArray *jsonArray = (NSArray *)[NSJSONSerialization JSONObjectWithData:eventInfo options:nil error:&jsonError];
    
    
    /*
    for (NSDictionary *dic in [jsonArray objectAtIndex:@"eventinfo"]){
        // Now you have dictionary get value for key
        //We are casting to NSString because we know it will return a string. do this for every property...
        NSString *tID = (NSString*) [dic valueForKey:@"E_ID"];
        NSLog(@"E_ID = %@",tID);
        NSString *tDescription = (NSString*) [dic valueForKey:@"E_DESCRIPTION"];
        NSLog(@"E_DESCRIPTION = %@",tDescription);
        NSString *tName = (NSString*) [dic valueForKey:@"E_NAME"];
        NSLog(@"E_NAME = %@",tName);
        NSString *tLogoURL = (NSString*) [dic valueForKey:@"E_LOGO_URL"];
        NSLog(@"E_LOGO_URL = %@",tLogoURL);
        
        counter++;
        NSLog(@"counter = %d",counter);
        [myArray addObject:[NSString stringWithFormat:@"%@", tID]];
        [titleArray addObject:[NSString stringWithFormat:@"%@", tName]];
        [imageArray addObject:[NSString stringWithFormat:@"%@", tLogoURL]];
    }
    */
    NSLog(@"FINAL ARRAY = %@",descriptionArray);
    NSLog(@"FINAL ARRAY = %@",tradArray);
    NSLog(@"FINAL ARRAY = %@",eventArray);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    //NSDictionary *dictionary = self.countries[section];
    //NSArray *array = dictionary[@"countries"];
    return [titleArray count];
}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//	return [self.countries count];
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellEventIdentifier";
    
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
    /*customColorView.backgroundColor = [UIColor colorWithRed:180/255.0
                                                      green:138/255.0
                                                       blue:171/255.0
                                                      alpha:1.0];
    cell.selectedBackgroundView =  customColorView;
    //cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor colorWithRed:180/255.0
                                                       green:138/255.0
                                                        blue:171/255.0
                                                       alpha:0.5];
    cell.accessoryView.backgroundColor = [UIColor colorWithRed:180/255.0
                                                         green:138/255.0
                                                          blue:171/255.0
                                                         alpha:0.5];*/
    
    return cell;
}

// ------------------------------------------------------------------- **
// DELEGATE: UITableView
// ------------------------------------------------------------------- **
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    //NSLog(@"%s", __PRETTY_FUNCTION__);
//    [self performSegueWithIdentifier:@"photoScreen" sender:indexPath];
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"Row Selected = %li",(long)indexPath.row);
    NSString* selectedValue = [NSString stringWithFormat:@"%li",(long)indexPath.row];
    [self performSegueWithIdentifier:@"photoScreen" sender:selectedValue];
    
    //[self performSegueWithIdentifier:@"photoScreen" sender:self.view];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"photoScreen"]) {
        
        NSLog(@"Now ready to upload your challange photo");
        
        NSIndexPath *indexPath = [self.myTableView indexPathForSelectedRow];
        getId = uIDArray[indexPath.row];
        NSLog(@"getId = %@",getId);
        
        DetailTraditionViewController *destViewController = segue.destinationViewController;//EventPhotoViewController
        
        
        destViewController.traditionImageId = uIDArray[indexPath.row];
        destViewController.traditionImageName = imageArray[indexPath.row];
        destViewController.Event_ID = eventArray[indexPath.row];
        destViewController.Tradition_ID = tradArray[indexPath.row];
        destViewController.traditionDescription = descriptionArray[indexPath.row];
        destViewController.traditionName = titleArray[indexPath.row];
        
        
        //NSLog(@"Segue - %@",[group.productName stripHtml]);
        
    }
}





// ------------------------------------------------------------------- **
// SEGUE: ViewController_ONE > DetailViewController
// ------------------------------------------------------------------- **
/*- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //NSLog(@"%s", __PRETTY_FUNCTION__);
    //NSLog(@"sague sender=%@",uIDArray[(long)sender]);
    //NSInteger* cellRow = (long)sender;
    
    EventPhotoViewController *transferViewController = segue.destinationViewController;//EventPhotoViewController
    NSLog(@"prepareForSegue: %@", segue.identifier);
    if([segue.identifier isEqualToString:@"photoScreen"])
    {
        //transferViewController.traditionImageName = imageArray[0];
        //transferViewController.traditionImageId = uIDArray[0];//uIDArray[[(NSIndexPath *)sender row]];
        //transferViewController.traditionName = @"06/27/1984";
        //transferViewController.traditionImageCaption = @"Joe Hoffman";
    }

//    if([[segue identifier] isEqualToString:@"photoScreen"]) {
//        NSString* cellRow = sender;//[(NSIndexPath *)sender row];
//        DetailTraditionViewController *destinationController = segue.destinationViewController;
////        destViewController.traditionImageId = imageArray[sender];
////        destViewController.traditionImageId = [NSString stringWithFormat:@"%lu", (long)indexPath.row];
////        [self.collection deselectItemAtIndexPath:indexPath animated:NO];
//
//    }
}*/


//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//
//    if ([segue.identifier isEqualToString:@"photoScreen"]) {//showMyTraditionPhoto
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
