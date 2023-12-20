// SimpleAction.xm

#import <Powercuts/Powercuts.h>

@interface SimpleAction : NSObject <PowercutsAction>

@property (nonatomic, copy) NSString *title;

@end

@implementation SimpleAction

- (instancetype)init
{
    self = [super init];
    if (self) {
        _title = @"Simple Action";
    }
    return self;
}

- (void)performAction
{
    // 设置警报的标题
    self.alertController.title = self.title;

    // 注册电源故障警报
    [self.application addObserver:self forKeyPath:@"applicationState" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"applicationState"]) {
        if (self.application.applicationState == UIApplicationStateBackground) {
            // 在后台启动电源故障警报
            [self.alertController show];
        }
    }
}

@end
