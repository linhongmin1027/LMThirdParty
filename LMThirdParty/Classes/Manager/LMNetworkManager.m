//
//  LMNetworkManager.m
//  LMThirdParty
//
//  Created by iOSDev on 17/5/3.
//  Copyright © 2017年 linhongmin. All rights reserved.
//

#import "LMNetworkManager.h"
/**  是否为https  */
#define kIsHttpsRequest YES
/**  SSL证书名称,仅支持cer格式. 需要自己导入  */
#define kCertificationName @"httpsServerAuth"
@implementation LMNetworkManager
+(instancetype)shareManager{
    static LMNetworkManager *manager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[self alloc]initWithBaseURL:[NSURL URLWithString:baseUrl]];
    });
    return manager;
}
#pragma mark  - 重写baseurl方法
-(instancetype)initWithBaseURL:(NSURL *)url{
    self=[super initWithBaseURL:url];
    if (self==nil) return nil;
    /**  设置请求超时时间  */
    self.requestSerializer.timeoutInterval=3;
    /**  设置相应的缓存策略
     NSURLRequestUseProtocolCachePolicy 默认的缓存策略,如果缓存不存在则直接从服务器请求数据,如果缓存存在,则根据response中的cache-Control字段来判断下一步操作,如:cache-control为字段mustrevalidata,则询问服务器数据是否有更新,无更新的话直接返回缓存数据,若已更新数据,则请求服务器
     */
    self.requestSerializer.cachePolicy=NSURLRequestUseProtocolCachePolicy;
    /**  序列化处理  */
    self.requestSerializer=[AFHTTPRequestSerializer serializer];
    AFJSONResponseSerializer *response=[AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues=YES;
    self.responseSerializer=response;
    /**  设置实体头  */
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    /**  设置接受的类型  */
    [self.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/plain",@"application/json", @"text/json", @"text/javascript",@"text/html", nil]];
    //如果是http则改为NO;
    if (kIsHttpsRequest) {
        [self setSecurityPolicy:[self customSecurityPolicy]];
    }
  
    return self;
}

#pragma mark  - GET
+(void)GET:(NSString *)urlString params:(id)params sucessBlock:(requestSucess)successBlock failBlock:(requestFailure)failBlock progress:(downloadProgress)progress{
    [[LMNetworkManager shareManager] GET:urlString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(error);
        
    }];
    
    
    
    
}
#pragma mark  - POST
+(void)POST:(NSString *)urlString params:(id)params sucessBlock:(requestSucess)successBlock failBlock:(requestFailure)failBlock progress:(downloadProgress)progress{
    [[LMNetworkManager shareManager] POST:urlString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress.completedUnitCount/uploadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(error);
        
    }];
}

#pragma mark  - 多图上传
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
              withUploadProgress:(uploadProgress)progress{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager POST:urlString parameters:operations constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSUInteger i=0;
        /**  出于性能考虑,将上传图片进行压缩  */
        for (UIImage *image in imageArray) {
            UIImage *resizedImage=[UIImage IMGCompressed:image targetWidth:width];
            NSData *imgData=UIImageJPEGRepresentation(resizedImage, 5);
            //拼接data
            [formData appendPartWithFileData:imgData name:[NSString stringWithFormat:@"picfile%ld",(long)i] fileName:@"image.png" mimeType:@"image/jpeg"];
            i++;
            
        }
        
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(error);
        
    }];
    
    
    
}
#pragma mark  - 取消所有的网络请求
/**  取消所有请求  */
+(void)cancelAllRequest{
    
    [[LMNetworkManager shareManager].operationQueue cancelAllOperations];
    
    
}
/**  取消某一个url请求  */
+(void)cancelHttpRequestWithRequestType:(NSString *)requestType requestUrlString:(NSString *)string{
    NSError *error;
    /**  根据请求的类型 以及 请求的url创建一个NSMutableURLRequest ---通过url去匹配请求队列中是否有该url,如果有的话 那么就取消该请求  */
    NSString *urlToPeCancel=[[[[LMNetworkManager shareManager].requestSerializer requestWithMethod:requestType URLString:string parameters:nil error:&error] URL] path];
    for (NSOperation *operation in [LMNetworkManager shareManager].operationQueue.operations) {
        if ([operation isKindOfClass:[NSURLSessionTask class]]) {
            //请求的类型匹配
            BOOL hasMatchRequestType =[requestType isEqualToString:[[(NSURLSessionTask *)operation currentRequest] HTTPMethod]];
            //请求的url匹配
            BOOL hasMatchRequestUrlstring =[urlToPeCancel isEqualToString:[[[(NSURLSessionTask *)operation currentRequest] URL] path]];
            /**   两项都匹配的话 取消该请求 */
            if (hasMatchRequestType && hasMatchRequestUrlstring) {
                [operation cancel];
            }
        }
    }
    
    
    
}

#pragma mark  - https请求
-(AFSecurityPolicy *)customSecurityPolicy{
    //先导入证书到项目
    NSString *cerPath=[[NSBundle mainBundle] pathForResource:kCertificationName ofType:@"cer" inDirectory:@"httpsServerAuth.boundle"];//证书的路径
    NSData *cerData=[NSData dataWithContentsOfFile:cerPath];
    //AFSecurityPolicyModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy=[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    //allowInvalidCertificates 是否允许无效证书(也就是自建证书), 默认为NO
    //如果需要验证自建证书,需要设置为YES
    securityPolicy.allowInvalidCertificates=YES;
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑
    securityPolicy.validatesDomainName=YES;
    //validatesCertificateChain 是否验证整个证书链，默认为YES
    //设置为YES，会将服务器返回的Trust Object上的证书链与本地导入的证书进行对比，这就意味着，假如你的证书链是这样的：
    //GeoTrust Global CA
    //    Google Internet Authority G2
    //        *.google.com
    //那么，除了导入*.google.com之外，还需要导入证书链上所有的CA证书（GeoTrust Global CA, Google Internet Authority G2）；
    //如是自建证书的时候，可以设置为YES，增强安全性；假如是信任的CA所签发的证书，则建议关闭该验证，因为整个证书链一一比对是完全没有必要（请查看源代码）；
    //    securityPolicy.validatesCertificateChain = NO;

    NSSet *cerDataSet=[NSSet setWithArray:@[cerData]];
    securityPolicy.pinnedCertificates=cerDataSet;
    
    return securityPolicy;

}



#pragma mark  - 网络监测
+(void)startMonitoring:(void(^)(NSUInteger MonitorNetworkState))networkStateBlock{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown :
                if (networkStateBlock) {
                    networkStateBlock(MonitorNetworkStateUnknown);
                }
                break;
            case AFNetworkReachabilityStatusNotReachable :
                if (networkStateBlock) {
                    networkStateBlock(MonitorNetworkStateNotReachable);
                }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN :
                if (networkStateBlock) {
                    networkStateBlock(MonitorNetworkStateWWAN);
                }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi :
                if (networkStateBlock) {
                    networkStateBlock(MonitorNetworkStateWiFi);
                }
                break;
                
            default:
                break;
        }
        
    }];
}

+(void)stopMonitoring{
    
    [[AFNetworkReachabilityManager manager] stopMonitoring];

}

+(NetworkStates)getCurrentNetworkState{
    NSArray *subViews=[[[[UIApplication sharedApplication] valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    NetworkStates states =NetworkStatesNone;
    for (id child in subViews) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            int networkType =[[child valueForKeyPath:@"dataNetworkType"] intValue];
            switch (networkType) {
                case 0:
                    states=NetworkStatesNone;
                    break;
                case 1:
                    states=NetworkStates2G;
                    break;
                case 2:
                    states=NetworkStates3G;
                    break;
                case 3:
                    states=NetworkStates4G;
                    break;
                case 5:
                    states=NetworkStatesWIFI;
                    break;
                    
                default:
                    break;
            }
        }
    }
    return states;
}













@end
