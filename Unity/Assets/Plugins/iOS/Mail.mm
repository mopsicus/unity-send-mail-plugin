//  Mail.m
//  Mail
//
//  Created by Igor on 09.06.16.
//  Copyright © 2016 R-Soft. All rights reserved.
//

#import <MessageUI/MessageUI.h>

extern UIViewController *UnityGetGLViewController(); // Главный контроллер Unity
extern void UnitySendMessage(const char *obj, const char *method, const char *msg); // Объявляем для отправки сообщений в Unity

@interface Mail : UIViewController;
@end

@implementation Mail;

// Делаем копию строки в куче
- (char *)makeStringCopy:(const char *)string {
    return (string == NULL) ? NULL : strcpy((char *)malloc(strlen(string) + 1), string);
}

- (void)sendMailTo:(NSString *)mail withSubject:(NSString *)subject body:(NSString *)body  {
    NSString *data = [NSString stringWithFormat:@"mailto:%@?subject=%@&body=%@", mail, subject, body];
    data = [data stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:data]];
    if(![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:data]] || ![[UIApplication sharedApplication] openURL:[NSURL URLWithString:data]]) {
        UnitySendMessage([self makeStringCopy:[@"Plugins" UTF8String]], [self makeStringCopy:[@"OnMailFinished" UTF8String]], [self makeStringCopy:[@"-1" UTF8String]]);
    }
}

static Mail *mailer = NULL;

extern "C" {
    
    void mailSendMail (const char* mail, const char* subject, const char* body) {
        if (mailer == NULL)
            mailer = [[Mail alloc] init];
        [mailer sendMailTo:[NSString stringWithUTF8String:mail] withSubject:[NSString stringWithUTF8String:subject] body:[NSString stringWithUTF8String:body]];
    }
    
}

@end
