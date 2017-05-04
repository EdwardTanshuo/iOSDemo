//
//  User.m
//  LuluBroadcaster
//
//  Created by ShuoTan on 11/20/16.
//  Copyright © 2016 ShuoTan. All rights reserved.
//

#import "User.h"
#import <KZPropertyMapper/KZPropertyMapper.h>

@implementation User
+ (User* _Nonnull) userWithJSON:(id _Nonnull)data{
    User* user = [[User alloc] init];
    [user doMappingWithData:data];
    return user;
}

+ (User* _Nonnull) followerWithJSON:(id _Nonnull)data{
    User* user = [[User alloc] init];
    [user doMappingWithFollowerData:data];
    return user;
}

- (instancetype)init{
    self.avatar = @"";
    self.name = @"";
    self.foreignId = 0;
    self.uid = @"";
    self.intimacy = @"";
    self.level = @"";
    return [super init];
}


- (void)doMappingWithData: (id)data{
    NSDictionary* mapping = @{@"_id": KZProperty(uid),
                              @"foreignId": KZProperty(foreignId),
                              @"avatar": KZProperty(avatar),
                              @"name": KZProperty(name),
                              };
    [KZPropertyMapper mapValuesFrom:data toInstance:self usingMapping:mapping];
}

- (void)doMappingWithFollowerData: (id)data{
    NSDictionary* mapping = @{@"user_id": KZProperty(uid),
                              @"sex": KZProperty(sex),
                              @"avatar": KZProperty(avatar),
                              @"username": KZProperty(name),
                              @"level": KZProperty(level),
                              @"intimacy": KZProperty(intimacy)
                              };
    [KZPropertyMapper mapValuesFrom:data toInstance:self usingMapping:mapping];
}
@end
