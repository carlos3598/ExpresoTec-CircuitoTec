//
//  MasterValleTableViewController.m
//  myapp
//
//  Created by Carlos Salazar on 4/10/15.
//  Copyright (c) 2015 Carlos Salazar. All rights reserved.
//

#import "MasterTableViewController.h"
#import "RutasViewController.h"

@interface MasterTableViewController ()

@end

@implementation MasterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell *cell = (UITableViewCell*) sender;
    [[segue destinationViewController] setDetailItem:cell.textLabel.text];
}


@end
