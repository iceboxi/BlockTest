//
//  AppDelegate.m
//  BlockTest
//
//  Created by iceboxi Drizzt on 2014/9/19.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "AppDelegate.h"

//NSInteger CounterGlobal = 0; // 定義CounterGlobal  // 放這也可以，差別不清楚...
//static NSInteger CounterStatic = 0;

@implementation AppDelegate

NSInteger CounterGlobal = 0; // 定義CounterGlobal
static NSInteger CounterStatic = 0;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self blockTest1];
    [self blockTest2];
    [self blockTest3];
    [self blockTest4];
    
    return YES;
}

- (void)blockTest1
{
    // 輸入n輸出7*n
    int multiplier = 7;
    int (^myBlock)(int) = ^(int num)
    {
        return num * multiplier;
    };
    
    DLog(@"%d", myBlock(2));
}

- (void)blockTest2
{
    // 透過block設定的規則排序
    char *myCharacters[4] = {"TomCock", "George", "Goaer", "Jobs"};
    
    DLog(@"before");
    for (int i=0; i<4; i++) {
        printf("%s ", myCharacters[i]);
    }
    printf("\n");
    
    qsort_b(myCharacters, 4, sizeof(char *), ^(const void *l, const void *r)
            {
                char *left = *(char **)l;
                char *right = *(char **)r;
                return strncmp(left, right, 1);
            });
    DLog(@"after");
    for (int i=0; i<4; i++) {
        printf("%s ", myCharacters[i]);
    }
    printf("\n");
}

- (void)blockTest3
{
    // 假如變數要在block中可變更（一般變數傳入block為const）
    __block int mul = 7;
    int(^myBlock)(int) = ^(int num)
    {
        if (num > mul) {
            mul = num;
        }
        
        return mul;
    };
    
    DLog("%d", myBlock(9));
}

- (void)blockTest4
{
    NSInteger localCounter = 42;
    __block char localCharacter;
    
    void (^aBlock)(void) = ^(void)
    {
        ++CounterGlobal; //可以存取。
        ++CounterStatic; //可以存取。
        CounterGlobal = localCounter; //localCounter在block建立時就不可變了。
        localCharacter = 'a'; //設定外面定義的 localCharacter 變數。
    };
    
    ++localCounter; //不會影響block中的值。
    localCharacter = 'b';
    
    DLog(@"before===========");
    DLog(@"localCounter = %d", localCounter);
    DLog("localCharacter = %c", localCharacter);
    DLog(@"CounterGlobal = %d", CounterGlobal);
    
    aBlock(); //執行block的內容。
    //執行完後，localCharachter 會變成 'a'
    DLog(@"after===========");
    DLog(@"localCounter = %d", localCounter);
    DLog("localCharacter = %c", localCharacter);
    DLog(@"CounterGlobal = %d", CounterGlobal);
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
