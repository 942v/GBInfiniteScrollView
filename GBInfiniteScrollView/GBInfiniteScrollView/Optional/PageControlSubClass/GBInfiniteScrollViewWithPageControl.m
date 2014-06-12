//
//  GBInfiniteScrollViewWithPageControl.m
//  GBInfiniteScrollView
//
//  Created by Guillermo Saenz on 6/1/14.
//  Copyright (c) 2014 Gerardo Blanco García. All rights reserved.
//

#import "GBInfiniteScrollViewWithPageControl.h"

static const CGFloat GBPageControlDefaultHeight = 32.f;

@interface GBInfiniteScrollViewWithPageControl ()

@property (nonatomic, getter = isPageControlRotated) BOOL pageControlRotated;

@end

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
    if(self.isDebugModeOn && self.isVerboseDebugModeOn)NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));

    [self setDelegate:self];
    
    self.pageControlViewContainer = [[GBPageControlViewContainer alloc] init];
    
    [self setPageControlPosition:GBPageControlPositionHorizontalBottom];
    [self setPageControlRotated:NO];
}

- (void)setupDefaultValuesPageControl
{
    if(self.isDebugModeOn && self.isVerboseDebugModeOn)NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    
    [self.pageControlViewContainer setFrame:[self pageControlFrame]];
    
    [self checkOrientation];
    
    [self.pageControlViewContainer setCenter:[self pageControlCenter]];
    
    [self.pageControlViewContainer.pageControl setNumberOfPages:[self.infiniteScrollViewDataSource numberOfPagesInInfiniteScrollView:self]];
    [self.pageControlViewContainer.pageControl setCurrentPage:self.currentPageIndex];

    if (![self.superview.subviews containsObject:self.pageControlViewContainer])[self.superview addSubview:self.pageControlViewContainer];
}

- (CGRect)pageControlFrame{
    if(self.isDebugModeOn && self.isVerboseDebugModeOn)NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    CGRect pageControlFrame = self.pageControlViewContainer.frame;
    
    if ([self needsRotation]) {
        pageControlFrame.size.height = GBPageControlDefaultHeight;
        pageControlFrame.size.width = self.frame.size.height;
    }else{
        pageControlFrame.size.height = GBPageControlDefaultHeight;
        pageControlFrame.size.width = self.frame.size.width;
    }
    
    return pageControlFrame;
}

- (CGPoint)pageControlCenter{
    if(self.isDebugModeOn && self.isVerboseDebugModeOn)NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    CGPoint pageControlCenter = CGPointZero;
    switch ([self getPageControlPosition]) {
        case GBPageControlPositionHorizontalBottom:
            pageControlCenter.x = self.frame.origin.x + self.pageControlViewContainer.frame.size.width/2;
            pageControlCenter.y = self.frame.origin.y + self.frame.size.height - self.pageControlViewContainer.frame.size.height/2;
            break;
        case GBPageControlPositionHorizontalTop:
            pageControlCenter.x = self.frame.origin.x + self.pageControlViewContainer.frame.size.width/2;
            pageControlCenter.y = self.frame.origin.y + self.pageControlViewContainer.frame.size.height/2;
            break;
        case GBPageControlPositionVerticalLeft:
            pageControlCenter.x = self.frame.origin.x + self.pageControlViewContainer.frame.size.width/2;
            pageControlCenter.y = self.frame.origin.y + self.pageControlViewContainer.frame.size.height/2;
            break;
        case GBPageControlPositionVerticalRight:
            pageControlCenter.x = self.frame.origin.x + self.frame.size.width - self.pageControlViewContainer.frame.size.width/2;
            pageControlCenter.y = self.frame.origin.y + self.pageControlViewContainer.frame.size.height/2;
            break;
        default:
            pageControlCenter = self.center;
            break;
    }
    
    return pageControlCenter;
}

- (GBPageControlPosition)getPageControlPosition{
    if(self.isDebugModeOn && self.isVerboseDebugModeOn)NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    if (self.scrollDirection==GBScrollDirectionHorizontal) {
        if (self.pageControlPosition!=GBPageControlPositionHorizontalBottom && self.pageControlPosition!=GBPageControlPositionHorizontalTop) {
            if (self.pageControlPosition==GBPageControlPositionVerticalLeft) {
                self.pageControlPosition = GBPageControlPositionHorizontalBottom;
            }else{
                self.pageControlPosition = GBPageControlPositionHorizontalTop;
            }
        }
    }else{
        if (self.pageControlPosition!=GBPageControlPositionVerticalLeft && self.pageControlPosition!=GBPageControlPositionVerticalRight) {
            if (self.pageControlPosition==GBPageControlPositionHorizontalBottom) {
                self.pageControlPosition = GBPageControlPositionVerticalLeft;
            }else{
                self.pageControlPosition = GBPageControlPositionVerticalRight;
            }
        }
    }
    
    return self.pageControlPosition;
}

- (void)checkOrientation{
    if(self.isDebugModeOn && self.isVerboseDebugModeOn)NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    if ([self needsRotation]) {
        [self.pageControlViewContainer setTransform:CGAffineTransformRotate(self.pageControlViewContainer.transform, M_PI_2)];
        [self setPageControlRotated:YES];
    }
}

- (BOOL)needsRotation{
    if(self.isDebugModeOn && self.isVerboseDebugModeOn)NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    if (self.scrollDirection==GBScrollDirectionVertical && !self.isPageControlRotated) {
        return YES;
    }
    
    return NO;
}

#pragma mark - Layout

- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    
    [self setupDefaultValuesPageControl];
}

#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if(self.isDebugModeOn && self.isVerboseDebugModeOn)NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    
    [self.pageControlViewContainer.pageControl setNumberOfPages:[self.infiniteScrollViewDataSource numberOfPagesInInfiniteScrollView:self]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(self.isDebugModeOn && self.isVerboseDebugModeOn)NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));

    [self.pageControlViewContainer.pageControl setCurrentPage:self.currentPageIndex];
}

@end

@implementation GBPageControlViewContainer

- (id)init
{
    self = [super init];
    
    if (self) {
        [self setupView];
    }
    
    return self;
}

- (void)setupView{
    [self setClipsToBounds:YES];
    
    self.pageControl = [[FXPageControl alloc] init];
    [self.pageControl setBackgroundColor:[UIColor clearColor]];
    [self.pageControl setDefersCurrentPageDisplay:YES];
    
    [self addSubview:self.pageControl];
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    frame.origin = CGPointZero;
    
    [self.pageControl setFrame:frame];
}

@end
