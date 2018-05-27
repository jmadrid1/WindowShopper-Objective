
#import "ItemDetailVC.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <FirebaseDatabase/FirebaseDatabase.h>
#import "Review.h"
#import "Reachability.h"
#import "ItemReviewsVC.h"

@interface ItemDetailVC ()

@end

@implementation ItemDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mRef = [[FIRDatabase database] reference];
    
    _mItemTitleLabel.font = [UIFont systemFontOfSize: 17];
    _mReviewsLabel.font = [UIFont systemFontOfSize: 17];
    _mItemDescriptionTextView.font = [UIFont systemFontOfSize: 14];
    _mSizeLabel.font = [UIFont systemFontOfSize: 17];
    _mQuantityLabel.font = [UIFont systemFontOfSize: 17];
   
    _mItemImage.frame = CGRectMake(46, 96, 316, 336);
    _mPriceView.frame = CGRectMake(297, 417, 64, 24);
    _mPriceLabel.frame = CGRectMake(1, 3, 63, 21);
    _mItemTitleLabel.frame = CGRectMake(23, 450, 132, 21);
    _mReviewsLabel.frame = CGRectMake(276, 450, 86, 20);
    _mItemDescriptionTextView.frame = CGRectMake(17, 476, 382, 73);
    _mSizeSegment.frame = CGRectMake(163, 560, 164, 29);
    _mQuantityStepper.frame = CGRectMake(234, 596, 94, 29);
    _mButtonView.frame = CGRectMake(23, 639, 371, 32);
    _mCartButton.frame = CGRectMake(0, -1, 371, 34);
    
    [_mCartButton setTitle: @"Add To Cart" forState: normal];
    
//    _mButtonView.backgroundColor
//    _mPriceView.backgroundColor
    
//    _mSizeSegment.tintColor =
//    _mQuantityStepper.tintColor =
    
//    _mReviewsLabel.textColor =
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(segueToReviews:)];
    [_mReviewsLabel setUserInteractionEnabled:true];
    [_mReviewsLabel addGestureRecognizer:tapGesture];
    
    _mCurrentQuantityXS = [_mSelectedItem.sizes[@"xs"] intValue];
    _mCurrentQuantityS = [_mSelectedItem.sizes[@"s"] intValue];
    _mCurrentQuantityM = [_mSelectedItem.sizes[@"m"] intValue];
    _mCurrentQuantityL = [_mSelectedItem.sizes[@"l"] intValue];
    _mCurrentQuantityXL = [_mSelectedItem.sizes[@"xl"] intValue];

    NSString *url = _mSelectedItem.image;
    [_mItemImage sd_setImageWithURL:[NSURL URLWithString: url] placeholderImage: [UIImage imageNamed: @"placeholder.png"]];
    
    _mItemTitleLabel.text = _mSelectedItem.title;
    [_mItemTitleLabel sizeToFit];
    _mPriceLabel.text = [NSString stringWithFormat: @"$%.2f", _mSelectedItem.price];
    _mItemDescriptionTextView.text = _mSelectedItem.summary;
    
    _mQuantityLabel.text = @"Quantity:   0";
    
    [self getItemReviewsCount];
    
    [self disableZeroQuantitySegments];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(BOOL)isNetworkAvailable {
    return [[Reachability reachabilityWithHostName:@"www.google.com"] currentReachabilityStatus];
}

-(void)showNoNetworkConnectionAlert{
    if ([self isNetworkAvailable] == NotReachable) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Check Network Connection" message:@"Please check internet connection and try again." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            // Ok action here
        }];
        
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (IBAction)sizeSegmentSelected:(UISegmentedControl *)sender {
    
    switch (_mSizeSegment.selectedSegmentIndex) {
        case 0:
            _mSelectedSize = @"XS";
            break;
        case 1:
            _mSelectedSize = @"S";
            break;
        case 2:
            _mSelectedSize = @"M";
            break;
        case 3:
            _mSelectedSize = @"L";
            break;
        case 4:
            _mSelectedSize = @"XL";
            break;
            
        default:
            _mSelectedSize = @"S";
            break;
    }
}

-(void)disableZeroQuantitySegments{
    
    if(_mCurrentQuantityXS == 0){
            [_mSizeSegment setEnabled:false forSegmentAtIndex: 0];
    }
    
    if(_mCurrentQuantityS == 0){
            [_mSizeSegment setEnabled:false forSegmentAtIndex: 1];
    }
   
    if(_mCurrentQuantityM == 0){
            [_mSizeSegment setEnabled:false forSegmentAtIndex: 2];
    }

    if(_mCurrentQuantityL == 0){
        [_mSizeSegment setEnabled:false forSegmentAtIndex: 3];
    }
    
    if(_mCurrentQuantityXL == 0){
        [_mSizeSegment setEnabled:false forSegmentAtIndex: 4];
    }
}

- (IBAction)quantitySteps:(UIStepper *)sender {
    //Learn how to convert double into NSInteger
//    _mSelectedQuantity = sender.value;
    _mQuantityLabel.text = [NSString stringWithFormat: @"Quantity:   %.f", sender.value];
    [_mQuantityLabel sizeToFit];
}

-(void)getItemReviewsCount{

    int id = _mSelectedItem.id;
    NSString *idString = [NSString stringWithFormat: @"%d", id];

    NSMutableArray *containerList = [NSMutableArray array];
    
    if([self isNetworkAvailable]){
        
        [[[[_mRef child: @"inventory"] child: idString] child:@"reviews"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
            
            for(snapshot in snapshot.children){
                
                NSDictionary *reviewDict = snapshot.value;
                
                int id = [reviewDict[@"id"] intValue];
                NSString *comment = reviewDict[@"comment"];
                int rating = [reviewDict[@"rating"] intValue];
                NSString *date = reviewDict[@"specifics"];
                
                Review *review = [[Review alloc]init];
                
                review.id = id;
                review.comment = comment;
                review.rating = rating;
                review.date = date;
                
                [containerList addObject: review];
                
                [self updateReviewCount: containerList.count];
            }
        }];
    }else{
        [self showNoNetworkConnectionAlert];
    }
}

-(void)updateReviewCount:(NSInteger)count {
    _mReviewsLabel.text = [NSString stringWithFormat: @"Reviews(%ld)", (long)count];
    [_mReviewsLabel sizeToFit];
}

-(void)segueToReviews:(UITapGestureRecognizer *)tap{
    [self performSegueWithIdentifier: @"itemReviewSegue" sender: _mSelectedItem];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"itemReviewSegue"]){
        ItemReviewsVC *vc = segue.destinationViewController;
        Clothes *item = sender;
        vc.mSelectedItem = item;
    }
}

-(IBAction)addToCart {
    
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey: @"uid"];
    
    int id = _mSelectedItem.id;
    NSString *idString = [NSString stringWithFormat:@"%d", id];
    NSString *title = _mSelectedItem.title;
    NSString *price = [NSString stringWithFormat:@"%.2f", _mSelectedItem.price];
    NSString *size = _mSelectedSize;
    NSString *quantity = [NSString stringWithFormat:@"%.f", _mQuantityStepper.value];

    if([self isNetworkAvailable]){
    
        NSDictionary *values = @{@"uid": userId,
                               @"title": title,
                               @"price": price,
                                 @"size": size,
                                 @"quantity": quantity};

        [[[[[_mRef child: @"users"] child: userId] child: @"cart"] child: idString] setValue: values];
    }else{
        [self showNoNetworkConnectionAlert];
    }
}

@end
