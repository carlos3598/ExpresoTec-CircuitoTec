//
//  RFViewController.h
//  RFSegmentView
//
//  Created by 王若风 on 1/15/15.
//  Copyright (c) 2015 王若风. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RFViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *vistaIda;
@property (weak, nonatomic) IBOutlet UILabel *lbSal;
@property NSInteger index;
@property (weak, nonatomic) IBOutlet UILabel *lbLLegadas;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollv1;
@property (weak, nonatomic) IBOutlet UILabel *lbsSalida;
@property (weak, nonatomic) IBOutlet UILabel *lbTiempo;


@property (weak, nonatomic) IBOutlet UIScrollView *scrollv2;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollv3;
@property (weak, nonatomic) IBOutlet UILabel *lbParada;
@property (weak, nonatomic) IBOutlet UILabel *lbHorario;

@end

// Copyright belongs to original author
// http://code4app.net (en) http://code4app.com (cn)
// From the most professional code share website: Code4App.net 
