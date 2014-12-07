//
//  CreateOwnViewController.m
//  Uni app
//
//  Created by Imtiaz Hossain on 11/28/14.
//  Copyright (c) 2014 Imtiaz Hossain. All rights reserved.
//

#import "CreateOwnViewController.h"
#import "SWRevealViewController.h"
#import "Reachability.h"

@interface CreateOwnViewController ()

@property NSString* filepath;
@property (strong, nonatomic) IBOutlet UIButton *uploadButton;

@end

@implementation CreateOwnViewController

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
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    self.eventNameTextField.delegate = self;
    self.eventNameTextField.tag = 1;
    
    self.eventDateField.delegate = self;
    self.eventDateField.tag = 2;
    
    self.eventDetailsField.delegate = self;
    self.eventDetailsField.tag = 3;
    
    //text color
    
    self.eventNameTextField.textColor= [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
    self.eventNameTextField.backgroundColor= [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
    self.eventDateField.textColor= [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
    self.eventDateField.backgroundColor= [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
    self.eventDetailsField.textColor= [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
    self.eventDetailsField.backgroundColor= [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
    
   
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 1:
            //[textField resignFirstResponder];
            NSLog(@"you clicked into event-title field.");
            self.eventNameTextField.text = @" ";
            self.eventNameTextField.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
            break;
        case 2:
            NSLog(@"you clicked into event-date field.");
            self.eventDateField.text = @" ";
            self.eventDateField.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
            break;
        case 3:{
            NSLog(@"you clicked into event-details field.");
            self.eventDetailsField.text = @" ";
            self.eventDetailsField.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f];
            break;
        }
        default:
            break;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    switch (textField.tag) {
        case 1:
            NSLog(@"you released event-title field.");
            [textField resignFirstResponder];
            break;
        case 2:
            NSLog(@"you released event-date field.");
            [textField resignFirstResponder];
            break;
        case 3:{
            NSLog(@"you released event-description field.");
            [textField resignFirstResponder];
            break;
        }
        default:
            break;
    }
    return YES;
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

- (IBAction)saveOwnTradition:(id)sender {
    
    Reachability *internetReach = [Reachability reachabilityForInternetConnection];
	NetworkStatus netStatus = [internetReach currentReachabilityStatus];
    
    if (netStatus == NotReachable)
    {
        //no connection of Internet
        UIAlertView *emailAlertMessage=[[UIAlertView alloc]initWithTitle:@"Failed!" message:@"Connect with Internet to save form." delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [emailAlertMessage show];
	}else{
        if ([self.eventNameTextField.text isEqualToString:@""]  ) {
            if ([self.eventNameTextField.text isEqualToString:@""]) {
                self.eventNameTextField.backgroundColor = [UIColor redColor];
                self.eventNameTextField.background= [UIImage imageNamed:@"emptyBG.png"];
            }
            
            if ([self.eventDetailsField.text isEqualToString:@""]) {
                self.eventDetailsField.backgroundColor = [UIColor redColor];
            }
            
            UIAlertView *errorMessage=[[UIAlertView alloc] initWithTitle:@"Create Own Tradition" message:@"Before submit fill-up required data." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorMessage show];
            
        }else{
            
            NSURL *url = [NSURL URLWithString:@"http://imtikon.com/apps/uni/register.php"];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:url];
            [request setHTTPMethod:@"POST"];
            NSString *boundary = [NSString stringWithString:@"*****"];
            NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
            [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
            NSMutableData *body = [NSMutableData data];
            
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"eventname\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@",self.eventNameTextField.text] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"eventdate\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@",self.eventDateField.text] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"eventdetail\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@",self.eventDetailsField.text] dataUsingEncoding:NSUTF8StringEncoding]];
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
                        NSLog(@"documentsDirectory = %@",documentsDirectory);
                        
                        NSString *dataFilePath = [documentsDirectory stringByAppendingPathComponent:@"Events.plist"];
                        [deserializedDictionary writeToFile:dataFilePath atomically:YES];
                        NSArray *pathsRead = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                        NSString *documentsDirectoryRead = [pathsRead objectAtIndex:0];
                        NSString *dataFilePathRead = [documentsDirectoryRead stringByAppendingPathComponent:@"Events.plist"];
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
                UIAlertView *errorMessage=[[UIAlertView alloc] initWithTitle:@"Create Own" message:@"You create it successfully." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [errorMessage show];
                
                self.eventNameTextField.text = @ "  Event Title";
                self.eventDateField.text = @ "  Event Date";
                self.eventDetailsField.text = @ "  Event Description";
                
                //}
            }else if([[json objectForKey:@"message"] isEqualToString:@"blank"]){
                NSLog(@"exist");
                UIAlertView *errorMessage=[[UIAlertView alloc] initWithTitle:@"..Create Own.." message:@"You already." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [errorMessage show];
            }else{
                NSLog(@"no success");
                UIAlertView *errorMessage=[[UIAlertView alloc] initWithTitle:@"..Create Own.." message:@"Server having problem to save data currently. Please try later." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [errorMessage show];
            }
            
            
            
        }
    }
    
}

- (IBAction)uploadPhoto:(id)sender {
}
@end
