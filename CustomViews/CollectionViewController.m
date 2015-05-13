//
//  CollectionViewController.m
//  CustomViews
//
//  Created by TouchROI on 3/1/14.
//  Copyright (c) 2014 TouchROI. All rights reserved.
//

#import "CollectionViewController.h"
#import "CVCell.h"
#import "MyFlowLayout.h"
#import "THSpringyFlowLayout.h"
#import "PNCollectionCellBackgroundView.h"
#import <QuartzCore/QuartzCore.h>
#import "SelectedFlowLayout.h"
#import "CVCell.h"
#import "MakeAllVisible.h"
#import "FlowLayoutAplhaZero.h"
#import "TransparentView.h"
#import "MakeAllInvisible.h"

@interface CollectionViewController ()
{
    CGRect _cellRelativeCoordinates;
    UIDynamicAnimator* _animator;
    UIGravityBehavior* _gravity;
    UIAttachmentBehavior* _attachement;
    UISnapBehavior * _snapper;
    UIAttachmentBehavior *_elasticityBehavior;
    UIImageView * _view;
    UIImageView * oldView;
    CVCell*   displayedCell;
 
    
}

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;


@end

@implementation CollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
             }
    return self;
}


-(void) snapView:(UIView*) view point:(CGPoint) point
{
    
    [self.view addSubview: view];
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _snapper = [[UISnapBehavior alloc] initWithItem:view snapToPoint:point];
    _snapper.damping = 0.55f;
 
    
    UIDynamicItemBehavior * dynamicItem = [[UIDynamicItemBehavior alloc] initWithItems:@[view]];
    dynamicItem.allowsRotation = NO;
    [_animator addBehavior:dynamicItem];
    [_animator addBehavior:_snapper];
    
}


-(void) reset
{
    
    [_view removeFromSuperview];
    [oldView removeFromSuperview];
    displayedCell.image.hidden=YES;
    
    
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator*)animator
{
  

    
}


-(void) snapBackView:(UIView*) view point:(CGPoint) point
{
    

    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _animator.delegate = self;
    _snapper = [[UISnapBehavior alloc] initWithItem:view snapToPoint:point];
    _snapper.damping = 5.00f;
   
    
    UIDynamicItemBehavior * dynamicItem = [[UIDynamicItemBehavior alloc] initWithItems:@[view]];
    dynamicItem.allowsRotation = YES;
    [_animator addBehavior:dynamicItem];
    [_animator addBehavior:_snapper];
    
    [self performSelector:@selector(removeScreens:) withObject:nil afterDelay:.08];
      
}
                       
-(IBAction) removeScreens:(id) timer
{
  
    [self reset];
                           
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 
 
    CVCell*   cell =  (CVCell*)  [_collection  cellForItemAtIndexPath:indexPath];
    
    
    
    if(!_itemSelected)
    {
    
        displayedCell=cell;
    
    CGRect cellFrame = cell.frame;
    _cellRelativeCoordinates = [self.view convertRect:cellFrame fromView:self.collection];
    oldView = [self addTakeImage:self.view];

        
   // UIBezierPath *arc = [UIBezierPath bezierPathWithRect:CGRectMake(0, _cellRelativeCoordinates.origin.y +60, 320, 600-//_cellRelativeCoordinates.origin.y-60) ];

      /*  CAShapeLayer *maskOvel = [CAShapeLayer layer];
        [maskOvel  setPath:[arc CGPath] ];
        [maskOvel setFillRule:kCAFillRuleEvenOdd];
        [maskOvel setFillColor:[[UIColor orangeColor] CGColor]];
       */
        
       // oldView.layer.mask = maskOvel;
    
    
      _view = [self addTakeImage:cell];
            cell.image.hidden=NO;
      _view.frame=_cellRelativeCoordinates;
      [self snapView:_view point:CGPointMake(320/2,230)];
     _itemSelected=YES;
        
 
        
    }
    else
    {
    
        //[self.view insertSubview:oldView aboveSubview:_view];
        [self snapBackView:_view point:CGPointMake(320/2,_cellRelativeCoordinates.origin.y+_cellRelativeCoordinates.size.height*.5)];
        _itemSelected=NO;
        
    }

    
    
    
  /*
    if(!_itemSelected)
    {
        
   
        
        _contentOffset = [_collection contentOffset];
        
        NSArray * visibleCells = [_collection visibleCells];
        CVCell* cell;
        
        for (cell in visibleCells)
        {
            
            //cell.alpha = 0;
            
        }
        
        

        
        [UIView animateWithDuration:.2
                              delay:5.0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             
                              // [_collection  setCollectionViewLayout: invisible animated:YES];
                      
                         }
                         completion:^ (BOOL finished){
                             
                             
                             [UIView animateWithDuration:.4
                                                   delay:0.0
                                                 options:UIViewAnimationOptionCurveEaseOut
                                              animations:^{
                                                  
                                                
                                                  
                                                // [_collection  setCollectionViewLayout: sfl animated:NO];
                                              }
                                              completion:nil];
                             
                             
                             
                                                          }];
        
        _itemSelected=YES;
        
    }
    else
    {
        
        MyFlowLayout *flowLayout = [[MyFlowLayout alloc] init];
        
        NSArray * visibleCells = [_collection visibleCells];
        
        CVCell * cell;
        
          [UIView animateWithDuration:.2
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             
                            
                             [self.collectionView setCollectionViewLayout:flowLayout animated:YES];
                             [_collection setContentOffset:_contentOffset];
                         }
                         completion:^ (BOOL finished){
                             
                             
                             [UIView animateWithDuration:.2
                                                   delay:3.0
                                                 options:UIViewAnimationOptionCurveEaseOut
                                              animations:^{
                                                  
                                              //  [_collection  setCollectionViewLayout: visible animated:YES];
                                                
                           
                                              }
                                              completion:nil];
                             
                             
                             
                         }];
       
        
        _itemSelected=NO;
        
    }
    
    
    */
    
    
   // NSLog(@"%s", __PRETTY_FUNCTION__);
}





-(UIImageView*) addTakeImage:(UIView*) view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView* imageView = [[UIImageView alloc] initWithImage:img];
    return imageView;
    
    
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Create data for collection views
    NSMutableArray *firstSection = [[NSMutableArray alloc] init];
    NSMutableArray *secondSection = [[NSMutableArray alloc] init];
    
    for (int i=0; i<15; i++) {
        [firstSection addObject:[NSString stringWithFormat:@"Cell %d", i]];
        [secondSection addObject:[NSString stringWithFormat:@"item %d", i]];
    }
	// Do any additional setup after loading the view.
    self.dataArray = [[NSArray alloc] initWithObjects:firstSection, nil];
    
    /* Uncomment this block to use nib-based cells */
   // UINib *cellNib = [UINib nibWithNibName:@"NibCell" bundle:nil];
   // [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"cvCell"];
    /* end of nib-based cells block */
    
    /* uncomment this block to use subclassed cells */
     [self.collectionView registerClass:[CVCell class] forCellWithReuseIdentifier:@"cvCell"];
    /* end of subclass-based cells block */
    
    // Configure layout
    MyFlowLayout *flowLayout = [[MyFlowLayout alloc] init];
    
    /// NB hard coded
    [flowLayout setItemSize:CGSizeMake(320, 600)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [self.collectionView setCollectionViewLayout:flowLayout];
    
     /* this was not used */
    // THSpringyFlowLayout * flowLayout2 = [[THSpringyFlowLayout alloc] init];
    
    _myView.userInteractionEnabled = YES;
    _myView.anyView = self.view;
    
    _collection.delegate = self;
    
 
    
    
}


-(IBAction)handlePinch:(UIPinchGestureRecognizer*)sender
{
    
    MyFlowLayout *flowLayout = [[MyFlowLayout alloc] init];
    
    // NB hard coded size
    [flowLayout setItemSize:CGSizeMake(320, 600)];
    flowLayout.scaleValue = sender.scale;
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    // NB not sure why this check is here
    /* 
     commend out should still work fine.
    if(scrollView.contentOffset.y <=5)
    {
        _myView.userInteractionEnabled = YES;
    }
     
     */
    
    /*
     comment out shoul work fine
    CGPoint scrollVelocity = [_collection.panGestureRecognizer velocityInView:_collection.superview];
    if (scrollVelocity.y > 0.0f)
        NSLog(@"going down");
    else if (scrollVelocity.y < 0.0f)
        NSLog(@"going up");
     */
    
  
}




-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.dataArray count];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSMutableArray *sectionArray = [self.dataArray objectAtIndex:section];
    return [sectionArray count];
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Setup cell identifier
    static NSString *cellIdentifier = @"cvCell";

    NSMutableArray *data = [self.dataArray objectAtIndex:indexPath.section];
    
       NSString *cellData = [data objectAtIndex:indexPath.row];
       UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    
 
        UILabel *titleLabel = (UILabel *)[cell viewWithTag:100];
       [titleLabel setText:cellData];
    /*
     CAN Delete
     if(indexPath.row % 2 ==0)
      cell.backgroundColor = [UIColor whiteColor];
    else
      cell.backgroundColor = [UIColor grayColor];
    
   
    if(indexPath.row==2)
         cell.backgroundColor = [UIColor redColor];
     */
 
    
    return cell;
    
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)cv viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
