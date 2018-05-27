
#import "ReviewCell.h"

@implementation ReviewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _mDateLabel.font = [UIFont systemFontOfSize: 14];
    _mCommentTextView.font = [UIFont systemFontOfSize: 14];
    
    _mDateLabel.frame = CGRectMake(297, -1, 85, 21);
    _mCommentTextView.frame = CGRectMake(13, 18, 401, 66);
    
    _mRatingScale.minimumValue = 1;
    _mRatingScale.maximumValue = 5;
    [_mRatingScale setUserInteractionEnabled: FALSE];
    
    [_mCommentTextView setEditable: FALSE];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
