//
//  LoginViewController.h
//  myapp
//
//  Created by alumno on 4/28/15.
//  Copyright (c) 2015 Carlos Salazar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
- (IBAction)login:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *tfUsuario;
@property (strong, nonatomic) IBOutlet UITextField *tfPassword;
@property (strong, nonatomic) NSString *usuario;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *service;

@end
