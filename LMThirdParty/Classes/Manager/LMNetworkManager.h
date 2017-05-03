//
//  LMNetworkManager.h
//  LMThirdParty
//
//  Created by iOSDev on 17/5/3.
//  Copyright © 2017年 linhongmin. All rights reserved.
//  网络请求类

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, MonitorNetworkState){ //网络状态
    MonitorNetworkStateUnknown ,
    MonitorNetworkStateNotReachable ,
    MonitorNetworkStateWWAN ,
    MonitorNetworkStateWiFi

};
typedef NS_ENUM(NSUInteger , NetworkStates){
    NetworkStatesNone  =0,  //没有网络
    NetworkStates2G,    //2G
    NetworkStates3G,    //3G
    NetworkStates4G,    //4G
    NetworkStatesWIFI   //WIFI

};

/**  成功  */
typedef void(^requestSucess) (id object);
/**  失败  */
typedef void(^requestFailure) (NSError *error);
/**  上传进度 */
typedef void(^uploadProgress)(float progress);
/**  下载进度  */
typedef void(^downloadProgress)(float progress);

@interface LMNetworkManager : AFHTTPSessionManager

+(instancetype)shareManager;
/**  GET请求  */
+(void)GET:(NSString *)urlString params:(id)params sucessBlock:(requestSucess)successBlock failBlock:(requestFailure)failBlock progress:(downloadProgress)progress;
/**  POST请求  */
+(void)POST:(NSString *)urlString params:(id)params sucessBlock:(requestSucess)successBlock failBlock:(requestFailure)failBlock progress:(downloadProgress)progress;
/**
 *  上传图片
 *
 *  @param operations   上传图片等预留参数---视具体情况而定 可移除
 *  @param imageArray   上传的图片数组
 *  @parm width      图片要被压缩到的宽度
 *  @param urlString    上传的url---请填写完整的url
 *  @param successBlock 上传成功的回调
 *  @param failBlock 上传失败的回调
 *  @param progress     上传进度
 *
 */

+(void)uploadImageWithOperations:(NSDictionary *)operations
                  withImageArray:(NSArray *)imageArray
                 withTargetWidth:(CGFloat)width
                   withUrlString:(NSString *)urlString
                withSuccessBlock:(requestSucess)successBlock
                   withFailBlock:(requestFailure)failBlock
              withUploadProgress:(uploadProgress)progress;


/**  取消所有请求  */
+(void)cancelAllRequest;

/**
 *  取消指定的url请求
 *
 *  @param requestType 该请求的请求类型
 *  @param string      该请求的url
 */
+(void)cancelHttpRequestWithRequestType:(NSString *)requestType requestUrlString:(NSString *)string;

/**  获取当前网络状态  */
+(NetworkStates)getCurrentNetworkState;

/**  监听网络状态  */
+(void)startMonitoring:(void(^)(NSUInteger MonitorNetworkState))networkStateBlock;

/**  停止网络监听  */
+(void)stopMonitoring;
@end
