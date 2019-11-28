//
//  SYRemoteLogger.m
//  RemoteLoging
//
//  Created by 赵旭东 on 2019/7/1.
//  Copyright © 2019 Addict. All rights reserved.
//

#import "SYRemoteLogger.h"


static NSString *startDate,*startPageName;

@implementation SYRemoteLogger

/// 进入页面调用
+(void)beginLogPageView:(NSString *)pageName{
    
    NSDate *date = [NSDate date];
    startDate = [NSString stringWithFormat:@"%0.f",[date timeIntervalSince1970]];
    startPageName = SYObjectIsEmpty(pageName) ? @"" : pageName;
}

/// 离开页面调用
+(void)endLogPageView:(NSString *)pageName{
    //同一个页面
    if(!SYObjectIsEmpty(pageName) && [pageName isEqualToString:startPageName]){
        NSDate *date = [NSDate date];
        NSString *endStr = [NSString stringWithFormat:@"%0.f",[date timeIntervalSince1970]];
        // TODO: 直接走接口
        ULog(@"我在%@页面停留了%@",pageName,endStr);
    }
}

/// 自定义事件,数量统计
+(void)event:(NSString *)eventId{
    ULog(@"我点击了 %@",eventId);
}

/// 自定义事件,数量统计
+(void)event:(NSString *)eventId attributes:(NSDictionary *)attributes{
    ULog(@"我点击了 %@",eventId);
}

/// 是否存在闪退日志，如果有则上传日志
+(void)writeLogForCrashReporter{
    NSSetUncaughtExceptionHandler (&UncaughtExceptionHandler);
    NSString * errorMessageFile = [NSString stringWithFormat:@"%@/error.txt",XDPathDocument];
    if ([[NSFileManager defaultManager]fileExistsAtPath:errorMessageFile]) {
        NSString *errorLog = [[NSString alloc]initWithContentsOfFile:errorMessageFile encoding:NSUTF8StringEncoding error:nil];
        // TODO: 接口上报崩溃日志
        NSLog(@"崩溃日志=%@",errorLog);
//        [[NSFileManager defaultManager]removeItemAtPath:errorMessageFile error:nil];
    }
}



#pragma mark -私有方法

// 异常日志获取,崩溃把日志写入本地，等下次开启app再上传
void UncaughtExceptionHandler(NSException *exception){
    NSArray *excpArr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSDictionary * userInfo = [exception userInfo];
    NSString *excpCnt = [NSString stringWithFormat:@"exceptionType: %@ \n reason: %@ \n stackSymbols: %@ \n userInfo: %@",name,reason,excpArr,userInfo]; //NSDOCUMENTPATH是沙盒路径
    NSString * errorMessageFile = [NSString stringWithFormat:@"%@/error.txt",XDPathDocument]; //将崩溃信息写入沙盒里的error.txt文件
    [excpCnt writeToFile:errorMessageFile atomically:YES encoding:NSUTF8StringEncoding error:nil];
}




@end
