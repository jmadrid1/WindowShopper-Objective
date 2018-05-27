
#import <UIKit/UIKit.h>
#import <HCSStarRatingView/HCSStarRatingView.h>

@interface ReviewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet HCSStarRatingView *mRatingScale;
@property (weak, nonatomic) IBOutlet UILabel *mDateLabel;

@property (weak, nonatomic) IBOutlet UITextView *mCommentTextView;


@end
