//
//  ETWeekViewController.m
//  EpiTime
//
//  Created by Francis Visoiu Mistrih on 12/10/2014.
//  Copyright (c) 2014 EpiTime. All rights reserved.
//

#import "ETWeekViewController.h"
#import "ETDayTableViewController.h"
#import "ETConstants.h"
#import "ETAPI.h"

@interface ETWeekViewController () {
    ETWeekItem *weekItem;
}

@end

@implementation ETWeekViewController

- (void)viewDidLoad {

    [super viewDidLoad];

    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];

    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
}

- (void)viewWillAppear:(BOOL)animated {
    [ETAPI fetchCurrentWeek:@"ING1/GRA2" completion:^(NSDictionary *recievedData, ETWeekItem *week)
    {
        ETDayTableViewController *initialViewController = [self.storyboard instantiateViewControllerWithIdentifier:DAY_TABLE_VIEW_CONTROLLER];
        initialViewController.index = 0;
        initialViewController.day = week.days[0];

        NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
        [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];

        [self addChildViewController:self.pageController];
        [[self view] addSubview:[self.pageController view]];
        [self.pageController didMoveToParentViewController:self];

        weekItem = week;
    }];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    ETDayTableViewController *current = (ETDayTableViewController *)viewController;
    NSUInteger index = current.index == 0 ? 6 : current.index - 1;
    ETDayTableViewController *new = [self.storyboard instantiateViewControllerWithIdentifier:DAY_TABLE_VIEW_CONTROLLER];
    new.index = index;
    new.day = weekItem.days[index];
    return new;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    ETDayTableViewController *current = (ETDayTableViewController *)viewController;
    NSUInteger index = current.index == 6 ? 0 : current.index + 1;
    ETDayTableViewController *new = [self.storyboard instantiateViewControllerWithIdentifier:DAY_TABLE_VIEW_CONTROLLER];
    new.index = index;
    new.day = weekItem.days[index];
    return new;
}

@end
