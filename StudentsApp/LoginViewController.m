//
//  LoginViewController.m
//  StudentsApp
//
//  Created by Vinod Lingamsetty on 7/13/16.
//  Copyright © 2016 Vinod Lingamsetty. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)signIn:(id)sender {
    
    NSString *noteDataString = [NSString stringWithFormat:@"inputEmail=%@&password=%@", self.userName.text,self.password.text];
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSURL *url = [NSURL URLWithString:@"http://oglie.com/app/signin.php"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPBody = [noteDataString dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSError *errorJson;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errorJson];
        if([dict objectForKey:@"results"]){
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:self.userName.text forKey:@"username"];
            [defaults setObject:self.password.text forKey:@"password"];
            [defaults synchronize];
            self.apt.dataForProperties = dict;
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }];
    [postDataTask resume];
}

@end
