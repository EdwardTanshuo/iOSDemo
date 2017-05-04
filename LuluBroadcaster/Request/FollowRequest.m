//
//  FollowRequest.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 4/10/17.
//  Copyright © 2017 ShuoTan. All rights reserved.
//

#import "FollowRequest.h"
#import "UserSession.h"

@implementation FollowRequest
+ (FollowRequest* _Nullable)sharedRequest{
    static FollowRequest *sharedMyRequest = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyRequest = [[self alloc] init];
    });
    return sharedMyRequest;
}

- (void)fetchFollowWithCompletion: (void (^_Nullable)(NSArray<User* >*  _Nullable, NSError * _Nullable))complete{
    NSString* broadcaster_id = [UserSession new].currentBroadcaster.room;
    NSDictionary* params = @{@"broadcaster_id": broadcaster_id};
    [self postWithURL:[self phpUrlByService:@"followers"] Parameters:params Success:^(id  _Nullable responseObject) {
        id jsonObj = responseObject[@"result"][@"follow_list"];
        if(jsonObj && [jsonObj isKindOfClass:[NSArray class]]){
            NSMutableArray* temp_array = [NSMutableArray new];
            for(id iter in jsonObj){
                User* user = [User followerWithJSON:iter];
                [temp_array addObject:user];
            }
            complete(temp_array, nil);
        }
        else{
            complete(@[], nil);
        }

    } Failure:^(NSError * _Nonnull error) {
        complete(@[], error);
    }];
}
@end
