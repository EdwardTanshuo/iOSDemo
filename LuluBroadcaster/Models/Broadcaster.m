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

- (instancetype)init{
    self.name = @"";
    self.email = @"";
    self.wowzaUri = @"";
    self.wowzaLogin = @"";
    self.wowzaPassword = @"";
    self.profileImageURL = @"";
    self.danmuPassword = @"";
    self.room = @"";
    
    return [super init];
}

- (void)doMappingWithData: (id)data{
    NSDictionary* mapping = @{@"name": KZProperty(name),
                              @"email": KZProperty(email),
                              @"wowzaUri": KZProperty(wowzaUri),
                              @"wowzaLogin":KZProperty(wowzaLogin),
                              @"wowzaPassword":KZProperty(wowzaPassword),
                              @"profileImageURL":KZProperty(profileImageURL),
                              @"danmuPassword":KZProperty(danmuPassword),
                              @"_id":KZProperty(room)
                              };
    [KZPropertyMapper mapValuesFrom:data toInstance:self usingMapping:mapping];
}
@end
