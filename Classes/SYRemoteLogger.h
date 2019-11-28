//
//  SYRemoteLogger.h
//  RemoteLoging
//
//  Created by 赵旭东 on 2019/7/1.
//  Copyright © 2019 Addict. All rights reserved.
//

#define XDPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

/*DEBUG  模式下打印日志,当前行 并弹出一个警告*/
#define ULog(fmt, ...)  {UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__] preferredStyle:(UIAlertControllerStyleAlert)];UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];[alertVC addAction:action];[[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:alertVC animated:YES completion:nil];}

//是否是空对象
#define SYSafeGetStringValue(object) ((![object isKindOfClass:[NSNull class]] && object!=nil)?([object isKindOfClass:[NSString class]]?object:[object stringValue]):@"")
#define SYObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))




#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYRemoteLogger : NSObject

///自动页面时长统计。开始记录某个页面展示时长。使用方法：必须配对调用beginLogPageView:和endLogPageView:两个函数来完成自动统计，若只调用某一个函数不会生成有效数据。在该页面展示时调用beginLogPageView:，当退出该页面时调用endLogPageView:
/// @param pageName 统计的页面名称.
+(void)beginLogPageView:(NSString *)pageName;

///自动页面时长统计。结束记录某个页面展示时长。使用方法：必须配对调用beginLogPageView:和endLogPageView:两个函数来完成自动统计，若只调用某一个函数不会生成有效数据。在该页面展示时调用beginLogPageView:当退出该页面时调用endLogPageView:
/// @param pageName 统计的页面名称.
+(void)endLogPageView:(NSString *)pageName;

/// 自定义事件,数量统计
/// @param eventId 事件ID
+(void)event:(NSString *)eventId;

/// 自定义事件,数量统计
/// @param eventId 事件ID
/// @param attributes 额外参数
+(void)event:(NSString *)eventId attributes:(NSDictionary *)attributes;

/// 是否存在闪退日志，如果有则上传日志
+(void)writeLogForCrashReporter;





@end

NS_ASSUME_NONNULL_END
