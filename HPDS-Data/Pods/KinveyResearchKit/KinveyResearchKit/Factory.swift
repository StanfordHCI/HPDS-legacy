//
//  Factory.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-09-22.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit

func build(_ result: ORKResult) -> Result? {
    if let stepResult = result as? ORKStepResult {
        return StepResult(stepResult: stepResult)
    } else if let taskResult = result as? ORKTaskResult {
        return TaskResult(taskResult: taskResult)
    } else if let numericQuestionResult = result as? ORKNumericQuestionResult {
        return NumericQuestionResult(numericQuestionResult: numericQuestionResult)
    } else if let timeIntervalQuestionResult = result as? ORKTimeIntervalQuestionResult {
        return TimeIntervalQuestionResult(timeIntervalQuestionResult: timeIntervalQuestionResult)
    } else if let booleanQuestionResult = result as? ORKBooleanQuestionResult {
        return BooleanQuestionResult(booleanQuestionResult: booleanQuestionResult)
    } else if let dateQuestionResult = result as? ORKDateQuestionResult {
        return DateQuestionResult(dateQuestionResult: dateQuestionResult)
    } else if let choiceQuestionResult = result as? ORKChoiceQuestionResult {
        return ChoiceQuestionResult(choiceQuestionResult: choiceQuestionResult)
    } else if let locationQuestionResult = result as? ORKLocationQuestionResult {
        return LocationQuestionResult(locationQuestionResult: locationQuestionResult)
    } else if let scaleQuestionResult = result as? ORKScaleQuestionResult {
        return ScaleQuestionResult(scaleQuestionResult: scaleQuestionResult)
    } else if let textQuestionResult = result as? ORKTextQuestionResult {
        return TextQuestionResult(textQuestionResult: textQuestionResult)
    } else if let timeOfDayQuestionResult = result as? ORKTimeOfDayQuestionResult {
        return TimeOfDayQuestionResult(timeOfDayQuestionResult: timeOfDayQuestionResult)
    } else if let fileResult = result as? ORKFileResult {
        return FileResult(fileResult: fileResult)
    } else if let consentSignatureResult = result as? ORKConsentSignatureResult {
        return ConsentSignatureResult(consentSignatureResult: consentSignatureResult)
    } else if let passcodeResult = result as? ORKPasscodeResult {
        return PasscodeResult(passcodeResult: passcodeResult)
    } else if let holePegTestResult = result as? ORKHolePegTestResult {
        return HolePegTestResult(holePegTestResult: holePegTestResult)
    } else if let psatResult = result as? ORKPSATResult {
        return PSATResult(psatResult: psatResult)
    } else if let reactionTimeResult = result as? ORKReactionTimeResult {
        return ReactionTimeResult(reactionTimeResult: reactionTimeResult)
    } else if let spatialSpanMemoryResult = result as? ORKSpatialSpanMemoryResult {
        return SpatialSpanMemoryResult(spatialSpanMemoryResult: spatialSpanMemoryResult)
    } else if let timedWalkResult = result as? ORKTimedWalkResult {
        return TimedWalkResult(timedWalkResult: timedWalkResult)
    } else if let toneAudiometryResult = result as? ORKToneAudiometryResult {
        return ToneAudiometryResult(toneAudiometryResult: toneAudiometryResult)
    } else if let towerOfHanoiResult = result as? ORKTowerOfHanoiResult {
        return TowerOfHanoiResult(towerOfHanoiResult: towerOfHanoiResult)
    } else if let tappingIntervalResult = result as? ORKTappingIntervalResult {
        return TappingIntervalResult(tappingIntervalResult: tappingIntervalResult)
    } else if let dataResult = result as? ORKDataResult {
        return DataResult(dataResult: dataResult)
    }
    return nil
}

func build(_ array: [ORKResult]?) -> [Result]? {
    var results: [Result]? = nil
    if let array = array {
        results = [Result]()
        for result in array {
            if let result = build(result) {
                results?.append(result)
            }
        }
    }
    return results
}
