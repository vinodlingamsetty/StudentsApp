//
//  ApartmentsTableViewController.m
//  StudentsApp
//
//  Created by Vinod Lingamsetty on 7/13/16.
//  Copyright © 2016 Vinod Lingamsetty. All rights reserved.
//

#import "ApartmentsTableViewController.h"
#import "StudentsTableViewController.h"
#import "LoginViewController.h"
#import "Property.h"
#import "Student.h"
#import "MKSHorizontalLineProgressView.h"


@interface ApartmentsTableViewController () {
    NSMutableArray *apartmentsArray;
}

@end

@implementation ApartmentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:
                                     [UIImage imageNamed:@"6.jpg"]];
    self.tableView.backgroundView.contentMode = UIViewContentModeScaleAspectFill;
    
    
    apartmentsArray = [[NSMutableArray alloc] init];
    
    UILabel *copyright = [[UILabel alloc]initWithFrame:CGRectMake(270, 620, 200, 30)];
    copyright.text = @"© Vinod";
    [self.tableView addSubview:copyright];
    copyright.textColor = [UIColor colorWithWhite:1 alpha:0.5];
    copyright.font = [UIFont fontWithName:@"default" size:10];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:@"username"]){
        
        NSString *noteDataString = [NSString stringWithFormat:@"inputEmail=%@&password=%@", [defaults objectForKey:@"username"],[defaults objectForKey:@"password"]];
        
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
                self.dataForProperties = dict;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self structureData:self.dataForProperties];
                });
               
            } else {
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                LoginViewController *controller = (LoginViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"loginController"];
                controller.apt = self;
                [self presentViewController:controller animated:NO completion:nil];
            }
        }];
        [postDataTask resume];

    } else {
        
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        LoginViewController *controller = (LoginViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"loginController"];
        controller.apt = self;
        [self presentViewController:controller animated:NO completion:nil];
    }
    
}

-(void) structureData:(NSDictionary *)theData {
    [apartmentsArray removeAllObjects];
    for(NSDictionary *apartments in [theData objectForKey:@"results"]){
        Property *prop = [[Property alloc] init];
        prop.propertyId = [[apartments objectForKey:@"propertyId"] intValue];
        prop.buildingName = [apartments objectForKey:@"buildingName"];
        prop.apartmentNumber = [apartments objectForKey:@"apartmentNumber"];
        prop.noOfSlots = [[apartments objectForKey:@"noOfSlots"] intValue];
//        prop.st
        
        NSMutableArray *arrayOfStudents = [[NSMutableArray alloc] init];
        for(NSDictionary *studDict in [apartments objectForKey:@"students"]){
            Student *student = [[Student alloc] init];
            student.studentId = [[studDict objectForKey:@"studentId"] intValue];
            student.fullName = [studDict objectForKey:@"uFullName"];
            student.email = [studDict objectForKey:@"uEmail"];
            student.phone = [studDict objectForKey:@"uPhone"];
            student.recruiterName = [studDict objectForKey:@"recruiterName"];
            student.entryDate = [studDict objectForKey:@"entryDate"];
            if([[studDict objectForKey:@"exitDate"] isKindOfClass:[NSNull class]]){
                student.exitDate = @"Still Safe";
            } else {
                student.exitDate = [studDict objectForKey:@"exitDate"];
            }
            [arrayOfStudents addObject:student];
        }
        prop.students = arrayOfStudents;
        [apartmentsArray addObject:prop];
    }
    [self.tableView reloadData];

}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if([self.dataForProperties objectForKey:@"results"]){
        [self structureData:self.dataForProperties];
    } else {
        NSLog(@"No Data");
    }
    
    
}



#pragma mark - Table view data source

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    // return apartmentsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
//    Property *property = [apartmentsArray objectAtIndex:section];
//    return property.students.count;
    return apartmentsArray.count;

    
}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    
//    Property *property = [apartmentsArray objectAtIndex:section];
//
//    return [NSString stringWithFormat:@"%@ - %@",property.buildingName, property.apartmentNumber];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    Property *property = [apartmentsArray objectAtIndex:indexPath.row];
  //  Student *student = [property.students objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - #%@",property.buildingName, property.apartmentNumber];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    
    
//    UIImageView *yourImageView = [[UIImageView alloc] initWithFrame:CGRectMake(cell.frame.size.width-150,10,100,20)];
//    if (indexPath.row == 0) {
//        [yourImageView setImage:[UIImage imageNamed:@"1.png"]];
//    }
//    else if (indexPath.row ==1){
//        [yourImageView setImage:[UIImage imageNamed:@"2.png"]];
//    }
//    else if (indexPath.row ==2){
//        [yourImageView setImage:[UIImage imageNamed:@"5.png"]];
//    }
// 
//    yourImageView.contentMode = UIViewContentModeScaleAspectFit;
//    
//    [cell.contentView addSubview:yourImageView];

    
    
    MKSHorizontalLineProgressView *fillView = [[MKSHorizontalLineProgressView alloc]initWithFrame:CGRectMake(cell.frame.size.width-150,10,100,20)];
    if (indexPath.row ==0) {
        fillView.progressValue = 50.0f;
        fillView.trackColor = [UIColor clearColor];
        fillView.backgroundColor = [UIColor clearColor];
        fillView.barColor = [UIColor colorWithRed:0.0f / 255.0f green:200.0f / 255.0f blue:100.0f / 255.0f alpha:1.0f];
        fillView.barThickness = fillView.frame.size.height;
        fillView.showPercentageText = YES;
        [cell.contentView addSubview:fillView];
    }
   else if (indexPath.row ==1) {
        fillView.progressValue = 80.0f;
       fillView.trackColor = [UIColor clearColor];
       fillView.backgroundColor = [UIColor clearColor];
        fillView.barColor = [UIColor colorWithRed:255.0f / 255.0f green:128.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f];
        fillView.barThickness = fillView.frame.size.height;
        fillView.showPercentageText = YES;
        [cell.contentView addSubview:fillView];
    }
    else if (indexPath.row ==2) {
        fillView.progressValue = 90.0f;
        fillView.trackColor = [UIColor clearColor];
        fillView.backgroundColor = [UIColor clearColor];
        fillView.barColor = [UIColor colorWithRed:255.0f / 255.0f green:0.0f / 255.0f blue:0.0f / 255.0f alpha:1.0f];
        fillView.barThickness = fillView.frame.size.height;
        fillView.showPercentageText = YES;
        [cell.contentView addSubview:fillView];
    }
    
    
    
    
    
    
    self.tableView.separatorColor = [UIColor clearColor];
    [[cell contentView] setBackgroundColor:[UIColor clearColor]];
    [[cell backgroundView] setBackgroundColor:[UIColor clearColor]];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    StudentsTableViewController *studController = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    Property *property = [apartmentsArray objectAtIndex:indexPath.row];
    
    studController.title = [NSString stringWithFormat:@"%@ - %@",property.buildingName, property.apartmentNumber];
    studController.arrayOfStudents = property.students;
    

}


@end
