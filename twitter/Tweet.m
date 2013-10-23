//
//  Tweet.m
//  twitter
//
//  Created by Timothy Lee on 8/5/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

static NSDateFormatter *tweetDateFormatter = nil;

- (NSString *)tweetId {
    return [self.data valueOrNilForKeyPath:@"id"];
}

- (BOOL)isFavorited {
    NSNumber *val = [self.data valueOrNilForKeyPath:@"favorited"];
    return [val boolValue];
}

- (BOOL)isRetweeted {
    NSNumber *val = [self.data valueOrNilForKeyPath:@"retweeted"];
    return [val boolValue];
}

- (NSString *)text {
    return [self.data valueOrNilForKeyPath:@"text"];
}

- (NSString *)username {
    return [self.data valueOrNilForKeyPath:@"user.name"];
}

- (NSString *)screenName {
    return [self.data valueOrNilForKeyPath:@"user.screen_name"];
}

- (NSString *)profilePicUrl {
    return [self.data valueOrNilForKeyPath:@"user.profile_image_url"];
}

- (NSString *)createdDate {
    
    static NSDateFormatter *tweetDateFormatter = nil;
    
    if (tweetDateFormatter == nil)
    {
        tweetDateFormatter = [[NSDateFormatter alloc] init];
        [tweetDateFormatter setDateFormat:@"EEE MMM d h:m:s +0000 yyyy"];
        [tweetDateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    }
    
    //format: "Mon Oct 21 02:13:40 +0000 2013"
    NSString *createdDateString = [self.data valueOrNilForKeyPath:@"created_at"];
    
    NSDate *createdDate = [tweetDateFormatter dateFromString:createdDateString];
    
    //return localized time
    if (createdDate != nil) {
        return [NSDateFormatter localizedStringFromDate:createdDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
    }
    
    //return empty string in case of error
    return createdDateString;
}

+ (NSMutableArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *params in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:params]];
    }
    return tweets;
}

@end
