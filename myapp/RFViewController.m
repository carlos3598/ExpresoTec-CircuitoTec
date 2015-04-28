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

@property (strong, nonatomic) NSArray *objects;

@end

@implementation RFViewController

-(void) viewDidAppear:(BOOL)animated   {
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void) addScrollViews{

    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"horarios" ofType:@"plist"];
    _objects =[[NSMutableArray alloc] initWithContentsOfFile:path1];
    NSDictionary *dic = [_objects objectAtIndex:1];
    NSArray *salidas = [dic objectForKey:@"salidas"];
    NSArray *llegadas = [dic objectForKey:@"llegadas"];
    NSArray *salidasM = [dic objectForKey:@"salidasM"];
    NSArray *llegadasM = [dic objectForKey:@"llegadasM"];
    NSArray *regreso = [dic objectForKey:@"regreso"];
    NSArray *regresoM = [dic objectForKey:@"regresoM"];
    NSArray *tiempo = [dic objectForKey:@"tiempo"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.lbSal.frame.origin.y + self.lbSal.frame.size.height , kScreenWidth, 30)];
    label.text = @"Lunes, Martes, Jueves, Viernes";
    label.textAlignment = NSTextAlignmentCenter;
    
    CGFloat initY = 10;
    CGFloat finalY =0;
    for (int i =0; i<[salidas count]; i++) {
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(self.lbSal.frame.size.width/2, label.frame.origin.y + label.frame.size.height+initY, 50, 20)];
        label1.text = salidas[i];
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(self.lbLLegadas.frame.origin.x +20 ,label.frame.origin.y+ label.frame.size.height+ initY, 50, 20)];
        label2.text = llegadas[i];
        initY+=30;
        [_scrollv1 addSubview:label1];
        [_scrollv1 addSubview:label2];
        finalY = label1.frame.origin.y + label1.frame.size.height;
        
    }
    initY =0;
    UILabel *labelMier = [[UILabel alloc] initWithFrame:CGRectMake(0, finalY + 10, kScreenWidth, 40)];
    labelMier.text = @"Miercoles";
    labelMier.textAlignment = NSTextAlignmentCenter;
    for (int i =0; i<[salidasM count]; i++) {
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(self.lbSal.frame.size.width/2, labelMier.frame.origin.y + labelMier.frame.size.height+initY, 50, 20)];
        label1.text = salidasM[i];
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(self.lbLLegadas.frame.origin.x +20 ,labelMier.frame.origin.y+ labelMier.frame.size.height+ initY, 50, 20)];
        label2.text = llegadasM[i];
        initY+=30;
        [_scrollv1 addSubview:label1];
        [_scrollv1 addSubview:label2];
        
        
    }
    
    //_scrollv1.backgroundColor = [self getRandomColor];
    _scrollv1.accessibilityActivationPoint = CGPointMake(100, 100);
    _scrollv1.minimumZoomScale = 0.5;
    _scrollv1.maximumZoomScale = 3;
    _scrollv1.contentSize = CGSizeMake(self.scrollv1.frame.size.width,500);
    [_scrollv1 addSubview:label];
    [_scrollv1 addSubview:labelMier];
    
    
    /***** Vista de Regreso ***/
    UILabel *labelT = [[UILabel alloc] initWithFrame:CGRectMake(0, self.lbsSalida.frame.origin.y + self.lbsSalida.frame.size.height , kScreenWidth, 30)];
    labelT.text = @"Lunes, Martes, Jueves, Viernes";
    labelT.textAlignment = NSTextAlignmentCenter;

    
    initY = 10;
    for (int i =0; i<[regreso count]; i++) {
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, labelT.frame.origin.y + labelT.frame.size.height+initY, kScreenWidth , 20)];
        label1.text = regreso[i];
        label1.textAlignment = NSTextAlignmentCenter;
        initY+=30;
        [_scrollv2 addSubview:label1];
        finalY = label1.frame.origin.y + label1.frame.size.height;
        
    }
    UILabel *labelMier2 = [[UILabel alloc] initWithFrame:CGRectMake(0, finalY + 10, kScreenWidth, 40)];
    labelMier2.text = @"Miercoles";
    labelMier2.textAlignment = NSTextAlignmentCenter;
    initY =0;
    for (int i =0; i<[regresoM count]; i++) {
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, labelMier2.frame.origin.y + labelMier2.frame.size.height+initY, kScreenWidth, 20)];
        label1.text = regresoM[i];
        label1.textAlignment = NSTextAlignmentCenter;
        initY+=30;
        [_scrollv2 addSubview:label1];

        finalY = label1.frame.origin.y + label1.frame.size.height;
    }
     _scrollv2.contentSize = CGSizeMake(self.scrollv2.frame.size.width,500);
    
    [_scrollv2 addSubview:labelT];
    [_scrollv2 addSubview:labelMier2];
    
    /****VISTA  3 *****/
    initY = 10;
    for (int i =0; i<[tiempo count]; i++) {
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(self.lbParada.frame.origin.x , self.lbParada.frame.origin.y + self.lbParada.frame.size.height+initY, 50 , 20)];
        if(i==[tiempo count]-1)
            label1.text = @"TEC";
        else
            label1.text = [NSString stringWithFormat:@"%d",i+1];
        label1.textAlignment = NSTextAlignmentCenter;
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(self.lbHorario.frame.origin.x , self.lbParada.frame.origin.y + self.lbParada.frame.size.height+initY, 50 , 20)];
        label2.text = tiempo[i];
        label2.textAlignment = NSTextAlignmentCenter;
        initY+=30;
        [_scrollv3 addSubview:label2];
        [_scrollv3 addSubview:label1];
        
    }
    _scrollv3.contentSize = CGSizeMake(self.scrollv3.frame.size.width,500);
    
}
-(void) addSegmentedView{
    RFSegmentView* segmentView = [[RFSegmentView alloc] initWithFrame:CGRectMake(0, 70, kScreenWidth, 60) items:@[@"Ida",@"Regreso",@"Tiempo"]];
    segmentView.tintColor = [self getRandomColor];
    segmentView.delegate = self;
    [self.view addSubview:segmentView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addSegmentedView];
    [self addScrollViews];
    self.scrollv2.hidden = YES;
    self.scrollv3.hidden = YES;
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
        self.scrollv1.hidden = NO;
        self.scrollv2.hidden = YES;
        self.scrollv3.hidden = YES;
    }
    if(index == 1){
        self.scrollv1.hidden = YES;
        self.scrollv2.hidden = NO;
        self.scrollv3.hidden = YES;
    }
    if(index == 2){
        self.scrollv1.hidden = YES;
        self.scrollv2.hidden = YES;
        self.scrollv3.hidden = NO;
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
