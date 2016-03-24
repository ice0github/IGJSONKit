//
//  IGJSONKIt.h
//  SIEWPT
//
//  Created by GavinHe on 16/3/23.
//
//

#import <Foundation/Foundation.h>

#import <Foundation/NSArray.h>
#import <Foundation/NSData.h>
#import <Foundation/NSDictionary.h>
#import <Foundation/NSError.h>
#import <Foundation/NSString.h>

@interface IGJSONKIt : NSObject

@end

@interface NSString (IGJSONKitDeserializing)
- (id)objectFromJSONString;
- (id)objectFromJSONStringWithError:(NSError**)error;
- (id)mutableObjectFromJSONString;
@end

@interface NSData (IGJSONKitDeserializing)
- (id)objectFromJSONData;
- (id)objectFromJSONDataWithError:(NSError**)error;
- (id)mutableObjectFromJSONData;
@end

@interface NSString (IGJSONKitSerializing)
- (NSData *)JSONData;
- (NSString *)JSONString;
@end

@interface NSArray (IGJSONKitSerializing)
- (NSData *)JSONData;
- (NSData *)JSONDataWithError:(NSError**)error;
- (NSString *)JSONString;
- (NSString *)JSONStringWithError:(NSError**)error;
@end

@interface NSDictionary (IGJSONKitSerializing)
- (NSData *)JSONData;
- (NSData *)JSONDataWithError:(NSError**)error;
- (NSString *)JSONString;
- (NSString *)JSONStringWithError:(NSError**)error;

@end

