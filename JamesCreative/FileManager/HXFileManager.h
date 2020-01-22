//
//  HXFileManager.h
//  ParentDemo
//
//  Created by James on 2019/7/29.
//  Copyright © 2019 DaHuanXiong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompletionHandler)(NSString * _Nonnull pathStr, NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface HXFileManager : NSObject

@property (nonatomic, strong, readonly) NSFileManager  *fileManager;

+ (instancetype)fileManager;

+ (id _Nullable)loadOjbectFromPath:(NSString *)path class:(Class)objectClass;

+ (BOOL)saveOjbect:(NSObject *)object withPath:(NSString *)path error:(NSError **)error;;

+ (void)asyncSaveOjbect:(NSObject *)object withPath:(NSString *)path completion:(CompletionHandler)completion;


+ (BOOL)createDirectory:(NSString *)directoryPathStr error:(NSError **)error;

+ (BOOL)createFile:(NSString *)filePathStr error:(NSError **)error;


+ (void)writeToFile:(NSString *)filePathStr
               data:(NSData *)data
        synchronous:(BOOL)synchronous
         completion:(CompletionHandler _Nullable)completion;

+ (NSData * _Nullable)readFileData:(NSString *)filePathStr;

//bytes
+ (long long)getFileSize:(NSString*) filePathStr;


+ (BOOL)removeFile:(NSString *)filePathStr error:(NSError **)error;

+ (void)asynRemoveFile:(NSString *)filePathStr error:(NSError **)error;


+ (NSString *)docPathStr;

+ (NSString *)libraryPathStr;

+ (NSString *)cachePathStr;

+ (NSString *)tmpPathStr;


@end

NS_ASSUME_NONNULL_END
