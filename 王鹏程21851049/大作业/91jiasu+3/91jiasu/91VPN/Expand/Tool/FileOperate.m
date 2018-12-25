//
//  FileOperate.m
//  GoPanda
//
//  Created by wangpengfei on 15/12/10.
//  Copyright © 2015年 wangpengfei. All rights reserved.
//

#import "FileOperate.h"

@implementation FileOperate


// 获取沙盒主目录路径
+ (NSString *)getFileRootPathAtObjects{
    NSString *homeDir = NSHomeDirectory();
    if (homeDir && ![homeDir isEqualToString:@""]) {
        return homeDir;
        
    }
    return nil;
}


// 获取Documents目录路径
+ (NSString *)getFileDomcumentFolderPathAtObject{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    if (documentsDirectory) {
        return documentsDirectory;
    }
    return nil;
}

// 获取Documents目录路径文件夹
+ (NSArray *)getFileDomcumentFolderAtObjects{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSError *error = nil;
	NSArray *fileList = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error] ;
    BOOL isDir = NO;
    NSMutableArray *dirArray = [[NSMutableArray alloc] init];
    for (NSString *file in fileList) {
        NSString *path = [documentsDirectory stringByAppendingPathComponent:file];
        isDir  =[fileMgr fileExistsAtPath:path isDirectory:(&isDir)];  // 判断是文件还是文件夹 ，文件夹返回yes
        if (isDir) {
            [dirArray addObject:file];
        }
    }
    return dirArray;
}

// 获取Documents目录路径下所有文件
+ (NSString *) getFileDomcumentAtObjects{
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    if (documentsDirectory && ![documentsDirectory isEqualToString:@""]) {
        return documentsDirectory;
    }
    return nil;
}

//获取Documents目录下所有书籍
+ (NSArray *) getFileDomcumentBooksAtObjects{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSError *error = nil;
	NSArray *fileList = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error];
    if (fileList && [fileList count] >0) {
        return fileList;
    }
    return nil;
}


// 获取Documents目录路径下指定文件
+ (NSArray *) getFileDomcumentInNameAtObjects:(NSString *)fileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSArray *tempArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[documentsDirectory stringByAppendingPathComponent:fileName] error:NULL];
    if (tempArray) {
        return tempArray;
    }
    return nil;
}


// 获取Caches目录路径
+ (NSArray *)getFileCachesPathAtObjects
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    if (paths) {
        return paths;
    }
    return nil;
}

// 获取tmp目录路径
+ (NSString *)getFileTmpPathAtObjects{
    NSString *tmpDir =  NSTemporaryDirectory();
    if (tmpDir && ![tmpDir isEqualToString:@""]) {
        return tmpDir;
    }
    return nil;
}


//获取项目DataSource 文件指定文件路径
+ (NSString *)getFileResoucePathAtObjects:(NSString *)myFileName{
    NSString *paths = [[NSBundle mainBundle] resourcePath];
    NSString *bundlePath = [paths stringByAppendingPathComponent:myFileName];
    if (bundlePath && ![bundlePath isEqualToString:@""]) {
        return bundlePath;
    }
    return nil;
}


//在Document路径下创建文件夹
+ (BOOL)createFolderInDocumentObjects:(NSString *)fileName{
    BOOL isSuccess;
    if (fileName && ![fileName isEqualToString:@""]) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *doc = [paths objectAtIndex:0];
        
        NSString *userDirectory = [doc stringByAppendingPathComponent:fileName];

        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if(![fileManager fileExistsAtPath:userDirectory]){
            isSuccess = [fileManager createDirectoryAtPath:userDirectory withIntermediateDirectories:NO attributes:NULL error:NULL];
            return isSuccess;
        }
    }
    return NO;
}

//根据文件名称 删除Document路径下的文件
+ (void)deleteFileAtDocument:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *documentLibraryFolderPath = [documentsDirectory stringByAppendingPathComponent:fileName];
     [[NSFileManager defaultManager] removeItemAtPath:documentLibraryFolderPath error:nil];
}

//删除指定文件
+ (BOOL) deleteFile:(NSString *)path
{
    if (path == nil) {
        return NO;
    }
    
    NSError *error = nil;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if (fileManager != nil) {
        BOOL result = [fileManager removeItemAtPath:path error:&error];
        if (result != YES) {
            return NO;
        }
        return YES;
    }
    return NO;
}

//获取Library根路径
+ (NSString *)getLibraryPathAtObjects{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libPath = [paths objectAtIndex:0];
    if (libPath && ![libPath isEqualToString:@""]) {
        return libPath;
    }
    return nil;
}

///判断文件是否存在
+ (BOOL) isHashFilePath:(NSString *)filePath{
    BOOL isExist = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    isExist = [fileManager fileExistsAtPath:filePath];
    if (isExist) {
        return YES;
    }
    return NO;
}


//在指定路径下创建文件夹
+ (BOOL)createFolderInLibraryObjects:(NSString *)path{
    BOOL isSuccess;
    if (path && ![path isEqualToString:@""]) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if([fileManager fileExistsAtPath:path]){
            return NO;
        }else{
            isSuccess = [fileManager createDirectoryAtPath:path withIntermediateDirectories:NO attributes:NULL error:NULL];
            return isSuccess;
        }
    }
    return NO;
}


//在Library路径下copy指定文件
+ (BOOL)copyFileAtAssignPathInLibrary:(NSString *)fileName oldPath:(NSString *)oldPath  newPath:(NSString *)newPath
{
    NSError *error = nil;
    BOOL isSuccess = [[NSFileManager defaultManager] copyItemAtPath:oldPath toPath:newPath error:&error];
    return isSuccess;
}


//根据文件名称 删除Library路径下的文件
+ (void)deleteFileAtLibrary:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSLocalDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *documentLibraryFolderPath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    [[NSFileManager defaultManager] removeItemAtPath:documentLibraryFolderPath error:nil];
}
///判断文件夹是否存在
+(BOOL)isTheDirIsExist:(NSString *)path
{
    BOOL isdic = YES;
     NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirExist = [fileManager fileExistsAtPath: path isDirectory: &isdic];
    return isDirExist;
}
//获取指定目录下所有文件
+(NSArray *)getTheDirAllFile:(NSString *)path
{
    NSError *error = nil;
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSArray *fileList = [fileMgr contentsOfDirectoryAtPath:path error:&error] ;
    BOOL isDir = NO;
    NSMutableArray *dirArray = [[NSMutableArray alloc] init];
    for (NSString *file in fileList) {
        isDir  =[fileMgr fileExistsAtPath:file isDirectory:(&isDir)];  // 判断是文件还是文件夹 ，文件夹返回yes
        if (!isDir) {
            [dirArray addObject:file];
        }
    }
    return dirArray ;
}

@end
