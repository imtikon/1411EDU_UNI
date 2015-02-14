//
//  MyProfileViewController.m
//  Uni app
//
//  Created by Imtiaz Hossain on 1/16/15.
//  Copyright (c) 2015 Imtiaz Hossain. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

#import "MyProfileViewController.h"
#import "DetailProfilePhotoViewController.h"
#import "SWRevealViewController.h"
#import "AssetsLibrary/AssetsLibrary.h"
#import "Reachability.h"
#import <FacebookSDK/FacebookSDK.h>
#import <Social/Social.h>

@interface MyProfileViewController (){
    
    NSString *data;
    NSString* userCacheEmail;
    
    // this is used for sague passing
    NSMutableArray* myArray;
    NSMutableArray* tIDArray;
    NSMutableArray* eIDArray;
    NSMutableArray* ePublicArray;
    NSMutableArray* uApprovedArray;
    NSMutableArray* eImgArray;
    NSMutableArray* ePointsArray;
    
    NSString* userInfo;
    NSString* eventInfo;
    NSString* userName;
    
    NSString* profileName;
    NSString* profileDescription;
    NSString* profileImage;
    NSString* profileId;
    
}

// used for photo upload
@property NSString* filepath;
@property (strong, nonatomic) IBOutlet UIButton *uploadButton;
@property (strong, nonatomic) IBOutlet UIButton *shareobject;

@end

@implementation MyProfileViewController

/*-(void)saveUserSettings{
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
}*/

-(void) loadUserDefaultsData{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    userCacheEmail = [prefs stringForKey:@"email"];
    NSLog(@"userCacheEmail = %@",userCacheEmail);
}

-(void)getUserInfo{
    
    NSString*ACCESS_KEY=@"emran4axiz";
    NSString*EMAIL_ID=userCacheEmail;
    
    NSString *post =[[NSString alloc] initWithFormat:@"ACCESS_KEY=%@&EMAIL_ID=%@",ACCESS_KEY,EMAIL_ID];
    NSURL *url=[NSURL URLWithString:@"http://4axiz.com/tradition/api_iphone/getUserInfo?"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    //NSLog([NSString stringWithFormat:@"Image Return String: %@", returnString]);
    NSError *error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:returnData //1
                          options:0
                          error:&error];
    if([json count]>0){
        userName = [[json valueForKey:@"userinfo"] valueForKey:@"U_NAME"];
        NSLog(@"U_NAME = %@",userName);
        NSString* userId = [[json valueForKey:@"userinfo"] valueForKey:@"U_ID"];
        NSLog(@"U_ID = %@",userId);
        NSString* userSemester = [[json valueForKey:@"userinfo"] valueForKey:@"U_SEMESTER"];
        NSLog(@"U_SEMESTER = %@",userSemester);
        NSString* userImageUrl = [[json valueForKey:@"userinfo"] valueForKey:@"U_IMAGE_URL"];
        NSLog(@"U_IMAGE_URL = %@",userImageUrl);
    }
}

-(void)userInfoGet{
    
    NSString*ACCESS_KEY=@"emran4axiz";
    NSString*EMAIL_ID=userCacheEmail;
    
    NSString *post =[[NSString alloc] initWithFormat:@"ACCESS_KEY=%@&EMAIL_ID=%@",ACCESS_KEY,EMAIL_ID];
    //NSLog(post);
    NSURL *url=[NSURL URLWithString:@"http://4axiz.com/tradition/api_iphone/getUserInfo?"];//ACCESS_KEY=emran4axiz&EMAIL_ID=user5@uni.edu
    
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
    
    NSString* userInformation =[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    NSLog(@"---eventInfo----%@",userInformation);
    NSData* data = [userInformation dataUsingEncoding:NSUTF8StringEncoding];
    
    // this is used for dynamic array creation
    myArray = [NSMutableArray array];
    //int counter = 0;
    
    NSArray *jsonArray = (NSArray *)[NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];//nil
    NSLog(@"FINAL ARRAY = %@",[jsonArray valueForKey:@"userinfo"]);
    for(NSDictionary *dic in [jsonArray valueForKey:@"userinfo"]){
        NSString *tID = (NSString*) [dic valueForKey:@"U_ID"];
        NSLog(@"U_ID = %@",tID);
        profileDescription = (NSString*) [dic valueForKey:@"U_SEMESTER"];
        NSLog(@"U_SEMESTER = %@",profileDescription);
        profileName = (NSString*) [dic valueForKey:@"U_NAME"];
        NSLog(@"U_NAME = %@",profileName);
        profileImage = (NSString*) [dic valueForKey:@"U_IMAGE_URL"];
        NSLog(@"U_IMAGE_URL = %@",profileImage);
        NSString *tSubject = (NSString*) [dic valueForKey:@"U_SUBJECT"];
        NSLog(@"U_SUBJECT = %@",tSubject);
        NSString *tVerified = (NSString*) [dic valueForKey:@"U_VERIFIED"];
        NSLog(@"U_VERIFIED = %@",tVerified);
    }
    
    // load image into uiimage from remote server
    id profilePath = profileImage;
    NSURL *profileUrl = [NSURL URLWithString:profilePath];
    NSData *dataUrl = [NSData dataWithContentsOfURL:profileUrl];
    UIImage *img = [[UIImage alloc] initWithData:dataUrl];
    
    NSLog(@"userName = %@",userName);
    self.profileImageView.image = img;
    self.myName.text = profileName;//@"  Karen Keeton"
    self.myBio.text = profileDescription;//@"  I am a Student."
    
    /*for (NSDictionary *dic in jsonArray){
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
     }
     NSLog(@"FINAL ARRAY = %@",myArray);*/
}

-(void)getEventInfo{
    
    NSString*ACCESS_KEY=@"emran4axiz";
    NSString*EMAIL_ID=userCacheEmail;
    //http://4axiz.com/tradition/api_iphone/getTraditionByUser
    NSString *post =[[NSString alloc] initWithFormat:@"ACCESS_KEY=%@&Email_Address=%@",ACCESS_KEY,EMAIL_ID];
    //NSString *post =[[NSString alloc] initWithFormat:@"ACCESS_KEY=%@&EMAIL_ID=%@",ACCESS_KEY,EMAIL_ID];
    //NSLog(post);
    //NSURL *url=[NSURL URLWithString:@"http://4axiz.com/tradition/api/Tradition/getTraditionInfo?ACCESS_KEY=emran4axiz"];
    NSURL *url=[NSURL URLWithString:@"http://4axiz.com/tradition/api_iphone/getTraditionByUser?"];//?ACCESS_KEY=emran4axiz&Email_Address=user211@uni.edu
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    //NSError *error;
    NSError *jsonError = nil;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&jsonError];
    
    eventInfo =[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    NSLog(@"---eventInfo 123----%@",eventInfo);
    NSData* data = [eventInfo dataUsingEncoding:NSUTF8StringEncoding];
    
    //traditioninfo
    // this is used for dynamic array creation
    myArray = [NSMutableArray array];
    tIDArray = [NSMutableArray array];
    eIDArray = [NSMutableArray array];
    ePublicArray = [NSMutableArray array];
    uApprovedArray = [NSMutableArray array];
    eImgArray = [NSMutableArray array];
    ePointsArray = [NSMutableArray array];
    
    int counter = 0;
    
    NSArray *jsonArray = (NSArray *)[NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];//nil
    for (NSDictionary *dic in [jsonArray valueForKey:@"traditioninfo"]){
        // Now you have dictionary get value for key
        //We are casting to NSString because we know it will return a string. do this for every property...
        NSString *traditionID = (NSString*) [dic valueForKey:@"TRADITION_ID"];
        NSLog(@"T_ID = %@",traditionID);
        NSString *eventID = (NSString*) [dic valueForKey:@"EVENT_ID"];
        NSLog(@"EVENT_ID = %@",eventID);
        NSString *isApproved = (NSString*) [dic valueForKey:@"IS_APPROVED"];
        NSLog(@"IS_APPROVED = %@",isApproved);
        NSString *isPublic = (NSString*) [dic valueForKey:@"IS_PUBLIC"];
        NSLog(@"IS_PUBLIC = %@",isPublic);
        NSString *uPoint = (NSString*) [dic valueForKey:@"POINTS"];
        NSLog(@"POINTS = %@",uPoint);
        NSString *evePhotoURL = (NSString*) [dic valueForKey:@"EVE_PHOTO"];
        NSLog(@"EVE_PHOTO = %@",evePhotoURL);
        
        counter++;
        NSLog(@"counter = %d",counter);
        [myArray addObject:[NSString stringWithFormat:@"%@", evePhotoURL]];
        [tIDArray addObject:[NSString stringWithFormat:@"%@", traditionID]];
        [eIDArray addObject:[NSString stringWithFormat:@"%@", eventID]];
        [ePublicArray addObject:[NSString stringWithFormat:@"%@", isPublic]];
        [uApprovedArray addObject:[NSString stringWithFormat:@"%@", isApproved]];
        [eImgArray addObject:[NSString stringWithFormat:@"%@", evePhotoURL]];
        [ePointsArray addObject:[NSString stringWithFormat:@"%@", uPoint]];
        
    }
    NSLog(@"FINAL ARRAY = %@",myArray);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //save settings
    //[self saveUserSettings];
    [self loadUserDefaultsData];
    
    NSLog(@"saved email = %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"email"]);
    self.title = @"My Profile";
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:1.0f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    //[self getUserInfo];
    [self userInfoGet];
    [self getEventInfo];
    
    // photo upload related code
    // --- photo shoot and upload related codes --- start ----
    //[_uploadButton setHidden:YES];
    _uploadButton.enabled = NO;
    //[_shareobject setHidden:YES];
    _shareobject.enabled = NO;
    imageOfThing = [[UIImage alloc]init];
    //[self.captionLabel setFont:[UIFont fontWithName:@"TradeGothicNo.2-Bold" size:[self.captionLabel.font pointSize]]];
    self.uploadPhotoActivity.hidden = YES;
    //self.captionLabel.textColor= [UIColor colorWithRed:255/255.0f green:255/255.0f blue:204/255.0f alpha:1.0f];
    //self.captionField.textColor= [UIColor colorWithRed:255/255.0f green:255/255.0f blue:204/255.0f alpha:1.0f];
    //UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, self.captionField.frame.size.height)];
    //self.captionField.leftView = leftView;
    //self.captionField.leftViewMode = UITextFieldViewModeAlways;
    
    
    _collection.delegate = self;
    _collection.dataSource = self;
}

-(void) viewDidAppear:(BOOL)animated
{
    self.uploadPhotoActivity.hidden = YES;
    if(imageView.image!=nil && [_shareobject isHidden]){
        //[_uploadButton setHidden:NO];
        _uploadButton.enabled = YES;
    }
    
    if([_uploadButton isHidden] && imageView.image!=nil){
        //[_shareobject setHidden:NO];
        _shareobject.enabled = YES;
    }else{
        //[_shareobject setHidden:YES];
        _shareobject.enabled = NO;
    }
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


#pragma mark - Image Capture & Upload Source
- (IBAction)takePhotoAction:(UIButton *)sender {
    NSLog(@"take photo");
    // Lazily allocate image picker controller
    if (!imagePickerController) {
        imagePickerController = [[UIImagePickerController alloc] init];
        // If our device has a camera, we want to take a picture, otherwise, we just pick from
        // photo library
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
        }else{
            [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
        // image picker needs a delegate so we can respond to its messages
        [imagePickerController setDelegate:self];
    }
    NSLog(@"complete image");
    // Place image picker on the screen
    [self presentModalViewController:imagePickerController animated:YES];
    
    
}


- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [imageView setImage:image];
    [picker dismissModalViewControllerAnimated:YES];
    //UIImage *image = [UIImage imageNamed:"someImage.png"];
    // UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    imageOfThing = image;
    NSLog(@"picked");
    //  UIImage *viewImage = YOUR UIIMAGE  // --- mine was made from drawing context
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    // Request to save the image to camera roll
    [library writeImageToSavedPhotosAlbum:[image CGImage] orientation:(ALAssetOrientation)[image imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error){
        if (error) {
            NSLog(@"error");
        } else {
            NSLog(@"url %@", assetURL);
            NSString *path = [assetURL absoluteString];
            NSArray *modelsAsArray = [path componentsSeparatedByString:@"?"];
            _filepath= [modelsAsArray objectAtIndex:0];
            NSLog(@"filepath= %@", _filepath);
            [self uploadPhotoAction:userCacheEmail];
        }
    }];
    
    if(imageView.image!=nil)
    {
        //[_uploadButton setHidden:NO];
        _uploadButton.enabled = YES;
        //[_captionField setHidden:NO];
        //_captionField.enabled = YES;
        NSLog(@"upload show");
    }
}

//uploaduserprofile
- (IBAction)uploadPhotoAction:(UIButton *)sender {
 
 NSLog(@"Upload photo");
 
 Reachability *internetReach = [Reachability reachabilityForInternetConnection];
 NetworkStatus netStatus = [internetReach currentReachabilityStatus];
 if (netStatus == NotReachable)
 {
 //net nai.
 UIAlertView *alertMessage=[[UIAlertView alloc]initWithTitle:@"Failed!" message:@"Internet connection required to upload your image!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
 alertMessage.tag = 30;
 [alertMessage show];
 
 }else{
 // Net ache
 NSLog(@"Net ache");
 self.uploadPhotoActivity.hidden = NO;
 [self.uploadPhotoActivity startAnimating];
 self.takePhotoButton.enabled = NO;
 self.uploadButton.enabled = NO;
 //self.captionField.enabled = NO;
 
 dispatch_async(kBgQueue, ^{
 dispatch_sync(dispatch_get_main_queue(), ^{
 NSLog(@"entrou na foto");
 self.view.userInteractionEnabled = NO;
 [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
 });
 
 NSData *imageData = UIImageJPEGRepresentation(imageOfThing, 1.0);
 NSURL *url = [NSURL URLWithString:@"http://4axiz.com/tradition/api_iphone/uploadProfilePic"];
 
 NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
 [request setURL:url];
 [request setHTTPMethod:@"POST"];
 
 NSString *boundary = @"*****";
 
 NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
 [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
 
 NSMutableData *body = [NSMutableData data];
     NSError* jsonError=nil;
 //AccessCode
 [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"machine_code\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithFormat:@"%@",@"emran4axiz"] dataUsingEncoding:NSUTF8StringEncoding]];
 
 //Email_address
 [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"email\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithFormat:@"%@",userCacheEmail] dataUsingEncoding:NSUTF8StringEncoding]];//@"user211@uni.edu"
 
 [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 
 [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"uploaded_file\"; filename=\%@\r\n",_filepath] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[NSData dataWithData:imageData]];
 
 [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 
 NSLog(@"----body====%@",body);
 
 [request setHTTPBody:body];
 
 NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
 NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
 //NSLog([NSString stringWithFormat:@"Image Return String: %@", returnString]);
 
 if([returnString isEqual:@""]){
 NSLog(@"===returnString----IS EMPTYYYYYYYYY.....");
 self.view.userInteractionEnabled = YES;
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed"
 message:@"Image is not uploaded."
 delegate:self
 cancelButtonTitle:@"OK"
 otherButtonTitles: nil];
 alert.tag = 10;
 [alert show];
 //[_shareobject setHidden:YES];
 _shareobject.enabled = NO;
 self.uploadPhotoActivity.hidden = YES;
 [self.uploadPhotoActivity stopAnimating];
 self.takePhotoButton.enabled = YES;
 self.uploadButton.enabled = YES;
 }else{
 NSLog(@"===returnString----%@",returnString);
 
 NSError *error;
 NSDictionary* json = [NSJSONSerialization
 JSONObjectWithData:returnData //1
 options:0
 error:&error];
 NSLog(@"%@",[json objectForKey:@"message"]);
 
 if ([returnString rangeOfString:@"success"].location == NSNotFound)
 {
 [[UIApplication sharedApplication] endIgnoringInteractionEvents];
 self.view.userInteractionEnabled = YES;
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed"
 message:@"Image is not uploaded."
 delegate:self
 cancelButtonTitle:@"OK"
 otherButtonTitles: nil];
 alert.tag = 10;
 [alert show];
 //[_shareobject setHidden:YES];
 _shareobject.enabled = NO;
 self.uploadPhotoActivity.hidden = YES;
 [self.uploadPhotoActivity stopAnimating];
 self.takePhotoButton.enabled = YES;
 self.uploadButton.enabled = YES;
 }else{
 [[UIApplication sharedApplication] endIgnoringInteractionEvents];
 self.view.userInteractionEnabled = YES;
 //[_uploadButton setHidden:YES];
 //  _uploadButton.enabled = NO;
 //[_captionField setHidden:YES];
 //_captionField.enabled = NO;
 //[_shareobject setHidden:NO];
 _shareobject.enabled = YES;
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Profile Image"
 message:@"Profile Image uploaded successfully."
 delegate:self
 cancelButtonTitle:@"OK"
 otherButtonTitles: nil];
 alert.tag = 20;
 [alert show];
 //   imageView.image= [UIImage imageNamed:@"ipad_defaultPicture.png"];
 self.uploadPhotoActivity.hidden = YES;
 [self.uploadPhotoActivity stopAnimating];
 self.takePhotoButton.enabled = YES;
 self.uploadButton.enabled = NO;
 }
 }
 
 
 });
 }
 }

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
    // Load the image with an GCD block executed in another thread
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    
    
    // check-mark image
    UIImageView *checkImageView = (UIImageView *)[cell viewWithTag:200];
    if([[uApprovedArray objectAtIndex:indexPath.row] isEqualToString:@"1"]){
        //checkImageView.image = [UIImage imageNamed:@"Icon@2x.png"];
        checkImageView.hidden = NO;
    }else{
        checkImageView.hidden = YES;
    }
    
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



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showTraditionalDetailPhoto"]) {
        
        NSLog(@"welcome....");
        
        NSArray *indexPaths = [_collection indexPathsForSelectedItems];
        NSLog(@"indexPathsForSelectedItems = %@",indexPaths);
        
        DetailProfilePhotoViewController *destViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
        
        NSLog(@"indexPath.row = %li",(long)indexPath.row);
        NSLog(@"indexPath.section = %li",(long)indexPath.section);
        //NSLog(@"traditionPhotos = %@",traditionPhotos[indexPath.row]);
        
        destViewController.traditionImageName = eImgArray[indexPath.row];
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
