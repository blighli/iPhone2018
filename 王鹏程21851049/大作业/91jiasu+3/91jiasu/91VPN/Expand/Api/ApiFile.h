//
//  ApiFile.h
//  CZBaseProjectDemo
//
//  Created by weichengzong on 2017/7/27.
//  Copyright © 2017年 weichengzong. All rights reserved.
//

#ifndef ApiFile_h
#define ApiFile_h



#define CheckAccountAPI          @"V15/Mem/checkAccount"
#define SendAppVerifyAPI         @"/ucenter/verify/sendAppVerify"
#define RegistAPI                @"/V15/Mem/register"
#define LoginAPI                 @"/V15/Mem/login"
#define Login2API                @"/V15/Mem/login2"
#define SendAppChangeVerifyAPI   @"/ucenter/verify/sendAppChangeVerify"
#define CheckAppVerifyAPI        @"V15/Mem/checkAppVerify"
#define ChangepasswordAppAPI     @"V15/Mem/changepasswordapp"

#define GETServerAPI      @"/V15/Mem/getserver"
#define GETPlabAPI        @"/V15/Mem/getplan"
#define GETServiceAPI     @"/V15/Mem/getService"
#define GETUserInfo       @"/V15/Mem/userInfo"

///查询订单状态的接口
#define GETPayStatus      @"V15/Mem/getPayStatus"
///获取证书url的接口
#define GETCertAPI        @"V15/Mem/getCert"
///内购的时间接口
#define GETIsopay         @"/V15/Mem/iospay"
///开放内购权限接口
#define GETAppStore       @"/V15/Mem/appstore"
///用户退出
#define LogoutAPI         @"/V15/Mem/logout"
///获取游客账号
#define visitorAPI        @"V15/Mem/visitor"
///获取所有服务列表
#define getallserverAPI   @"V15/Mem/getallserver"
///获取版本号
#define getiOSversionAPI  @"/v15/mem/iosversion"
///获取融云token
#define getRYTOKENAPI     @"/v15/mem/getrytoken"

#define alertTextAPI      @"/v15/Mem/getbillboard"
#endif /* ApiFile_h */
