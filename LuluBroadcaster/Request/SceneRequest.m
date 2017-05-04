//
//  SceneRequest.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 4/26/17.
//  Copyright © 2017 ShuoTan. All rights reserved.
//

#import "SceneRequest.h"
#import "UserSession.h"

@implementation SceneRequest
+ (SceneRequest* _Nullable)sharedRequest{
    static SceneRequest *sharedMyRequest = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyRequest = [[self alloc] init];
    });
    return sharedMyRequest;
}

- (void)fetchScenesWithCompletion: (void (^_Nullable)(NSArray<Record* >*  _Nullable, NSError * _Nullable))complete{
    NSString* broadcaster_id = [UserSession new].currentBroadcaster.room;
    NSDictionary* params = @{@"broadcaster_id": broadcaster_id};
    [self postWithURL:[self phpUrlByService:@"scenes"] Parameters:params Success:^(id  _Nullable responseObject) {
        id jsonObj = responseObject[@"result"][@"scene_list"];
        if(jsonObj && [jsonObj isKindOfClass:[NSArray class]]){
            NSMutableArray* temp_array = [NSMutableArray new];
            for(id iter in jsonObj){
                Record* record = [Record recordWithJSON:iter];
                [temp_array addObject:record];
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
