//
//  URLHelper.h
//  Pods
//
//  Created by Reminisce on 2016/12/6.
//
//

#import <Foundation/Foundation.h>

@interface URLHelper : NSObject

+ (NSString *) urlEncoding:(NSString *)URL;

+ (NSString *) urlDecoding:(NSString *)URL;

+ (NSString *) makeAppUrl:(NSDictionary *)params;

+ (NSDictionary *) getDicFromUrl:(NSString *)url;

+(void)actionWithURL:(NSString *)url withViewController:(UIViewController *)controller;

@end
