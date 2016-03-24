//
//  IGJSONKIt.m
//  SIEWPT
//
//  Created by GavinHe on 16/3/23.
//
//

#import "IGJSONKIt.h"

@implementation IGJSONKIt

@end


@implementation NSString (IGJSONKitDeserializing)
- (id)objectFromJSONString{
    NSError *error = nil;
    return [self objectFromJSONStringWithError:&error];
}

- (id)objectFromJSONStringWithError:(NSError**)error{
    id obj = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:error];
    if (*error) {
        NSLog(@"string [%@] trans to JSONObject Failed: %@",self,*error);
    }else{
        return obj;
    }
    return nil;
}

- (id)mutableObjectFromJSONString{
    NSError *error = nil;
    // NSJSONSerialization 返回的obj全部系可变的
    return [self objectFromJSONStringWithError:&error];
}

@end

@implementation NSData (IGJSONKitDeserializing)
- (id)objectFromJSONData{
    NSError *error = nil;
    return [self objectFromJSONDataWithError:&error];
}
- (id)objectFromJSONDataWithError:(NSError**)error{
    id obj = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableContainers error:error];
    if (*error) {
        NSLog(@"data [%@] trans to JSONObject Failed: %@",self,*error);
    }else{
        return obj;
    }
    return nil;
}
- (id)mutableObjectFromJSONData{
    NSError *error = nil;
    return [self objectFromJSONDataWithError:&error];
}

@end


@implementation NSString (IGJSONKitSerializing)
- (NSData *)JSONData{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}
- (NSString *)JSONString{
    return self;
}
@end

@implementation NSArray (IGJSONKitSerializing)
- (NSData *)JSONData{
    NSError *error = nil;
    return [self JSONDataWithError:&error];
}
- (NSData *)JSONDataWithError:(NSError**)error{
    BOOL isValid = [NSJSONSerialization isValidJSONObject:self];
    if (isValid) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:error];
        if (*error) {
            NSLog(@"array [%@] trans to JSONData failed : %@",self,*error);
        }else{
            return jsonData;
        }
    }else{
        NSLog(@"array [%@] trans to JSONData failed : dont valid",self);
        *error = [NSError errorWithDomain:@"com.gavin.IGJSONKit"
                                     code:666
                                 userInfo:@{
                                            NSLocalizedDescriptionKey : @"dont valid"
                                            }];
    }
    return nil;

}
- (NSString *)JSONString{
    NSError *error = nil;
    return [self JSONStringWithError:&error];
}
- (NSString *)JSONStringWithError:(NSError**)error{
    BOOL isValid = [NSJSONSerialization isValidJSONObject:self];
    if (isValid) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:error];
        if (*error) {
            NSLog(@"array [%@] trans to JSONString failed : %@",self,*error);
        }else{
            return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
    }else{
        NSLog(@"array [%@] trans to JSONString failed : dont valid",self);
        *error = [NSError errorWithDomain:@"com.gavin.IGJSONKit"
                                     code:666
                                 userInfo:@{
                                            NSLocalizedDescriptionKey : @"dont valid"
                                            }];
    }
    return nil;
}
@end

@implementation NSDictionary (IGJSONKitSerializing)
- (NSData *)JSONData{
    NSError *error = nil;
    return [self JSONDataWithError:&error];
}
- (NSData *)JSONDataWithError:(NSError**)error{
    BOOL isValid = [NSJSONSerialization isValidJSONObject:self];
    if (isValid) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:error];
        if (*error) {
            NSLog(@"dict [%@] trans to JSONData failed : %@",self,*error);
        }else{
            return jsonData;
        }
    }else{
        NSLog(@"dict [%@] trans to JSONData failed : dont valid",self);
        *error = [NSError errorWithDomain:@"com.gavin.IGJSONKit"
                                     code:666
                                 userInfo:@{
                                            NSLocalizedDescriptionKey : @"dont valid"
                                            }];
    }
    return nil;
    
}
- (NSString *)JSONString{
    NSError *error = nil;
    return [self JSONStringWithError:&error];
}
- (NSString *)JSONStringWithError:(NSError**)error{
    BOOL isValid = [NSJSONSerialization isValidJSONObject:self];
    if (isValid) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:error];
        if (*error) {
            NSLog(@"dict [%@] trans to JSONString failed : %@",self,*error);
        }else{
            return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
    }else{
        NSLog(@"dict [%@] trans to JSONString failed : dont valid",self);
        *error = [NSError errorWithDomain:@"com.gavin.IGJSONKit"
                                     code:666
                                 userInfo:@{
                                            NSLocalizedDescriptionKey : @"dont valid"
                                            }];
    }
    return nil;
}

@end
