//
//  GBInfiniteScrollViewWithPageControl.m
//  GBInfiniteScrollView
//
//  Created by Guillermo Saenz on 6/1/14.
//  Copyright (c) 2014 Gerardo Blanco García. All rights reserved.
//

#import "GBInfiniteScrollViewWithPageControl.h"

static const CGFloat GBPageControlDefaultHeight = 32.f;

@implementation GBInfiniteScrollViewWithPageControl

#pragma mark - Initialization

- (id)init
{
    return [super init];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupSubClass];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setupSubClass];
    }
    
    return self;
}

#pragma mark - Setup

- (void)setupSubClass;
{
    if(self.debug && self.verboseDebug)NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));

    [self setDelegate:self];
    
    self.pageControl = [[FXPageControl alloc] init];
    [self.pageControl setBackgroundColor:[UIColor clearColor]];
    [self.pageControl setDefersCurrentPageDisplay:YES];
}

- (void)setupDefaultValuesPageControl
{
    if(self.debug && self.verboseDebug)NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    CGRect pageControlFrame = self.pageControl.frame;
    pageControlFrame.size.height = GBPageControlDefaultHeight;
    pageControlFrame.size.width = self.frame.size.width;
    [self.pageControl setFrame:pageControlFrame];
    
    CGPoint pageControlCenter = self.center;
    
    [self.pageControl setCenter:pageControlCenter];
    
    [self.pageControl setNumberOfPages:[self.infiniteScrollViewDataSource numberOfPagesInInfiniteScrollView:self]];
    [self.pageControl setCurrentPage:self.currentPageIndex];
    
    if (![self.superview.subviews containsObject:self.pageControl])[self.superview addSubview:self.pageControl];
}

#pragma mark - Layout

- (void)reloadData
{
    [super reloadData];
    [self setupDefaultValuesPageControl];
}

#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if(self.debug && self.verboseDebug)NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    [self.pageControl setNumberOfPages:[self.infiniteScrollViewDataSource numberOfPagesInInfiniteScrollView:self]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(self.debug && self.verboseDebug)NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));

    [self.pageControl setCurrentPage:self.currentPageIndex];
}

@end
