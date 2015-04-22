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
@property NSArray *objects;

@end

@implementation MasterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _objects = [[NSArray alloc] initWithObjects:@"Cumbres",@"Lincoln",@"Linda Vista",@"San Jeronimo",@"San Nicolas",@"Valle 1",@"Valle 2",@"Valle 3",nil];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSString *object = self.objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell *cell = (UITableViewCell*) sender;
    UITabBarController *controler = [segue destinationViewController];
    RutasViewController *contr = [[controler viewControllers] objectAtIndex:0];
    contr.detailItem = cell.textLabel.text;
}


@end
