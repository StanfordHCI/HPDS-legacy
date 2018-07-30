//
//  ResearchKitSensor.m
//  HPDS-Data
//
//  Created by Michael Cooper on 2018-07-25.
//  Copyright © 2018 Michael Cooper. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ResearchKitSensor.h"
#import "AWAREKeys.h"
#import "TCQMaker.h"

@implementation RKSensor{
    NSString* KEY_DEVICE_ID;
    NSString* KEY_TIMESTAMP;           //begin
    NSString* KEY_END_TIMESTAMP;       // end

    NSString* NAME;                    // Question 1 of the survey, "What is your name?"

    NSString* QUEST;                   // Question 2 of the survey, "What is your quest?"
                                       // (chosen from array of [0, 1, 2...] representing
                                       // the answers to the multiple choice questions
}

- (instancetype)initWithAwareStudy:(AWAREStudy *)study dbType:(AwareDBType)dbType{

    KEY_DEVICE_ID = @"device_id";
    KEY_TIMESTAMP = @"timestamp";
    KEY_END_TIMESTAMP   = @"end_timestamp";
    NAME = @"name";
    QUEST = @"-1";                  //Default/error value

    AWAREStorage * storage = nil;
    if(dbType == AwareDBTypeCSV){
        NSArray * header = @[KEY_DEVICE_ID, KEY_TIMESTAMP, KEY_END_TIMESTAMP, NAME, QUEST];
        NSArray * headerTypes  = @[@(CSVTypeReal),@(CSVTypeText),@(CSVTypeReal),@(CSVTypeText),@(CSVTypeReal)];
        storage = [[CSVStorage alloc] initWithStudy:study sensorName:SENSOR_PLUGIN_RKSENSOR headerLabels:header headerTypes:headerTypes];
    }else{
        storage = [[JSONStorage alloc] initWithStudy:study sensorName:SENSOR_PLUGIN_RKSENSOR];
    }

    self = [super initWithAwareStudy:study
                          sensorName:SENSOR_PLUGIN_RKSENSOR
                             storage:storage];
    return self;
}


- (void) createTable{
    // Send a table create query
    if ([self isDebug]) {
        NSLog(@"[%@] create table!", [self getSensorName]);
    }

    TCQMaker * tcqMaker = [[TCQMaker alloc] init];
    [tcqMaker addColumn:KEY_END_TIMESTAMP type:TCQTypeReal default:@"0"];
    [tcqMaker addColumn:NAME type:TCQTypeInteger default:@"0"];
    [tcqMaker addColumn:QUEST type:TCQTypeInteger default:@"0"];
    [self.storage createDBTableOnServerWithTCQMaker:tcqMaker];
}

- (void)setParameters:(NSArray *)parameters{

}

- (BOOL)startSensor {

    [self setSensingState:YES];
    return NO;
}

- (BOOL)stopSensor{

    [self setSensingState:NO];
    return NO;
}

- (IBAction)getResearchKitData:(id)sender {
    
    //Link this to ESM Button
    
    //Do the survey here, gather the data, save it to the appropriate data structures
    
    NSLog(@"Survey running");
    
    //Collect surveydata
    NSString* surveyData;
    
    //If data is not nil (i.e. if we get a JSON), format data, then call saveData
    
    
}


- (void) saveResearchKitData:(NSDictionary*) surveyData {
    //Takes in the primitive JSON-version of the dictionary.
    //Formats the data appropriately, then saves it to the server.
    NSString * name = @"";
    NSNumber * quest = @0;

    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[self getDeviceId] forKey:KEY_DEVICE_ID];
    
    NSDate *currentDate = [NSDate date]; //Get the current date/time
    
    [dict setObject:[AWAREUtils getUnixTimestamp:currentDate] forKey:KEY_TIMESTAMP];
    //[dict setObject:[AWAREUtils getUnixTimestamp:pedometerData.endDate] forKey:KEY_END_TIMESTAMP];
    [dict setObject:name forKey:NAME];
    [dict setObject:quest forKey:QUEST];

    dispatch_async(dispatch_get_main_queue(), ^{

        //[AWAREUtils sendLocalNotificationForMessage:[NSString stringWithFormat:@"%@ steps", numberOfSteps] soundFlag:YES];

        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:dict
                                                             forKey:EXTRA_DATA];
        [[NSNotificationCenter defaultCenter] postNotificationName:ACTION_AWARE_PEDOMETER
                                                            object:nil
                                                          userInfo:userInfo];
        //        [self saveData:dict];
        [self.storage saveDataWithDictionary:dict buffer:NO saveInMainThread:NO];
        [self setLatestData:dict];
    });
    //
    //    NSString * message = [NSString stringWithFormat:@"%@(%@) %@(%@) %@ %@ %@(%@) %@(%@)", numberOfSteps, totalSteps, distance, totalDistance, currentPace, currentCadence, floorsAscended,totalFloorsAscended, floorsDescended, totalFllorsDescended];
    
    //TODO: Update this message with formatting
    //NSString * message = [NSString stringWithFormat:@"[%@ - %@] Steps:%d, Distance:%d, Pace:%d, Floor Ascended:%d, Floor Descended:%d",
    //                      pedometerData.startDate, pedometerData.endDate,
    //                      numberOfSteps.intValue, distance.intValue,
    //                      currentPace.intValue, floorsAscended.intValue,
    //                      floorsDescended.intValue];
    NSString * message = @"Saved RK data";

    if ([self isDebug]) NSLog(@"%@", message);
    [self setLatestValue:[NSString stringWithFormat:@"%@", message]];

    SensorEventHandler handler = [self getSensorEventHandler];
    if (handler!=nil) {
        handler(self, dict);
    }

}


@end
