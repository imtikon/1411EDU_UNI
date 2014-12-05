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

-(void) setCheckinPlist;
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

- (IBAction)signUpAction:(id)sender {
    
    /*
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
            
            NSURL *url = [NSURL URLWithString:@"http://mobioapp.net/apps/gloriajeans/public/signup_json"];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:url];
            [request setHTTPMethod:@"POST"];
            NSString *boundary = [NSString stringWithString:@"*****"];
            NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
            [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
            NSMutableData *body = [NSMutableData data];
            
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"name\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@",self.emailTextField.text] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"email\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@",self.emailText.text] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"device_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@",deviceID] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"phone_no\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@",self.phoneNoText.text] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"date_of_birth\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@",self.dateOfBirthText.text] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"area\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@",self.areaTxt.text] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            //    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file_name\"; filename=\%@\r\n",_filepath] dataUsingEncoding:NSUTF8StringEncoding]];
            //    [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            //    [body appendData:[NSData dataWithData:imageData]];
            //
            //    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
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
                        NSArray *pathsRead = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                        NSString *documentsDirectoryRead = [pathsRead objectAtIndex:0];
                        NSString *dataFilePathRead = [documentsDirectoryRead stringByAppendingPathComponent:@"SignUp.plist"];
                        NSDictionary *peoplesList = [[NSDictionary alloc] initWithContentsOfFile:dataFilePathRead];
                        NSLog(@"peoplesList== %@",peoplesList);
                        [self setCheckinPlist ];
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
            }else if([[json objectForKey:@"message"] isEqualToString:@"blank"]){
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
     */
    
}
@end
