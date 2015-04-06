//
//  DateExampleViewController.m
//  BRUtilsDemo
//
//  Created by Bobby Ren on 4/5/15.
//  Copyright (c) 2015 Bobby Ren Tech. All rights reserved.
//

#import "DateExampleViewController.h"
#import "BRDateUtils.h"

@interface DateExampleViewController ()

@end

@implementation DateExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DateCell" forIndexPath:indexPath];
    cell.textLabel.backgroundColor = [UIColor clearColor];

    // Configure the cell...
    UILabel *detailsLabel = (UILabel *)[cell.contentView viewWithTag:1];
    detailsLabel.backgroundColor = [UIColor whiteColor];

    NSInteger row = indexPath.row;
    switch (row) {
        case 0:
        {
            cell.textLabel.text = @"Current Time";
            detailsLabel.text = [BRDateUtils simpleTimeForDate:[NSDate date]];
        }
            break;

        case 1:
        {
            cell.textLabel.text = @"Monday of this week";
            NSDate *monday = [BRDateUtils mondayOfWeekForDate:[NSDate date]];
            detailsLabel.text = [BRDateUtils yearMonthDayForDate:monday];
        }
            break;

        case 2:
        {
            cell.textLabel.text = @"Sunday of this week";
            NSDate *sunday = [BRDateUtils sundayOfWeekForDate:[NSDate date]];
            detailsLabel.text = [BRDateUtils yearMonthDayForDate:sunday];
        }
            break;

        case 3:
        {
            cell.textLabel.text = @"Month and year";
            NSString *month = [BRDateUtils monthForDate:[NSDate date] format:1];
            NSString *year = [BRDateUtils yearForDate:[NSDate date]];
            detailsLabel.text = [NSString stringWithFormat:@"%@, %@", month, year];
        }
            break;

        default:
            break;
    }
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
