//
//  Tweet.h
//  twitter
//
//  Created by Timothy Lee on 8/5/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : RestObject

@property (nonatomic, strong, readonly) NSString *text;
@property (nonatomic, strong) NSString *tweetId;
@property (nonatomic, strong) NSString *favorited;
@property (nonatomic, strong) NSString *retweeted;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profilePicUrl;
@property (nonatomic, strong) NSString *createdDate;

+ (NSMutableArray *)tweetsWithArray:(NSArray *)array;

@end
