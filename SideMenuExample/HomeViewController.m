//
//  HomeViewController.m
//  SideMenuExample
//
//  Created by Peter Marks on 5/03/13.
//  Copyright (c) 2013  Peter B Marks
//
// This view goes on top of the menu and can slide aside


#import "HomeViewController.h"
#import "AppDelegate.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)onShowMenuButton:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kShowHideMenuNotification object:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
