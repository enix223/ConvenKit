//
//  UIFont+ConventKit.m
//  ConvenKit
//
//  Created by Enix Yu on 10/2/2017.
//  Copyright © 2017 RobotBros. All rights reserved.
//

#import "UIFont+ConventKit.h"
#import <CoreText/CoreText.h>

@implementation UIFont (ConventKit)

#pragma MARK -
#pragma MARK - Register Font

+ (void)registerFontFromURLString:(NSString *)urlString
                       completion:(void (^)(BOOL success, NSString * _Nullable fontName, NSError * _Nullable error))completion {
    NSURL *url = [NSURL URLWithString:urlString];
    [UIFont registerFontFromURL:url completion:completion];
}

+ (void)registerFontFromURL:(NSURL *)url
                 completion:(void (^)(BOOL success, NSString * _Nullable fontName, NSError *  _Nullable error))completion {
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionDataTask *task = [session
                                  dataTaskWithRequest:req
                                  completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                      if (error) {
                                        completion(NO, nil, error);
                                        return;
                                      }

                                      CFErrorRef aError;
                                      CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)data);
                                      CGFontRef font = CGFontCreateWithDataProvider(provider);
                                      
                                      NSString *fontName;
                                      NSError *cError;
                                      if ( !CTFontManagerRegisterGraphicsFont(font, &aError) ) {
                                          // failed
                                          fontName = nil;
                                          cError = (__bridge NSError *)aError;
                                      } else {
                                          fontName = (__bridge NSString *)CGFontCopyFullName(font);
                                          cError = nil;
                                      }
                                      
                                      if (font != nil) {
                                          CFRelease(font);
                                      }
                                      
                                      CFRelease(provider);
                                      completion(fontName != nil, fontName, cError);
                                  }];
    [task resume];
}

+ (NSString *)registerAndGetFontNameWithRawData:(NSData *)data error:(NSError ** _Nullable)error {
    CFErrorRef aError;
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)data);
    CGFontRef font = CGFontCreateWithDataProvider(provider);
    
    if ( !CTFontManagerRegisterGraphicsFont(font, &aError) ) {
        NSError *cError = (__bridge NSError *)aError;
        *error = cError;
        return nil;
    }

    NSString *fontName = (__bridge NSString *)CGFontCopyFullName(font);
    CFRelease(font);
    CFRelease(provider);
    
    return fontName;
}

@end
