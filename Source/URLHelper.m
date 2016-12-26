//
//  URLHelper.m
//  Pods
//
//  Created by Reminisce on 2016/12/6.
//
//

#import "URLHelper.h"
#import "Tools.h"
#import "CTMediator+CTMediatorModuleRCIMActions.h"
#define WEB_HOST @"xm.hzxwwl.cn"

@implementation URLHelper

+(void)actionWithURL:(NSString *)url withViewController:(UIViewController *)controller{
    
    NSDictionary *temp = [URLHelper getDicFromUrl:url];
    NSString *action;
    if([Tools dicContain:temp withKey:@"action"]){
       action = temp[@"action"];
    }
    if([action isEqualToString:@"ShowUserInfo"]){
        NSString *userId = temp[@"userId"];
        BaseViewController *friendInfoVC = [[CTMediator sharedInstance] CTMediator_friendInfoViewControllerWithID:userId];
        if(controller.navigationController){
        [controller.navigationController pushViewController:friendInfoVC animated:YES];
        }else{
            [controller presentViewController:friendInfoVC animated:YES completion:NO];
        }
    }
    

}


+ (NSString *) makeAppUrl:(NSDictionary *)params{
    
    NSMutableString *str = [NSMutableString string];
    
    [str appendFormat:@"http://%@/?",WEB_HOST];
    NSArray *keyList = [params allKeys];
    for (NSInteger i = 0 ;i < [keyList count]; i++) {
        if(i >= [[params allKeys]count] - 1 ){
            [str appendFormat:@"%@=%@",keyList[i],params[keyList[i]]];
        }else{
            [str appendFormat:@"%@=%@&",keyList[i],params[keyList[i]]];
        }
    }
    
    return [URLHelper urlEncoding:str];
    
}

+ (NSDictionary *) getDicFromUrl:(NSString *)url
{
    //获取问号的位置，问号后是参数列表
    NSRange range = [url rangeOfString:@"?"];
    NSLog(@"参数列表开始的位置：%d", (int)range.location);
    
    //获取参数列表
    NSString *propertys = [url substringFromIndex:(int)(range.location+1)];
    NSLog(@"截取的参数列表：%@", propertys);
    
    //进行字符串的拆分，通过&来拆分，把每个参数分开
    NSArray *subArray = [propertys componentsSeparatedByString:@"&"];
    NSLog(@"把每个参数列表进行拆分，返回为数组：n%@", subArray);
    
    //把subArray转换为字典
    //tempDic中存放一个URL中转换的键值对
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithCapacity:4];
    
    for (int j = 0 ; j < subArray.count; j++)
    {
        //在通过=拆分键和值
        NSArray *dicArray = [subArray[j] componentsSeparatedByString:@"="];
        NSLog(@"再把每个参数通过=号进行拆分：n%@", dicArray);
        //给字典加入元素
        [tempDic setObject:dicArray[1] forKey:dicArray[0]];
    }
    NSLog(@"打印参数列表生成的字典：n%@", tempDic);
    
    return tempDic;
}


+ (NSString *) urlEncoding:(NSString *)URL{
    return [URL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

+ (NSString *) urlDecoding:(NSString *)URL{
    
    return [URL stringByRemovingPercentEncoding];
}


@end
