//
//  AppDelegate.m
//  LocalTest
//
//  Created by Huahan Zhang on 3/30/15.
//  Copyright (c) 2015 Huahan Zhang. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "PresentationController.h"
#import "HomeContrller.h"
#import "BackgroundUtil.h"

@interface AppDelegate ()

@property(nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property(nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property(nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@end

@implementation AppDelegate


- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel == nil) {
        NSString *modelPath = [[NSBundle mainBundle]
                               pathForResource:@"DataModel" ofType:@"momd"];
        NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    return _managedObjectModel;
}

- (NSString *)documentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths lastObject];
    return documentsDirectory;
}

- (NSString *)dataStorePath {
    return [[self documentsDirectory]
            stringByAppendingPathComponent:@"DataStore.sqlite"];
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator == nil) {
        NSURL *storeURL = [NSURL fileURLWithPath:
                                    [self dataStorePath]];
        _persistentStoreCoordinator =
            [[NSPersistentStoreCoordinator alloc]
                initWithManagedObjectModel:self.managedObjectModel];
        NSError *error;
        if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                            configuration:nil
                            URL:storeURL
                            options:nil error:&error]) {
            NSLog(@"Error %@ %@", error, [error userInfo]);
//            about();
        }
    }
    return _persistentStoreCoordinator;
}

-(NSManagedObjectContext *)managerdObjectContext
{
    if (_managedObjectContext == nil) {
        NSPersistentStoreCoordinator *cood = self.persistentStoreCoordinator;
        if(cood != nil) {
            _managedObjectContext =[[NSManagedObjectContext alloc] init];
            [_managedObjectContext setPersistentStoreCoordinator:cood];
        }
    }
    return _managedObjectContext;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //1,  todo init log & monitor
    
    //2,  nc
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(handleLoginFailure) name:@"LoginFail" object:nil];
    [nc addObserver:self selector:@selector(handleLoginSuccess) name:@"LoginSuccess" object:nil];
    
    //3, setup sdk
    [self setupFoundaitonSDK];
    
    //4, todo setup analysis
    
    // 5, setup crash report
    
    //6, setup navigation
    HomeContrller *hc = [HomeContrller sharedInstance];
    [hc setupMainNavigationControllerStack];
    UIViewController *mainNavi = [HomeContrller sharedInstance].mainNaviController;
//
    
    //7, get locale
//    [[HomeContrller sharedInstance] updateLocale];
    
    //8,
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.window.backgroundColor = [UIColor blackColor];
    
    //9, todo setup sidebar
    [self setupSideBar:mainNavi];
    
    [self.window makeKeyAndVisible];
    

    self.window.backgroundColor = [[BackgroundUtil sharedInstance] getBackgroundImageWithBlur:YES :self.window.frame];
    return YES;
}

-(void)setupFoundaitonSDK
{
    //account SDK
    //1, todo setup with SDK
}

-(void) setupSideBar: (UIViewController *)navi
{
    //1, setup itune app id & theme
    
    //2, create the root present controller
    PresentationController *pc = [PresentationController sharedInstance];
    
    //set theme
    
    //set navi
    [pc setContentController:navi];
    
    //3, todo animation
    
    //4, set sidebar
    
    //5, install
    self.window.rootViewController = pc;
}

-(void)handleLoginFailure
{
    
}

-(void)handleLoginSuccess
{
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
