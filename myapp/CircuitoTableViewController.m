//
//  CircuitoTableViewController.m
//  myapp
//
//  Created by alumno on 4/23/15.
//  Copyright (c) 2015 Carlos Salazar. All rights reserved.
//

#import "CircuitoTableViewController.h"
#import "RutasViewController.h"
#import "RFViewController.h"

@interface CircuitoTableViewController ()
@property NSArray *objects;
@end

@implementation CircuitoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _objects = [[NSArray alloc] initWithObjects:@"Garza Sada (Dia) ",@"Ruta A (noche) ",@"Ruta B (noche) ",@"Ruta C (noche)",nil];
    
    
    
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell2" forIndexPath:indexPath];
    
    NSString *object = self.objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell *cell = (UITableViewCell*) sender;
    UITabBarController *controler = [segue destinationViewController];
    RutasViewController *mapa = [[controler viewControllers] objectAtIndex:0];
    RFViewController *horarios = [[controler viewControllers] objectAtIndex:1];
    mapa.detailItem = cell.textLabel.text;
    horarios.ruta =cell.textLabel.text;
}


@end
