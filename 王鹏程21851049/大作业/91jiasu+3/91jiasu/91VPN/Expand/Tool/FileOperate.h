//
//  FileOperate.h
//  GoPanda
//
//  Created by wangpengfei on 15/12/10.
//  Copyright © 2015年 wangpengfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileOperate : NSObject


// 获取沙盒主目录路径
+ (NSString *)getFileRootPathAtObjects;


// 获取Documents目录路径
+ (NSString *)getFileDomcumentFolderPathAtObject;

// 获取Documents目录路径文件夹
+ (NSArray *)getFileDomcumentFolderAtObjects;

// 获取Documents目录路径下所有文件
+ (NSString *) getFileDomcumentAtObjects;


//获取Documents目录下所有书籍
+ (NSArray *) getFileDomcumentBooksAtObjects;

// 获取Documents目录路径下指定文件
+ (NSArray *) getFileDomcumentInNameAtObjects:(NSString *)fileName;

// 获取Caches目录路径
+ (NSArray *)getFileCachesPathAtObjects;


// 获取tmp目录路径
+ (NSString *)getFileTmpPathAtObjects;


//获取项目DataSource 文件指定文件路径
+ (NSString *)getFileResoucePathAtObjects:(NSString *)myFileName;


//在Document路径下创建文件夹
+ (BOOL)createFolderInDocumentObjects:(NSString *)fileName;


//根据文件名称 删除Document路径下的文件
+ (void)deleteFileAtDocument:(NSString *)fileName;


//删除指定文件
+ (BOOL) deleteFile:(NSString *)path;

//获取Library根路径
+ (NSString *)getLibraryPathAtObjects;

///判断文件是否存在
+ (BOOL) isHashFilePath:(NSString *)filePath;

//在指定路径下创建文件夹
+ (BOOL)createFolderInLibraryObjects:(NSString *)path;

//在Library路径下copy指定文件
+ (BOOL)copyFileAtAssignPathInLibrary:(NSString *)fileName oldPath:(NSString *)oldPath  newPath:(NSString *)newPath;


//根据文件名称 删除Library路径下的文件
+ (void)deleteFileAtLibrary:(NSString *)fileName;

///判断文件夹是否存在
+(BOOL)isTheDirIsExist:(NSString *)path;

//获取指定目录下所有文件
+(NSArray *)getTheDirAllFile:(NSString *)path;
@end
