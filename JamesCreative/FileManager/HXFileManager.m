//
//  HXFileManager.m
//  ParentDemo
//
//  Created by James on 2019/7/29.
//  Copyright © 2019 DaHuanXiong. All rights reserved.
//

#import "HXFileManager.h"

@interface HXFileManager()

@property (nonatomic, strong) NSFileManager  *fileManager;
@property (nonatomic, strong) dispatch_queue_t  fileQueue;
@property (nonatomic, strong) dispatch_queue_t  archiveQueue;

@end

@implementation HXFileManager
#pragma mark - Life Cycle
+ (instancetype)fileManager {
    static HXFileManager *manage;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manage = [[HXFileManager alloc] init];
    });
    return manage;
}

#pragma mark - System Method

#pragma mark - Public Method
+ (id)loadOjbectFromPath:(NSString *)path class:(Class)objectClass
{
    NSObject *object = nil;
    @try {
        NSData *data = [self readFileData:path];
        if (!data) {
            return nil;
        }
        if (@available(iOS 11.0, *)) {
            object = [NSKeyedUnarchiver unarchivedObjectOfClass:objectClass fromData:data error:nil];
        } else {
            object = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        }
    } @catch (NSException *exception) {
        object = nil;
    } @finally {
    }
    return object;
}

+ (BOOL)saveOjbect:(NSObject *)object withPath:(NSString *)path error:(NSError * _Nullable __autoreleasing *)error {
    
    if (![object conformsToProtocol:@protocol(NSSecureCoding)]) {
        NSError *innerError = [[NSError alloc] initWithDomain:@"data don't conform NSSecureCoding" code:0 userInfo:nil];
        *error = innerError;
        return NO;
    }
    
    
    BOOL result = [self createFile:path error:error];
    
    if (result) {
        NSData *data = nil;
        if (@available(iOS 11.0, *)) {
           data = [NSKeyedArchiver archivedDataWithRootObject:object requiringSecureCoding:YES error:error];
            if (!(*error)) {
               return [data writeToFile:path atomically:YES];
            }
            return NO;
            
        } else {
            if ([NSKeyedArchiver archiveRootObject:object toFile:path]) {
                return YES;
            }
            
            NSError *innerError = [[NSError alloc] initWithDomain:@"NSKeyedArchiver archiveRootObject method fail" code:0 userInfo:nil];
            *error = innerError;
            return NO;
        }
    }
    
    NSError *innerError = [[NSError alloc] initWithDomain:@"file create fail" code:0 userInfo:nil];
    *error = innerError;
    
    return NO;
}

+ (void)asyncSaveOjbect:(NSObject *)object withPath:(NSString *)path completion:(CompletionHandler)completion {
    dispatch_async([HXFileManager fileManager].archiveQueue, ^{
        NSError *error;
        [self saveOjbect:object withPath:path error:&error];
        if (completion) {
            completion(path, error);
        }
    });
}

+ (BOOL)createDirectory:(NSString *)directoryPathStr error:(NSError * _Nullable __autoreleasing *)error {
    if (directoryPathStr.length==0) {
        return NO;
    }
    NSFileManager *fileManager = [HXFileManager fileManager].fileManager;
    BOOL isSuccess = YES;
    BOOL isExist = [fileManager fileExistsAtPath:directoryPathStr];
    if (isExist == NO) {
        if (![fileManager createDirectoryAtPath:directoryPathStr withIntermediateDirectories:YES attributes:nil error:error]) {
            isSuccess = NO;
        }
    }
    return isSuccess;
}

+ (BOOL)createFile:(NSString *)filePathStr error:(NSError * _Nullable __autoreleasing *)error {
    
    if (filePathStr.length==0) {
        return NO;
    }
    NSFileManager *fileManager = [HXFileManager fileManager].fileManager;
    if ([fileManager fileExistsAtPath:filePathStr]) {
        return YES;
    }
    NSString *dirPath = [filePathStr stringByDeletingLastPathComponent];
    BOOL isSuccess = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:error];
    
    if (!isSuccess) {
        return isSuccess;
    }
    isSuccess = [fileManager createFileAtPath:filePathStr contents:nil attributes:nil];
    return isSuccess;
}

+ (void)writeToFile:(NSString *)filePathStr data:(NSData *)data synchronous:(BOOL)synchronous completion:(CompletionHandler)completion {
    
    if (filePathStr.length==0) {
        return;
    }
    
    NSError *error = nil;
    BOOL result = [self createFile:filePathStr error:&error];
    
    if (result) {
        if (synchronous) {
            if ([data writeToFile:filePathStr atomically:YES]) {
               completion(filePathStr, nil);
            }
            else{
                error = [NSError errorWithDomain:@"write data failed" code:0 userInfo:nil];
                completion(filePathStr, error);
            }
        }
        else {
            
            dispatch_async([HXFileManager fileManager].fileQueue, ^{
                NSError *error;
                if (![data writeToFile:filePathStr atomically:YES]) {
                    error = [NSError errorWithDomain:@"write data failed" code:0 userInfo:nil];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(filePathStr, error);
                });
            });
        }
        
    }
    else{
        completion(filePathStr, error);
    }
    
}

+ (NSData *)readFileData:(NSString *)filePathStr {
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePathStr];
    NSData *fileData = [handle readDataToEndOfFile];
    [handle closeFile];
    return fileData;
}

+ (long long)getFileSize:(NSString *)filePathStr {
    
    unsigned long long fileLength = 0;
    NSNumber *fileSize;
    NSFileManager *fileManager = [HXFileManager fileManager].fileManager;
    NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:filePathStr error:nil];
    if ((fileSize = [fileAttributes objectForKey:NSFileSize])) {
        fileLength = [fileSize unsignedLongLongValue];
    }
    return fileLength;
}

+ (BOOL)removeFile:(NSString *)filePathStr error:(NSError * _Nullable __autoreleasing *)error {
    BOOL isSuccess = NO;
    NSFileManager *fileManager = [HXFileManager fileManager].fileManager;
    isSuccess = [fileManager removeItemAtPath:filePathStr error:error];
    
    return isSuccess;
}

+ (void)asynRemoveFile:(NSString *)filePathStr error:(NSError * _Nullable __autoreleasing *)error {
    dispatch_async([HXFileManager fileManager].fileQueue, ^{
        [self asynRemoveFile:filePathStr error:error];
    });
}


#pragma mark Common Path
+ (NSString *)docPathStr {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)libraryPathStr {
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)cachePathStr {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)tmpPathStr {
    return NSTemporaryDirectory();
}


#pragma mark - Override

#pragma mark - Private Method

#pragma mark - Delegate

#pragma mark - Setter And Getter
- (NSFileManager *)fileManager {
    if (!_fileManager) {
        _fileManager = [[NSFileManager alloc] init];
    }
    return _fileManager;
}

- (dispatch_queue_t)fileQueue {
    if (!_fileQueue) {
        _fileQueue = dispatch_queue_create("HXFileManger.FileQueue", NULL);
    }
    return _fileQueue;
}

- (dispatch_queue_t)archiveQueue {
    if (!_archiveQueue) {
        _archiveQueue = dispatch_queue_create("HXFileManger.ArchiveQueue", NULL);
    }
    return _archiveQueue;
}


#pragma mark - Dealloc
@end
