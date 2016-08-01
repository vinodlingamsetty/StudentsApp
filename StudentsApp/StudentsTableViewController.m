//
//  StudentsTableViewController.m
//  StudentsApp
//
//  Created by Vinod Lingamsetty on 7/13/16.
//  Copyright © 2016 Vinod Lingamsetty. All rights reserved.
//

#import "StudentsTableViewController.h"
#import "Student.h"
#import "StudentTableViewCell.h"
#import "CNPPopupController.h"

#define Tiger @"Chaitanya Tanna"
#define Vinod @"Vinod Kumar"
#define Fahim @"Rezaul Karin"
#define Tanvir @"Tanvir Alam"
#define Rakin @"Rakin Munjid"


@interface StudentsTableViewController (){
    
    NSString *dfullname;
    NSString *rName;
    NSString *pNum;
    NSString *email;
    NSString *strtDt;
    NSString *enddate;
}

@property (nonatomic, strong) CNPPopupController *popupController;


@end

@implementation StudentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:
                                     [UIImage imageNamed:@"6.jpg"]];
    self.tableView.backgroundView.contentMode = UIViewContentModeScaleAspectFill;
    
    UILabel *copyright = [[UILabel alloc]initWithFrame:CGRectMake(270, 620, 200, 30)];
    copyright.text = @"© Vinod Lingamsetty";
    [self.tableView addSubview:copyright];
    copyright.textColor = [UIColor colorWithWhite:1 alpha:0.5];
    copyright.font = [UIFont fontWithName:@"default" size:10];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfStudents.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Student *student = [self.arrayOfStudents objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    cell.textLabel.text = student.fullName;
    
    dfullname = student.fullName;
    rName = student.recruiterName;
    email = student.email;
    pNum = student.phone;
    strtDt = student.entryDate;
    enddate = student.exitDate;
    
    
    
//    
//    UIButton *infoBtn = [UIButton buttonWithType:UIButtonTypeInfoDark];
//    infoBtn.frame = CGRectMake(cell.frame.size.width-40, 7, 30, 30);
//    [cell addSubview:infoBtn];
//    
//    [infoBtn setHighlighted:YES];
//    [infoBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
//    [infoBtn performSelector:@selector(setHighlighted:) withObject:NO afterDelay:0.25];
    
    
    self.tableView.separatorColor = [UIColor clearColor];
        [[cell contentView] setBackgroundColor:[UIColor clearColor]];
        [[cell backgroundView] setBackgroundColor:[UIColor clearColor]];
        [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    dfullname = cell.textLabel.text;
    
   // dfullname = cell
//    dfullname = student.fullName;
//    rName = student.recruiterName;
//    email = student.email;
//    pNum = student.phone;
//    strtDt = student.entryDate;
//    enddate = student.exitDate;
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",dfullname] attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:24], NSParagraphStyleAttributeName : paragraphStyle}];
    NSAttributedString *lineOne = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Email: %@ \n Phone Number: %@ \n Start Date: %@ \n End Date:%@ ",email,pNum,strtDt,enddate] attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16], NSParagraphStyleAttributeName : paragraphStyle}];
    NSAttributedString *lineTwo = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Recruited by: %@",rName] attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18], NSForegroundColorAttributeName : [UIColor colorWithRed:0.46 green:0.8 blue:1.0 alpha:1.0], NSParagraphStyleAttributeName : paragraphStyle}];
   
    
    CNPPopupButton *button = [[CNPPopupButton alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [button setTitle:@"Done" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:0.46 green:0.8 blue:1.0 alpha:1.0];
    button.layer.cornerRadius = 4;
    button.selectionHandler = ^(CNPPopupButton *button){
        [self.popupController dismissPopupControllerAnimated:YES];
       // NSLog(@"Block for button: %@", button.titleLabel.text);
    };
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.numberOfLines = 0;
    titleLabel.attributedText = title;
    
    UILabel *lineOneLabel = [[UILabel alloc] init];
    lineOneLabel.numberOfLines = 0;
    lineOneLabel.attributedText = lineOne;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, 330, 300)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.clipsToBounds = YES;
    
    if ([dfullname isEqual:Tiger]) {
       imageView.image = [UIImage imageNamed:@"tiger.png"];
    }
    else if ([dfullname isEqual:Vinod]) {
        imageView.image = [UIImage imageNamed:@"vinod.jpg"];
        
    }
    else if ([dfullname isEqual:Fahim]) {
        imageView.image = [UIImage imageNamed:@"fahim.jpeg"];
    }
    else if ([dfullname isEqual:Tanvir]) {
        imageView.image = [UIImage imageNamed:@"tanvir.jpeg"];
    }
    else if ([dfullname isEqual:Rakin]) {
        imageView.image = [UIImage imageNamed:@"rakin.jpg"];
    }
    else{
       imageView.image = [UIImage imageNamed:@"pikachu.png"];
    }
    
    
    UILabel *lineTwoLabel = [[UILabel alloc] init];
    lineTwoLabel.numberOfLines = 0;
    lineTwoLabel.attributedText = lineTwo;
    
  
    
    
//    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 55)];
//    customView.backgroundColor = [UIColor lightGrayColor];
    
//    UITextField *textFied = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 230, 35)];
//    textFied.borderStyle = UITextBorderStyleRoundedRect;
//    textFied.placeholder = @"Custom view!";
//    [customView addSubview:textFied];
    
    self.popupController = [[CNPPopupController alloc] initWithContents:@[titleLabel, lineOneLabel, imageView, lineTwoLabel,/* customView,*/ button]];
     
    self.popupController.theme = [CNPPopupTheme defaultTheme];
    //self.popupController.theme.popupStyle = popupStyle;
    self.popupController.delegate = self;
    [self.popupController presentPopupControllerAnimated:YES];

}

#pragma mark - CNPPopupController Delegate

- (void)popupController:(CNPPopupController *)controller didDismissWithButtonTitle:(NSString *)title {
   // NSLog(@"Dismissed with button title: %@", title);
}

- (void)popupControllerDidPresent:(CNPPopupController *)controller {
    //NSLog(@"Popup controller presented.");
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
