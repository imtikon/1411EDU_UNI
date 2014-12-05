//
//  LoginViewController.m
//  Uni app
//
//  Created by Imtiaz Hossain on 11/26/14.
//  Copyright (c) 2014 Imtiaz Hossain. All rights reserved.
// sca-qv-cartbtn sca-qv-cartbtn-config
// sca-qv-add-item-form

#import "LoginViewController.h"
#import "Reachability.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

// emailTextField, passwordTextField

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
    
    self.emailTextField.delegate = self;
    self.emailTextField.tag = 1;
    //self.emailTextField.textColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:204/255.0f alpha:1.0f];
    
    self.passwordTextField.delegate  = self;
    self.passwordTextField.tag = 2;
    //self.passwordTextField.textColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:204/255.0f alpha:1.0f];
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

- (IBAction)loginButtonAction:(id)sender {
    
    Reachability *internetReach = [Reachability reachabilityForInternetConnection];
	NetworkStatus netStatus = [internetReach currentReachabilityStatus];
    if (netStatus == NotReachable)
    {
        //net nai.
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
            //            if ([self.phoneNoText.text isEqualToString:@""]) {
            //
            //                self.phoneNoText.backgroundColor = [UIColor redColor];
            //            }
            //
            //            if ([self.dateOfBirthText.text isEqualToString:@""]) {
            //
            //                self.dateOfBirthText.backgroundColor = [UIColor redColor];
            //            }
            //
            //            if ([self.areaTxt.text isEqualToString:@""]) {
            //
            //                self.areaTxt.backgroundColor = [UIColor redColor];
            //            }
            
            UIAlertView *errorMessage=[[UIAlertView alloc] initWithTitle:@"..Sign Up.." message:@"You have to enter required data." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorMessage show];
            
            
        } else {
            NSURL *url = [NSURL URLWithString:@"http://imtikon.com/apps/uni/login.php"];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:url];
            [request setHTTPMethod:@"POST"];
            NSString *boundary = [NSString stringWithString:@"*****"];
            NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
            [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
            NSMutableData *body = [NSMutableData data];
            NSLog(@"--%@--",body);
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"password\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@",self.passwordTextField.text] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"email\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@",self.emailTextField.text] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [request setHTTPBody:body];
            
            NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            NSLog([NSString stringWithFormat:@"Image Return String: %@", returnString]);
            NSError *error;
            NSDictionary* json = [NSJSONSerialization
                                  JSONObjectWithData:returnData //1
                                  options:kNilOptions
                                  error:&error];
            
            //            if ([returnString rangeOfString:@"success"].location == NSNotFound || [returnString rangeOfString:@"exists"].location == NSNotFound)
            //            {
            
            if([[json objectForKey:@"message"] isEqualToString:@"success"] || [[json objectForKey:@"message"] isEqualToString:@"exists"])
            {
                NSLog(@"success");
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
                        //=======
                        NSArray *pathsRead = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                        NSString *documentsDirectoryRead = [pathsRead objectAtIndex:0];
                        NSString *dataFilePathRead = [documentsDirectoryRead stringByAppendingPathComponent:@"SignUp.plist"];
                        NSDictionary *peoplesList = [[NSDictionary alloc] initWithContentsOfFile:dataFilePathRead];
                        NSLog(@"peoplesList== %@",peoplesList);
                        
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
                UIAlertView *errorMessage=[[UIAlertView alloc] initWithTitle:@"Register" message:@"Successfully Registered." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [errorMessage show];
                //}
                
            }else if([[json objectForKey:@"message"] isEqualToString:@"blank"])
            {
                NSLog(@"exist");
                UIAlertView *errorMessage=[[UIAlertView alloc] initWithTitle:@"..Register.." message:@"Please enter your email address." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [errorMessage show];
            }else{
                NSLog(@"no success");
                UIAlertView *errorMessage=[[UIAlertView alloc] initWithTitle:@"..Register.." message:@"Not Registered." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [errorMessage show];
            }
        }
    }
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
    if (![self.emailTextField.text isEqualToString:@""]) {
        if ([self NSStringIsValidEmail:self.emailTextField.text]) {

        }else{
            self.emailTextField.text=@"";
            UIAlertView *emailAlertMessage=[[UIAlertView alloc]initWithTitle:@"Email!" message:@"Invalid Email Id. Please enter correct email id" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [emailAlertMessage show];
        }
    }
}

-(BOOL) NSStringIsValidEmail:(NSString *) checkString{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

/*-(void) textViewDidBeginEditing:(UITextView *)textView {
    
    switch (textView.tag) {
        case 3:
            self.messageTextBox.backgroundColor = [UIColor clearColor];
            _imageView.image = [UIImage imageNamed:@"row_1.png"];
            break;
        default:
            break;
    }
}*/


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 1:
            self.emailTextField.text = @"";
            //self.emailTextField.backgroundColor = [UIColor clearColor];
            break;
        case 2:
            self.passwordTextField.text = @"";
            //self.passwordTextField.backgroundColor = [UIColor clearColor];
            break;
        default:
            break;
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    switch (textField.tag) {
        case 1:
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
            [textField resignFirstResponder];
            break;
        }
        default:
            break;
    }
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 1:
            break;
        case 2:
            break;
        default:
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
@end
