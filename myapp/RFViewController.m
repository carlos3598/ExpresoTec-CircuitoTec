//
//  RFViewController.m
//  RFSegmentView
//
//  Created by 王若风 on 1/15/15.
//  Copyright (c) 2015 王若风. All rights reserved.
//

#import "RFViewController.h"
#import "RFSegmentView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface RFViewController ()<RFSegmentViewDelegate>



@end

@implementation RFViewController


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
    
    
        RFSegmentView* segmentView = [[RFSegmentView alloc] initWithFrame:CGRectMake(0, 70, kScreenWidth, 60) items:@[@"Ida",@"Regreso",@"Tiempo"]];
        segmentView.tintColor = [self getRandomColor];
        segmentView.delegate = self;
        [self.view addSubview:segmentView];
    
    
        self.vista2.hidden = YES;
        self.vista3.hidden = YES;
    // Do any additional setup after loading the view.
}

- (UIColor *)getRandomColor
{
    UIColor *color = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    return color;
}

- (void)segmentViewSelectIndex:(NSInteger)index
{
    NSLog(@"current index is %d",index);
    if(index == 0){
        self.vista1.hidden = NO;
        self.vista2.hidden = YES;
        self.vista3.hidden = YES;    }
    if(index == 1){
        self.vista1.hidden = YES;
        self.vista2.hidden = NO;
        self.vista3.hidden = YES;
    }
    if(index == 2){
        self.vista1.hidden = YES;
        self.vista2.hidden = YES;
        self.vista3.hidden = NO;
    }
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

@end

// Copyright belongs to original author
// http://code4app.net (en) http://code4app.com (cn)
// From the most professional code share website: Code4App.net 
