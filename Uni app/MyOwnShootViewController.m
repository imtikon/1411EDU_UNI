//
//  MyOwnShootViewController.m
//  Uni app
//
//  Created by Imtiaz Hossain on 1/29/15.
//  Copyright (c) 2015 Imtiaz Hossain. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

#import "MyOwnShootViewController.h"
#import "SWRevealViewController.h"
#import "AssetsLibrary/AssetsLibrary.h"
#import "Reachability.h"
#import <FacebookSDK/FacebookSDK.h>
#import <Social/Social.h>

@interface MyOwnShootViewController (){
    NSString* userCacheEmail;
}

@property NSString* filepath;
@property (strong, nonatomic) IBOutlet UITextField *captionField;
@property (strong, nonatomic) IBOutlet UIButton *uploadButton;
@property (strong, nonatomic) IBOutlet UIButton *shareobject;

@end

@implementation MyOwnShootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadUserSettings];
    // Do any additional setup after loading the view.
    // Do any additional setup after loading the view.
    self.title = @"Own Tradition Photo";
    
    self.traditionNameTextField.delegate = self;
    self.traditionNameTextField.tag = 0;
    
    self.eventNameTextField.delegate = self;
    self.eventNameTextField.tag = 1;
    
    //self.passwordTextField.delegate = self;
    //self.passwordTextField.tag = 2;
    
    
    // Change button color
    //_sidebarButton.tintColor = [UIColor colorWithWhite:1.0f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    //_sidebarButton.target = self.revealViewController;
    //_sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    //[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    //    UIView *statusBarView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 22)];
    //    statusBarView.backgroundColor  =  [UIColor yellowColor];
    //    [self.view addSubview:statusBarView];
    
    // --- photo shoot and upload related codes --- start ----
    //[_uploadButton setHidden:YES];
    _uploadButton.enabled = NO;
    //[_shareobject setHidden:YES];
    _shareobject.enabled = NO;
    imageOfThing = [[UIImage alloc]init];
    [self.captionLabel setFont:[UIFont fontWithName:@"TradeGothicNo.2-Bold" size:[self.captionLabel.font pointSize]]];
    self.uploadPhotoActivity.hidden = YES;
    self.captionLabel.textColor= [UIColor colorWithRed:255/255.0f green:255/255.0f blue:204/255.0f alpha:1.0f];
    self.captionField.textColor= [UIColor colorWithRed:255/255.0f green:255/255.0f blue:204/255.0f alpha:1.0f];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, self.captionField.frame.size.height)];
    self.captionField.leftView = leftView;
    self.captionField.leftViewMode = UITextFieldViewModeAlways;
    
    // change color : IOS 7 Navigation Bar text and arrow color
    // http://stackoverflow.com/questions/19029833/ios-7-navigation-bar-text-and-arrow-color
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //    [self.navigationController.navigationBar
    //     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    //    self.navigationController.navigationBar.translucent = NO;
}

-(IBAction)closePhotoWindow{
    [[self presentingViewController] dismissViewControllerAnimated:NO completion:nil];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - keyboard movements
- (void)keyboardWillShow:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = -100.0f;  //set the -35.0f to your required value
        self.view.frame = f;
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        self.view.frame = f;
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    switch (textField.tag) {
        case 0:
            /*if ([self NSStringIsValidEmail:self.traditionNameTextField.text]) {
                [textField resignFirstResponder];
            }else{
                [textField resignFirstResponder];
                self.eventNameTextField.text=@"";
                UIAlertView *emailAlertMessage=[[UIAlertView alloc]initWithTitle:@"Email!" message:@"Invalid Email Id. Please enter correct email id" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [emailAlertMessage show];
            }*/
            [textField resignFirstResponder];
            break;
        case 1:{
            [textField resignFirstResponder];
            break;
        }
        default:
            break;
    }
    return YES;
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
        }
    }];
    
    if(imageView.image!=nil)
    {
        //[_uploadButton setHidden:NO];
        _uploadButton.enabled = YES;
        //[_captionField setHidden:NO];
        _captionField.enabled = YES;
        NSLog(@"upload show");
    }
}

//uploaduserprofile
/*- (IBAction)uploadPhotoAction:(UIButton *)sender {
    
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
        self.captionField.enabled = NO;
        
        dispatch_async(kBgQueue, ^{
            dispatch_sync(dispatch_get_main_queue(), ^{
                NSLog(@"entrou na foto");
                self.view.userInteractionEnabled = NO;
                [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
            });
            
            NSData *imageData = UIImageJPEGRepresentation(imageOfThing, 1.0);
            // http://mobioapp.net/apps/gloriajeans/public/save_image_json
            NSURL *url = [NSURL URLWithString:@"http://4axiz.com/tradition/api_iphone/uploadProfilePic"];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:url];
            [request setHTTPMethod:@"POST"];
            
            NSString *boundary = @"*****";
            
            NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
            [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
            
            NSMutableData *body = [NSMutableData data];
            
            //AccessCode
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"machine_code\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@",@"emran4axiz"] dataUsingEncoding:NSUTF8StringEncoding]];
            
            //Email_address
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"email\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@",@"user211@uni.edu"] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"uploaded_file\"; filename=\%@\r\n",_filepath] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[NSData dataWithData:imageData]];
            
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSLog(@"----body====%@",body);
            
            [request setHTTPBody:body];
            
            NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            NSLog([NSString stringWithFormat:@"Image Return String: %@", returnString]);
            
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
                    _captionField.enabled = NO;
                    //[_shareobject setHidden:NO];
                    _shareobject.enabled = YES;
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Image"
                                                                    message:@"Successfully image uploaded."
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
}*/

//uploadUser_ownTradition
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
 self.captionField.enabled = NO;
 
 dispatch_async(kBgQueue, ^{
 dispatch_sync(dispatch_get_main_queue(), ^{
 NSLog(@"entrou na foto");
 self.view.userInteractionEnabled = NO;
 [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
 });
 
 NSData *imageData = UIImageJPEGRepresentation(imageOfThing, 1.0);
 NSURL *url = [NSURL URLWithString:@"http://4axiz.com/tradition/api_iphone/uploadUser_ownTradition"];
 
 NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
 [request setURL:url];
 [request setHTTPMethod:@"POST"];
 
 NSString *boundary = @"*****";
 
 NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
 [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
 
 NSMutableData *body = [NSMutableData data];
 
 //AccessCode
 [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"AccessCode\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithFormat:@"%@",@"emran4axiz"] dataUsingEncoding:NSUTF8StringEncoding]];
 
 //TraditionName
 [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"TraditionName\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithFormat:@"%@",self.traditionNameTextField.text] dataUsingEncoding:NSUTF8StringEncoding]];//@"1"
 
 //EventName
 [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"EventName\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithFormat:@"%@",self.eventNameTextField.text] dataUsingEncoding:NSUTF8StringEncoding]];
 
 //Email_address
 [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Email_address\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithFormat:@"%@",userCacheEmail] dataUsingEncoding:NSUTF8StringEncoding]];
 
 //description
 [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"description\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithFormat:@"%@",@"1 start filenot upload, but information update in database"] dataUsingEncoding:NSUTF8StringEncoding]];
 
 //coustomEventID
 [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"coustomEventID\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithFormat:@"%@",@"39"] dataUsingEncoding:NSUTF8StringEncoding]];
 
 //ifFileHave
 [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"ifFileHave\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithFormat:@"%@",@"0"] dataUsingEncoding:NSUTF8StringEncoding]];
 
 //SaveMode
 [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"SaveMode\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithFormat:@"%@",@"1"] dataUsingEncoding:NSUTF8StringEncoding]];
 
 //            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 //            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"caption\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
 //            [body appendData:[[NSString stringWithFormat:@"%@",_captionField.text] dataUsingEncoding:NSUTF8StringEncoding]];
 
 [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 
 [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"uploaded_file\"; filename=\%@\r\n",_filepath] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[NSData dataWithData:imageData]];
 
 [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 
 NSLog(@"----body====%@",body);
 
 [request setHTTPBody:body];
 
 NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
 NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
 NSLog([NSString stringWithFormat:@"Image Return String: %@", returnString]);
 
 NSError *error;
 NSDictionary* json = [NSJSONSerialization
 JSONObjectWithData:returnData //1
 options:0
 error:&error];
 NSLog(@"%@",[json objectForKey:@"message"]);
 
if ([returnString rangeOfString:@"success"].location == NSNotFound)
//if([json objectForKey:@"message"] isEqualToString:@"success")
 {
 [[UIApplication sharedApplication] endIgnoringInteractionEvents];
 self.view.userInteractionEnabled = YES;
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed"
 message:@"Custom Tradition is not uploaded."
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
 _captionField.enabled = NO;
 //[_shareobject setHidden:NO];
 _shareobject.enabled = YES;
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Custom Tradition"
 message:@"Successfully custom tradition uploaded."
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
     //[self->imageView setImage:@"iTunesArtwork.png"];
     self.eventNameTextField.text = @"";
     self.traditionNameTextField.text = @"";
 }
 });
 }
}

// Upload Tradition Event Photo
/*
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
 self.captionField.enabled = NO;
 
 dispatch_async(kBgQueue, ^{
 dispatch_sync(dispatch_get_main_queue(), ^{
 NSLog(@"entrou na foto");
 self.view.userInteractionEnabled = NO;
 [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
 });
 
 NSData *imageData = UIImageJPEGRepresentation(imageOfThing, 1.0);
 // http://mobioapp.net/apps/gloriajeans/public/save_image_json
 NSURL *url = [NSURL URLWithString:@"http://4axiz.com/tradition/api_iphone/uploadEventPhoto"];
 
 NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
 [request setURL:url];
 [request setHTTPMethod:@"POST"];
 
 NSString *boundary = @"*****";
 
 NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
 [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
 
 NSMutableData *body = [NSMutableData data];
 
 //AccessCode
 [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"AccessCode\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithFormat:@"%@",@"emran4axiz"] dataUsingEncoding:NSUTF8StringEncoding]];
 
 //Tradition_ID
 [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Tradition_ID\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithFormat:@"%@",@"1"] dataUsingEncoding:NSUTF8StringEncoding]];
 
 //Event_ID
 [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Event_ID\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithFormat:@"%@",@"3"] dataUsingEncoding:NSUTF8StringEncoding]];
 
 //Email_Address
 [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Email_Address\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithFormat:@"%@",@"user211@uni.edu"] dataUsingEncoding:NSUTF8StringEncoding]];
 
 //SaveMode
 [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"SaveMode\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithFormat:@"%@",@"1"] dataUsingEncoding:NSUTF8StringEncoding]];
 
 //            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 //            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"caption\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
 //            [body appendData:[[NSString stringWithFormat:@"%@",_captionField.text] dataUsingEncoding:NSUTF8StringEncoding]];
 
 [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 
 [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"uploaded_file\"; filename=\%@\r\n",_filepath] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[NSData dataWithData:imageData]];
 
 [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 
 NSLog(@"----body====%@",body);
 
 [request setHTTPBody:body];
 
 NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
 NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
 NSLog([NSString stringWithFormat:@"Image Return String: %@", returnString]);
 
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
 _captionField.enabled = NO;
 //[_shareobject setHidden:NO];
 _shareobject.enabled = YES;
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Image"
 message:@"Successfully image uploaded."
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
 });
 }
 
 
 
 
 
 // --------------- workable code -----------------
 //    Reachability *internetReach = [Reachability reachabilityForInternetConnection];
 //    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
 //    if (netStatus == NotReachable)
 //    {
 //        //net nai.
 //        UIAlertView *alertMessage=[[UIAlertView alloc]initWithTitle:@"Failed!" message:@"Internet connection required to upload your image!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
 //        alertMessage.tag = 30;
 //        [alertMessage show];
 //
 //    }else{
 //        // Net ache
 //        NSLog(@"Net ache");
 //        self.uploadPhotoActivity.hidden = NO;
 //        [self.uploadPhotoActivity startAnimating];
 //        self.takePhotoButton.enabled = NO;
 //        self.uploadButton.enabled = NO;
 //        self.captionField.enabled = NO;
 //
 //        dispatch_async(kBgQueue, ^{
 //            dispatch_sync(dispatch_get_main_queue(), ^{
 //                NSLog(@"entrou na foto");
 //                self.view.userInteractionEnabled = NO;
 //                [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
 //            });
 //
 //            NSData *imageData = UIImageJPEGRepresentation(imageOfThing, 1.0);
 //            NSURL *url = [NSURL URLWithString:@"http://mobioapp.net/apps/gloriajeans/public/save_image_json"];
 //
 //            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
 //            [request setURL:url];
 //            [request setHTTPMethod:@"POST"];
 //
 //            NSString *boundary = @"*****";
 //
 //            NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
 //            [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
 //
 //            NSMutableData *body = [NSMutableData data];
 //
 //            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 //            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"caption\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
 //            [body appendData:[[NSString stringWithFormat:@"%@",_captionField.text] dataUsingEncoding:NSUTF8StringEncoding]];
 //
 //            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 //
 //            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file_name\"; filename=\%@\r\n",_filepath] dataUsingEncoding:NSUTF8StringEncoding]];
 //            [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
 //            [body appendData:[NSData dataWithData:imageData]];
 //
 //            [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
 //
 //            [request setHTTPBody:body];
 //
 //            NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
 //            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
 //
 //
 //
 //            NSLog([NSString stringWithFormat:@"Image Return String: %@", returnString]);
 //
 //            if ([returnString rangeOfString:@"success"].location == NSNotFound)
 //            {
 //                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
 //                self.view.userInteractionEnabled = YES;
 //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed"
 //                                                                message:@"Image is not uploaded."
 //                                                               delegate:self
 //                                                      cancelButtonTitle:@"OK"
 //                                                      otherButtonTitles: nil];
 //                alert.tag = 10;
 //                [alert show];
 //                //[_shareobject setHidden:YES];
 //                _shareobject.enabled = NO;
 //                self.uploadPhotoActivity.hidden = YES;
 //                [self.uploadPhotoActivity stopAnimating];
 //                self.takePhotoButton.enabled = YES;
 //                self.uploadButton.enabled = YES;
 //            }else{
 //                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
 //                self.view.userInteractionEnabled = YES;
 //                //[_uploadButton setHidden:YES];
 //                //  _uploadButton.enabled = NO;
 //                //[_captionField setHidden:YES];
 //                _captionField.enabled = NO;
 //                //[_shareobject setHidden:NO];
 //                _shareobject.enabled = YES;
 //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Image"
 //                                                                message:@"Successfully image uploaded."
 //                                                               delegate:self
 //                                                      cancelButtonTitle:@"OK"
 //                                                      otherButtonTitles: nil];
 //                alert.tag = 20;
 //                [alert show];
 //                //   imageView.image= [UIImage imageNamed:@"ipad_defaultPicture.png"];
 //                self.uploadPhotoActivity.hidden = YES;
 //                [self.uploadPhotoActivity stopAnimating];
 //
 //                self.takePhotoButton.enabled = YES;
 //                self.uploadButton.enabled = NO;
 //            }
 //        });
 //    }
 }
 */

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex   {
    if(alertView.tag == 10 || alertView.tag == 20 || alertView.tag == 30){
        if(buttonIndex == 0)//OK button pressed
        {
            self.view.userInteractionEnabled = YES;
            
        }
        else if(buttonIndex == 1)//Annul button pressed.
        {
            //do something
        }
    }
}

- (IBAction)shareLinkWithShareDialog:(id)sender
{
    
    Reachability *internetReach = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
    if (netStatus == NotReachable)
    {
        //net nai.
        UIAlertView *emailAlertMessage=[[UIAlertView alloc]initWithTitle:@"Failed!" message:@"Please activate net to see update gallery view." delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [emailAlertMessage show];
    }else{
        [self.uploadPhotoActivity setHidden:NO];
        [self.uploadPhotoActivity startAnimating];
        NSLog(@"SLServiceTypeFacebook");
        SLComposeViewController *fbSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [fbSheet addImage:imageOfThing];
        [fbSheet addURL:[NSURL URLWithString:@"https://www.facebook.com/gloriajeansjcoffeesbangladesh"]];
        [self presentViewController:fbSheet animated:YES completion:nil];
        [self.uploadPhotoActivity setHidden:YES];
        [self.uploadPhotoActivity stopAnimating];
        
        [fbSheet setCompletionHandler:^(SLComposeViewControllerResult result){
            NSString *outout = [[NSString alloc] init];
            
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    outout = @"Post canceled";
                    break;
                case SLComposeViewControllerResultDone:
                {
                    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                        
                        imageView.image=[UIImage imageNamed:@"defaultpicture.jpg"];
                        imageOfThing=imageView.image;
                        
                    }else{
                        imageView.image=[UIImage imageNamed:@"defaultpicture.jpg"];
                        imageOfThing=imageView.image;
                        
                    }
                    self.takePhotoButton.enabled = YES;
                    self.uploadButton.enabled = NO;
                    self.shareobject.enabled=NO;
                    self.captionField.text=@"";
                    outout = @"Successfully Shared";
                    UIAlertView *myalertView = [[UIAlertView alloc]initWithTitle:@"FaceBook"
                                                                         message:outout delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [myalertView show];
                    
                }
                default:
                    break;
            }
        }];
    }
}

//------------------------------------

- (IBAction)postStatusUpdateWithShareDialog:(id)sender
{
    
    // Check if the Facebook app is installed and we can present the share dialog
    FBLinkShareParams *params = [[FBLinkShareParams alloc] init];
    params.link = [NSURL URLWithString:@"https://developers.facebook.com/docs/ios/share/"];
    // If the Facebook app is installed and we can present the share dialog
    if ([FBDialogs canPresentShareDialogWithParams:params]) {
        
        // Present share dialog
        [FBDialogs presentShareDialogWithLink:nil
                                      handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                          if(error) {
                                              // An error occurred, we need to handle the error
                                              // See: https://developers.facebook.com/docs/ios/errors
                                              NSLog(@"Error publishing story: %@", error.description);
                                          } else {
                                              // Success
                                              NSLog(@"result %@", results);
                                          }
                                      }];
        
        // If the Facebook app is NOT installed and we can't present the share dialog
    } else {
        // FALLBACK: publish just a link using the Feed dialog
        // Show the feed dialog
        [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                               parameters:nil
                                                  handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                      if (error) {
                                                          // An error occurred, we need to handle the error
                                                          // See: https://developers.facebook.com/docs/ios/errors
                                                          NSLog(@"Error publishing story: %@", error.description);
                                                      } else {
                                                          if (result == FBWebDialogResultDialogNotCompleted) {
                                                              // User cancelled.
                                                              NSLog(@"User cancelled.");
                                                          } else {
                                                              // Handle the publish feed callback
                                                              NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                                                              
                                                              if (![urlParams valueForKey:@"post_id"]) {
                                                                  // User cancelled.
                                                                  NSLog(@"User cancelled.");
                                                                  
                                                              } else {
                                                                  // User clicked the Share button
                                                                  NSString *result = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
                                                                  NSLog(@"result %@", result);
                                                              }
                                                          }
                                                      }
                                                  }];
    }
}


//------------------------------------

// A function for parsing URL parameters returned by the Feed Dialog.


- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}


#pragma mark - Twitter Share

- (IBAction)postToTwitter:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"Here will goes your tweet ..."];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
}

@end