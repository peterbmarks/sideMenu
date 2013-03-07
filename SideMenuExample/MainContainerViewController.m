//
//  MainContainerViewController.m
//  iViewPrototype
//
//  Created by Peter Marks on 28/02/13.
//  Copyright (c) 2013  Peter B Marks
//
// This view simply contains the menu and home view - it isn't visible
// This is the ViewControllerContainer

#import <QuartzCore/QuartzCore.h>   // for the drop shadow

#import "MainContainerViewController.h"
#import "MenuViewController.h"
#import "HomeViewController.h"
#import "AppDelegate.h"

// how far to slide right to show the menu
#define kSlideRightPoints 250.0

@interface MainContainerViewController ()
{
    MenuViewController *_menuViewController;
    HomeViewController *_homeViewController;
    UIPanGestureRecognizer *_panGestureRecognizer;  // for pulling the menu open or closed
    BOOL _menuShowing;
    CGRect _frontViewClosedFrame;   // used for sliding it
}
@end

@implementation MainContainerViewController

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
    _menuShowing = NO;
    
    // Add our sub view controllers
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"SideMenuApp" bundle:nil];
    _menuViewController = [storyBoard instantiateViewControllerWithIdentifier:@"Menu"];
    
    [self addChildViewController:_menuViewController];
    [_menuViewController didMoveToParentViewController:self];
    //_menuViewController.view.frame = self.view.bounds;
    [self.view addSubview:_menuViewController.view];

    _homeViewController = [storyBoard instantiateViewControllerWithIdentifier:@"Home"];
    _homeViewController.view.frame = self.view.bounds;
    _frontViewClosedFrame = _homeViewController.view.frame;
    [self addChildViewController:_homeViewController];
    [self.view addSubview:_homeViewController.view];
    [_homeViewController didMoveToParentViewController:self];
    
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestures:)];
    _panGestureRecognizer.minimumNumberOfTouches = 1;   // one finger only
    _panGestureRecognizer.maximumNumberOfTouches = 1;
    [_homeViewController.view addGestureRecognizer:_panGestureRecognizer];
    
    // add a drop shadow on the left of the home view
    _homeViewController.view.layer.masksToBounds = NO;
    _homeViewController.view.layer.shadowOffset = CGSizeMake(-2, 0);
    _homeViewController.view.layer.shadowRadius = 2;
    _homeViewController.view.layer.shadowOpacity = 0.5;

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMenuView:) name:kShowMenuNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideMenuView:) name:kHideMenuNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showHideMenuView:) name:kShowHideMenuNotification object:nil];
}

// slide the front view to the side so the menu view is visible
- (void)showMenuView:(NSNotification *)notification
{
    CGRect destination = _frontViewClosedFrame;
    
    CGRect frame = self.view.bounds;
    frame.origin.y += 44;// space for the menu button

    _menuShowing = YES;
    destination.origin.x += kSlideRightPoints;
    
    [UIView animateWithDuration:0.30 animations:^{
        _homeViewController.view.frame = destination;
    } completion:nil];
}

- (void)hideMenuView:(NSNotification *)notification
{
    CGRect destination = _frontViewClosedFrame;
    
    _menuShowing = NO;
    destination.origin.x = 0;
    
    [UIView animateWithDuration:0.30 animations:^{
        _homeViewController.view.frame = destination;
        
    } completion:nil];
}

- (void)showHideMenuView:(NSNotification *)notification
{
    if(!_menuShowing)
        [self showMenuView:nil];
    else
        [self hideMenuView:nil];
}

- (void) handlePanGestures:(UIPanGestureRecognizer*)paramSender
{
    static float initialXOffset = 0;
    if(paramSender.state == UIGestureRecognizerStateBegan)
        initialXOffset = [paramSender locationInView:paramSender.view].x;
    
    if (paramSender.state != UIGestureRecognizerStateEnded && paramSender.state != UIGestureRecognizerStateFailed)
    {
        CGPoint location = [paramSender locationInView:paramSender.view.superview];
        CGRect newFrame = _frontViewClosedFrame;
        newFrame.origin.x = location.x - initialXOffset;
        if(newFrame.origin.x < 0)
            newFrame.origin.x = 0;
        _homeViewController.view.frame = newFrame;
    }
    
    if(paramSender.state == UIGestureRecognizerStateEnded)
    {
        if(_homeViewController.view.frame.origin.x > 160)
        {
            [self showMenuView:nil];
        }
        else
        {
            [self hideMenuView:nil];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
