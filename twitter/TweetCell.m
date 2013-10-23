//
//  TweetCell.m
//  twitter
//
//  Created by Timothy Lee on 8/6/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TweetCell.h"


@implementation TweetCell

- (void) initWithTweet:(Tweet *)tweet
{
    //initialize cell ui with data from the tweet
    self.textLabel.text = tweet.text;
    self.userNameLabel.text = [NSString stringWithFormat:@"%@ @%@",tweet.username,tweet.screenName];
    self.dateLabel.text = tweet.createdDate;
    
    NSURL * imageURL = [NSURL URLWithString:tweet.profilePicUrl];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];
    
    [self.profileImageView setImage:image];
}

// instance function to determine this cell's height
- (CGFloat) cellHeight
{
    //set the string in the label
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:self.textLabel.text attributes:@{NSFontAttributeName: self.textLabel.font}];
    
    //get the rendered label size
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){self.textLabel.frame.size.width, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    CGSize labelSize = rect.size;
    
    //cellHeight is top margin + image height + mid margin + label height + filler
    CGFloat height = ceilf(4.0f + 48.0f + 4.0f + labelSize.height + 2.0f);
    
    return height;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
