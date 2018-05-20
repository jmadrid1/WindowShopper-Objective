
#import "AddReviewVC.h"
#import <FirebaseDatabase/FirebaseDatabase.h>
#import "Reachability.h"

@interface AddReviewVC ()

@end

@implementation AddReviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mRef = [[FIRDatabase database] reference];

    _mIconImage.frame = CGRectMake(137, 167, 140, 128);
    _mCommentTextField.frame = CGRectMake(83, 310, 276, 102);
    _mSubmitButton.frame = CGRectMake(157, 469, 101, 30);
    
    _mIconImage.image = [UIImage imageNamed: @"ic_add_review.png"];
    
    [_mCommentTextField setBorderStyle: UITextBorderStyleRoundedRect];
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

//Add rating scale and its value.
-(IBAction)submitReview{
    
    int id = _mItemId;
    NSString *idString = [NSString stringWithFormat:@"%d", id];

    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey: @"uid"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat: @"MM-dd-yyyy"];
    
    NSString *date = [dateFormatter stringFromDate: [NSDate date]];
    NSString *comment = _mCommentTextField.text;
    
//    if([self isNetworkAvailable]){
//
//            NSDictionary *values = @{@"id": id,
//                                     @"uid": userId,
//                                     @"comment": comment,
//                                     @"rating": rating,
//                                     @"date": date};
//
//            [[[[[_mRef child: @"inventory"] child: @""] child: @"reviews"] childByAutoId] setValue: values];
//    }else{
//        [self showNoNetworkConnectionAlert];
//    }
}


@end
