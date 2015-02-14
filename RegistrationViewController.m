//
//  RegistrationViewController.m
//  Uni app
//
//  Created by Imtiaz Hossain on 11/26/14.
//  Copyright (c) 2014 Imtiaz Hossain. All rights reserved.
//

#import "RegistrationViewController.h"
#import "Reachability.h"

@interface RegistrationViewController ()

//-(void) setCheckinPlist;
@property NSArray* graduationYearArray;

@end

@implementation RegistrationViewController

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
    _graduationYearArray = @[@"2000", @"2001", @"2002",@"2003",@"2004",@"2005",@"2006",@"2007",@"2008",@"2009",@"2010",@"2011",@"2012",@"2013",@"2014",@"2015"];
    
    //self.layerImage.layer.cornerRadius=5;
    //self.layerImage.clipsToBounds=YES;
    
    self.nameTextField.delegate = self;
    self.nameTextField.tag = 0;
    
    self.emailTextField.delegate = self;
    self.emailTextField.tag = 1;
    
    self.passwordTextField.delegate = self;
    self.passwordTextField.tag = 2;
    
    self.graduationTxt.delegate = self;
    self.graduationTxt.tag = 4;
    
    // set font
    [self.nameTextField setFont:[UIFont fontWithName:@"TradeGothicNo.2-Bold"  size:[self.nameTextField.font pointSize]]];
    [self.emailTextField setFont:[UIFont fontWithName:@"TradeGothicNo.2-Bold"  size:[self.emailTextField.font pointSize]]];
    [self.passwordTextField setFont:[UIFont fontWithName:@"TradeGothicNo.2-Bold"  size:[self.passwordTextField.font pointSize]]];
    [self.graduationTxt setFont:[UIFont fontWithName:@"TradeGothicNo.2-Bold"  size:[self.graduationTxt.font pointSize]]];
    
    //text color
    
    self.nameTextField.textColor= [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
    self.nameTextField.backgroundColor= [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
    self.emailTextField.textColor= [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
    self.emailTextField.backgroundColor= [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
    self.passwordTextField.textColor= [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
    self.passwordTextField.backgroundColor= [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
    self.graduationTxt.textColor= [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
    self.graduationTxt.backgroundColor= [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
    
}

#pragma mark - used for keyboard movements
- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - keyboard movements
- (void)keyboardWillShow:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = -130.0f;  //set the -35.0f to your required value
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

-(BOOL) NSStringIsValidEmail:(NSString *) checkString{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 0:
            NSLog(@"you clicked into username field.");
            //self.nameTextField.text = @" ";
            self.nameTextField.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
            //self.nameTextField.background= [UIImage imageNamed:@"row_1.png"];
            break;
        case 1:
            NSLog(@"you clicked into email field.");
            //self.emailTextField.text = @" ";
            self.emailTextField.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
            //[self hiddenDatePickerForDateofBirth];
            //[self hiddenAreaPickerForArea];
            //self.emailTextField.backgroundColor = [UIColor clearColor];
            break;
        case 2:{
            NSLog(@"you clicked into password field.");
            //self.passwordTextField.text = @" ";
            self.passwordTextField.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
            //[self hiddenDatePickerForDateofBirth];
            //[self hiddenAreaPickerForArea];
            //self.passwordTextField.backgroundColor = [UIColor clearColor];
            break;
        }
        case 4:{
            //[textField resignFirstResponder];
            NSLog(@"you clicked into graduation year field.");
            //self.graduationTxt.text = @" ";
            //self.graduationTxt.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
            //[self hiddenAreaPickerForArea];
            //self.dateOfBirthText.text=@"";
            //[self showDatePickerForDateofBirth];
            //self.dateOfBirthText.backgroundColor = [UIColor clearColor];
            break;
        }
        default:
            break;
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    switch (textField.tag) {
        case 0:
            NSLog(@"you released username field.");
//            if (![self.nameTextField.text isEqualToString:@""]) {
//                self.nameTextField.text = @"  Name";
//            }
            [textField resignFirstResponder];
            break;
        case 1:
            NSLog(@"you released email field.");
            if ([self NSStringIsValidEmail:self.emailTextField.text]) {
                [textField resignFirstResponder];
            }else{
                
                [textField resignFirstResponder];
                self.emailTextField.text=@"";
                UIAlertView *emailAlertMessage=[[UIAlertView alloc]initWithTitle:@"Email!" message:@"Invalid Email Id. Please enter correct email id" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [emailAlertMessage show];
            }
            [textField resignFirstResponder];
            break;
        case 2:{
            NSLog(@"you released password field.");
//            if (![self.passwordTextField.text isEqualToString:@""]) {
//                self.passwordTextField.text = @"  Password";
//            }
            [textField resignFirstResponder];
            break;
        }
        case 4:
            NSLog(@"you released graduation year field.");
//            if (![self.graduationTxt.text isEqualToString:@""]) {
//                //self.graduationTxt.text = @"  Graduation Year";
//            }
            [textField resignFirstResponder];
            break;
//        case 4:
//            [textField resignFirstResponder];
//            break;
        default:
            break;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 0:
            NSLog(@"you finished editing username field.");
//            if (![self.nameTextField.text isEqualToString:@""]) {
//                self.nameTextField.text = @"  Name";
//            }
            break;
        case 1:
            NSLog(@"you finished editing email field.");
//            if (![self.emailTextField.text isEqualToString:@""]) {
//                self.emailTextField.text = @"  Email@edu.org";
//            }
            break;
        case 2:{
            NSLog(@"you finished editing password field.");
//            if (![self.passwordTextField.text isEqualToString:@""]) {
//                self.passwordTextField.text = @"  Password";
//            }
            break;
        }
        case 4:{
            NSLog(@"you finished editing graduation year field.");
//            if (![self.graduationTxt.text isEqualToString:@""]) {
//                self.graduationTxt.text = @"  Graduation Year";
//            }
            break;
        }
//        case 4:
//            [textField resignFirstResponder];
//            break;
        default:
            break;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
    
//    if (![self.nameTextField.text isEqualToString:@""]) {
//        self.nameTextField.text = @"  Name";
//    }
    /*
    if (![self.emailTextField.text isEqualToString:@""]) {
        if ([self NSStringIsValidEmail:self.emailTextField.text]) {

        } else {
            self.emailTextField.text = @"  Email@uni.edu";
            UIAlertView *emailAlertMessage=[[UIAlertView alloc]initWithTitle:@"Email!" message:@"Invalid Email Id. Please enter correct email id" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [emailAlertMessage show];
        }
    }
     */
}

- (IBAction)signUpAction:(id)sender {
    
    Reachability *internetReach = [Reachability reachabilityForInternetConnection];
	NetworkStatus netStatus = [internetReach currentReachabilityStatus];
    if (netStatus == NotReachable)
    {
        //no connection of Internet
        UIAlertView *emailAlertMessage=[[UIAlertView alloc]initWithTitle:@"Failed!" message:@"Internet required to complete registration." delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [emailAlertMessage show];
	}
    else{
        // Net ache
        NSString *deviceID = @"1234";
        if ([self.emailTextField.text isEqualToString:@""]  ) {
            if ([self.emailTextField.text isEqualToString:@""]) {
                self.emailTextField.backgroundColor = [UIColor redColor];
                self.emailTextField.background= [UIImage imageNamed:@"emptyBG.png"];
            }
            
            if ([self.nameTextField.text isEqualToString:@""]) {
                self.nameTextField.backgroundColor = [UIColor redColor];
            }
            //
            if ([self.passwordTextField.text isEqualToString:@""]) {
                self.passwordTextField.backgroundColor = [UIColor redColor];
            }
            //
            if ([self.graduationTxt.text isEqualToString:@""]) {
                self.graduationTxt.backgroundColor = [UIColor redColor];
            }
            
            UIAlertView *errorMessage=[[UIAlertView alloc] initWithTitle:@"..Sign Up.." message:@"You have to enter required data." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorMessage show];
            
        } else {
            //http://4axiz.com/tradition/uni_tradition/for_android/php_files/user_registration.php
            //NSURL *url = [NSURL URLWithString:@"http://imtikon.com/apps/uni/register.php"];
            //NSURL *url = [NSURL URLWithString:@"http://4axiz.com/tradition/api_iphone/user_registration"];
            NSURL *url = [NSURL URLWithString:@"http://4axiz.com/tradition/uni_tradition/for_android/php_files/user_registration.php"];
            
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:url];
            [request setHTTPMethod:@"POST"];
            NSString *boundary = [NSString stringWithString:@"*****"];
            NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
            [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
            NSMutableData *body = [NSMutableData data];
            
            //machine_code = emran4axiz
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"machine_code\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@",@"emran4axiz"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"name\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@",self.nameTextField.text] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"email\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@",self.emailTextField.text] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"semester\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@",self.graduationTxt.text] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"password\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@",self.passwordTextField.text] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
//            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"date_of_birth\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//            [body appendData:[[NSString stringWithFormat:@"%@",self.dateOfBirthText.text] dataUsingEncoding:NSUTF8StringEncoding]];
//            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
//            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"graduationyr\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//            [body appendData:[[NSString stringWithFormat:@"%@",self.graduationPicker] dataUsingEncoding:NSUTF8StringEncoding]];
//            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            //    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file_name\"; filename=\%@\r\n",_filepath] dataUsingEncoding:NSUTF8StringEncoding]];
            //    [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            //    [body appendData:[NSData dataWithData:imageData]];
            //    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [request setHTTPBody:body];
            NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            NSLog([NSString stringWithFormat:@"Image Return String: %@", returnString]);
            
            if([returnString  isEqual: @"success"]){
                [self redirectToLogin];
            }
            
            /*
            NSError *error;
            NSDictionary* json = [NSJSONSerialization
                                  JSONObjectWithData:returnData //1
                                  options:kNilOptions
                                  error:&error];
            //            if ([returnString rangeOfString:@"success"].location == NSNotFound || [returnString rangeOfString:@"exists"].location == NSNotFound)
            //            {
            NSLog(@"---json--- = %@",json);
            if([[json objectForKey:@"message"] isEqualToString:@"success"] || [[json objectForKey:@"message"] isEqualToString:@"exists"])
            {
                NSLog(@"success---");
                UIAlertView *errorMessage=[[UIAlertView alloc] initWithTitle:@"Register" message:@"Successfully Registered." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [errorMessage show];
                
                if([self writeIntoPlist:json]){
                    [self redirectToLogin];
                }
                NSError *error = nil;
                id jsonObject = [NSJSONSerialization
                                 JSONObjectWithData:returnData
                                 options:NSJSONWritingPrettyPrinted error:&error];
                NSDictionary *deserializedDictionary = nil;
                if (jsonObject != nil && error == nil)
                {
                    if ([jsonObject isKindOfClass:[NSDictionary class]]){
                        //Convert the NSData to NSDictionary in this final step
                        deserializedDictionary = (NSDictionary *)jsonObject;
                        //NSLog(@"deserializedDictionary== %@",deserializedDictionary);
                        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                        NSString *documentsDirectory = [paths objectAtIndex:0];
                        
                        NSString *dataFilePath = [documentsDirectory stringByAppendingPathComponent:@"SignUp.plist"];
                        [deserializedDictionary writeToFile:dataFilePath atomically:YES];
                        NSArray *pathsRead = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                        NSString *documentsDirectoryRead = [pathsRead objectAtIndex:0];
                        NSString *dataFilePathRead = [documentsDirectoryRead stringByAppendingPathComponent:@"SignUp.plist"];
                        NSDictionary *peoplesList = [[NSDictionary alloc] initWithContentsOfFile:dataFilePathRead];
                        NSLog(@"After Registration Read the Plist = %@",peoplesList);
                        //[self setCheckinPlist ];
                    }
                }
                
                //                if([[json objectForKey:@"message"] isEqualToString:@"exists"])
                //                {
                //                    NSLog(@"exist");
                //
                //
                //                    UIAlertView *errorMessage=[[UIAlertView alloc] initWithTitle:@"..Register.." message:@"Already Registered." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                //                    [errorMessage show];
                //
                //                    //      [self setCheckinPlist ];
                //
                //                }else
                //                {
                 
                //}
                
            }else if([[json objectForKey:@"message"] isEqualToString:@"blank"]){
                NSLog(@"exist");
                UIAlertView *errorMessage=[[UIAlertView alloc] initWithTitle:@"..Register.." message:@"Please enter your email address." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [errorMessage show];
            }else{
                NSLog(@"no success");
                UIAlertView *errorMessage=[[UIAlertView alloc] initWithTitle:@"..Register.." message:@"Not Registered." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [errorMessage show];
            }
        */
        }
    }
}

-(void)redirectToLogin{
    NSString * storyboardName = @"Main_iPhone";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"Login"];
    [self presentViewController:vc animated:YES completion:nil];
}

-(BOOL)writeIntoPlist:loadData{
    NSLog(@"Loading Data = %@",loadData);
    NSError* error;
    // 1) Create a list of paths.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    // 2) Get a path to your documents directory from the list.
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    // 3) Create a full file path.
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"user.plist"]; //3
    // Load File-Manager
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 4) Check if file exists.
    if (![fileManager fileExistsAtPath: path]) //4
    {
        // 5) Get a path to your plist created before in bundle directory (by Xcode).
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"]; //5
        // 6) Copy this plist to your documents directory.
        [fileManager copyItemAtPath:bundle toPath: path error:&error]; //6
    }
    
    // --- next read data from plist ---
    // get the path to our Data/plist file
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"user.plist"];
    NSLog(@"Before write into Plist = %@",plistPath);
    // set the variables to the values in the text fields
    NSString* userId = [[loadData objectForKey:@"UserInfo"] objectForKey:@"id"];
    NSString* userName = [[loadData objectForKey:@"UserInfo"] objectForKey:@"name"];
    NSString* userEmail = [[loadData objectForKey:@"UserInfo"] objectForKey:@"email"];
    NSString* userPic = [[loadData objectForKey:@"UserInfo"] objectForKey:@"pic"];
    
    // create dictionary with values in UITextFields
    NSDictionary *plistDict = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: userId, userName, userEmail, userPic, nil] forKeys:[NSArray arrayWithObjects: @"UserId", @"UserName", @"UserEmail", @"UserPic", nil]];
    // create NSData from dictionary
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];
    // check is plistData exists
    if(plistData)
    {
        // write plistData to our Data.plist file
        [plistData writeToFile:plistPath atomically:YES];
    }else{
        NSLog(@"Error in saveData: %@", error);
    }
    // read now
    NSMutableDictionary *savedStock = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    NSLog(@"savedStock = %@",savedStock);
    
    return true;
    
}

/*-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    TabBarViewController *tabBarViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"TabBarViewController"];
    [tabBarViewController setSelectedIndex:2];
    [self presentViewController:tabBarViewController animated:YES completion:nil];
}*/

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    //  NSUInteger numRows = 3;
    return self.graduationYearArray.count;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    title = self.graduationYearArray[row];
    return title;
}

// tell the picker the width of each row for a given component
//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
//    int sectionWidth = 300;
//
//    return sectionWidth;
//}


@end
