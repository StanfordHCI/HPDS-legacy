//
//  ResearchKitSensor.m
//  HPDS-Data
//
//  Created by Michael Cooper on 2018-07-25.
//  Copyright © 2018 Michael Cooper. All rights reserved.
//

#import "EntitySample+CoreDataClass.h"
#import <Foundation/Foundation.h>

#import "ResearchKitSensor.h"
#import "AWAREKeys.h"
#import "TCQMaker.h"
#import "ExternalCoreDataHandler.h"
#import <ResearchKit/ResearchKit.h>

@implementation RKSensor{
    NSTimer * timer;
    int i;
}

- (instancetype)initWithAwareStudy:(AWAREStudy *)study dbType:(AwareDBType)dbType{
    AWAREStorage * storage = nil;
    i = 0;
    storage = [[SQLiteStorage alloc] initWithStudy:study
                                        sensorName:@"sample_table"
                                        entityName:NSStringFromClass([EntitySample class])
                                         dbHandler:ExternalCoreDataHandler.sharedHandler
                                    insertCallBack:^(NSDictionary *dataDict, NSManagedObjectContext *childContext, NSString *entity) {
                                        
                                        EntitySample * entitySample = (EntitySample *)[NSEntityDescription
                                                                                       insertNewObjectForEntityForName:entity
                                                                                       inManagedObjectContext:childContext];
                                        entitySample.device_id = [self getDeviceId];
                                        entitySample.timestamp = [[dataDict objectForKey:@"timestamp"] doubleValue];
                                        entitySample.value = [[dataDict objectForKey:@"value"] intValue];
                                        entitySample.label = [dataDict objectForKey:@"label"];
                                    }];
    self = [super initWithAwareStudy:study sensorName:@"sample_table" storage:storage];
    if (self) {
        
    }
    
    return self;
}

- (void) createTable {
    TCQMaker * maker = [[TCQMaker alloc] init];
    [maker addColumn:@"label" type:TCQTypeText default:@"''"];
    [maker addColumn:@"value" type:TCQTypeInteger default:@"0"];
    [self.storage createDBTableOnServerWithTCQMaker:maker];
}

/*
 * Function: validateSurveyJSON
 * Description: parses the survey JSON, formats the results appropriately into an
 * NSDictionary, then returns the NSDictionary.
 */
- (NSDictionary*) validateSurveyJSON:(NSData*) surveyData {
    
    if(NSClassFromString(@"NSJSONSerialization"))
    {
        NSError *error = nil;
        id object = [NSJSONSerialization
                     JSONObjectWithData:surveyData
                     options:0
                     error:&error];
        
        if(error) {
            //JSON was malformed
            NSLog(@"Survey data JSON was malformed. Error. Exiting getResearchKitData function...");
            return nil;
        }
        
        //Validate our dictionary
        if([object isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *results = object;
            
            //Confirm that the dictionary is not null (it shouldn't be) then call saveResearchKitData
            if (results != nil) {
                return results;
            }
            else {
                //Raise an error since our results dictionary did not contain anything
            }
        }
        else
        {
            //Raise an error since the outermost object in the JSON packet was not a dictionary
        }
    }
    //The user is using iOS 4, since NSJSONSerialization is supported only by iOS 5.0+. I suspect
    //this won't be an issue for us, but if this case arises, we will return nil to signal an error.
    return nil;
    
}


- (BOOL)startSensor { //: (NSData*) surveyData {
    NSLog(@"Successfully called RKSensor");
    
        // dispatch_async(dispatch_get_main_queue(), ^{

        [self.storage saveDataWithDictionary:@{@"device_id":[self getDeviceId],
                                               @"timestamp":@([NSDate new].timeIntervalSince1970*1000),
                                               @"value":@(0),
                                               @"label":@""}
                                      buffer:NO
                            saveInMainThread:YES];
        // });

    return YES;
}

- (BOOL)stopSensor{
    return YES;
}

@end
