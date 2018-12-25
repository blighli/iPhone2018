//
//  CZUMShare.m
//  91VPN
//
//  Created by weichengzong on 2017/8/29.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#import "CZUMShare.h"
#import <UShareUI/UShareUI.h>
@implementation CZUMShare

+ (void)UMShare91:(UIViewController *)vc{
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //创建网页内容对象
        //        NSString* thumbURL =  [];
        
        NSString *title = nil;
        if (platformType==UMSocialPlatformType_WechatTimeLine) {
            title = @"91加速器PRO，一键加速不限流量，为从境外到国内的网络访问提供加速服务。";
        }else{
            title = @"91加速器PRO";
        }
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:@"91加速器PRO，一键加速不限流量，为从境外到国内的网络访问提供加速服务。" thumImage:[UIImage imageNamed:@"headimg"]];
        //设置网页地址
        NSString *phoneStr = [[MyUserInfo getUserInfo] objectForKey:SHInvokerUserInfouser_name];
        NSString *webstr = nil;
        if (kAppDelegate.isGUONEI) {
            webstr = [NSString stringWithFormat:@"%@/home/index/register.html&mobile=%@",GuanWang_baida,phoneStr];
        }else{
            webstr = [NSString stringWithFormat:@"%@/home/index/register.html&mobile=%@",GuanWang_jiasu,phoneStr];
        }
        shareObject.webpageUrl = webstr;
        //分享消息对象设置分享内容对象http://91jiasu.adclick.com.cn
        messageObject.shareObject = shareObject;
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:vc completion:^(id data, NSError *error) {
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
            //            [self alertWithError:error];
        }];
        
        
    }];
}

- (void)UMSharewithimg:(NSString *)img title:(NSString *)title content:(NSString *)content url:(NSString *)url{
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //创建网页内容对象
//        NSString* thumbURL =  [];
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:content thumImage:[UIImage imageNamed:img]];
        //设置网页地址
        shareObject.webpageUrl = url;
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
//            [self alertWithError:error];
        }];
        
        
    }];
}

@end
