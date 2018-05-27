
#import "AddReviewVC.h"
#import <FirebaseDatabase/FirebaseDatabase.h>
#import "Reachability.h"
#import <HCSStarRatingView/HCSStarRatingView.h>

@interface AddReviewVC ()

@end

@implementation AddReviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mRef = [[FIRDatabase database] reference];
    
    _mIconImage.frame = CGRectMake(137, 167, 140, 128);
    _mRatingScale.frame = CGRectMake(128.81, 300, 156, 46);
    _mCommentTextField.frame = CGRectMake(68.22, 365, 276, 102);
    _mSubmitButton.frame = CGRectMake(155.61, 527, 101, 30);
    
    _mIconImage.image = [UIImage imageNamed: @"ic_add_review.png"];
    
    _mRatingScale.minimumValue = 1;
    _mRatingScale.maximumValue = 5;
    _mRatingScale.value = 3;
    
    _mCommentTextField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    _mCommentTextField.returnKeyType = UIReturnKeyDone;
    [_mCommentTextField setBorderStyle: UITextBorderStyleRoundedRect];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return TRUE;
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


-(IBAction)submitReview{
    
    int id = _mItemId;
    NSString *idString = [NSString stringWithFormat:@"%d", id];
    
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey: @"uid"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat: @"MM-dd-yyyy"];
    
    NSString *date = [dateFormatter stringFromDate: [NSDate date]];
    NSString *comment = _mCommentTextField.text;
    
    double ratingDouble = _mRatingScale.value;
    int rating = (int)ratingDouble;

    if([self isNetworkAvailable]){

        NSDictionary *values = @{@"id": idString,
                                    @"uid": userId,
                                    @"comment": comment,
                                    @"rating": @(rating),
                                    @"date": date};

        [[[[[_mRef child: @"inventory"] child: idString] child: @"reviews"] childByAutoId] setValue: values];
        [[self navigationController] popViewControllerAnimated: TRUE];
    }else{
        [self showNoNetworkConnectionAlert];
    }
}


@end
