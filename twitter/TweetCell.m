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
    NSLog(@"%@, %@", tweet.username, tweet.text);
    self.textLabel.text = tweet.text;
    self.userNameLabel.text = tweet.username;
    self.dateLabel.text = tweet.createdDate;
    
    NSURL * imageURL = [NSURL URLWithString:tweet.profilePicUrl];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];
    [self.profileImageView setImage:image];
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
