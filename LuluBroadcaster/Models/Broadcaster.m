//
//  BroadcasterModel.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/13/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "Broadcaster.h"
#import <KZPropertyMapper/KZPropertyMapper.h>
@implementation Broadcaster

+ (Broadcaster* _Nonnull)broadcasterWithJSON:(id _Nonnull)data{
    Broadcaster* broadcaster = [[Broadcaster alloc] init];
    [broadcaster doMappingWithData:data];
    return broadcaster;
}

+ (Broadcaster* _Nonnull)broadcasterPHPWithJSON:(id _Nonnull)data{
    Broadcaster* broadcaster = [[Broadcaster alloc] init];
    [broadcaster doMappingWithPHPData:data];
    return broadcaster;
}

- (instancetype)init{
    self.name = @"";
    self.email = @"";
    self.wowzaUri = @"";
    self.wowzaLogin = @"";
    self.wowzaPassword = @"";
    self.profileImageURL = @"";
    self.danmuPassword = @"";
    self.room = @"";
    self.viewers_count = 0;
    self.followers_count = 0;
    self.wealth = 0;
    self.bio = @"";
    return [super init];
}

- (void)doMappingWithData: (id)data{
    NSDictionary* mapping = @{@"name": KZProperty(name),
                              @"user_name": KZProperty(email),
                              @"stream_link": KZProperty(wowzaUri),
                              @"wowzaLogin":KZProperty(wowzaLogin),
                              @"wowzaPassword":KZProperty(wowzaPassword),
                              @"avatar":KZProperty(profileImageURL),
                              @"danmu_password":KZProperty(danmuPassword),
                              @"id":KZProperty(room),
                              @"bio":KZProperty(bio),
                              @"viewers_count":KZProperty(viewers_count),
                              @"followers_count":KZProperty(followers_count),
                              @"wealth":KZProperty(wealth)
                              };
    [KZPropertyMapper mapValuesFrom:data toInstance:self usingMapping:mapping];
}

- (void)doMappingWithPHPData: (id)data{
    NSDictionary* mapping = @{@"name": KZProperty(name),
                              @"stream_link": KZProperty(wowzaUri),
                              @"avatar":KZProperty(profileImageURL),
                              @"danmu_password":KZProperty(danmuPassword),
                              @"id":KZProperty(room),
                              @"viewers_count":KZProperty(viewers_count),
                              @"followers_count":KZProperty(followers_count),
                              @"wealth":KZProperty(wealth)
                              };
    [KZPropertyMapper mapValuesFrom:data toInstance:self usingMapping:mapping];
}


@end
