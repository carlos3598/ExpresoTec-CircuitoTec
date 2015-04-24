//
//  FavoritosTableViewController.m
//  myapp
//
//  Created by Eric Isidro Gonzalez on 4/24/15.
//  Copyright (c) 2015 Carlos Salazar. All rights reserved.
//

#import "FavoritosTableViewController.h"
#import "RutasViewController.h"

@interface FavoritosTableViewController ()

@property NSArray *objects;

@end

@implementation FavoritosTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"favoritos" ofType:@"plist"];
    _objects =[[NSMutableArray alloc] initWithContentsOfFile:path1];
  
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell3" forIndexPath:indexPath];
    
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
