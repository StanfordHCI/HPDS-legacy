//
//  SurveyTask.swift
//  
//
//  Created by Michael Cooper on 2018-07-23.
//

import Foundation
import ResearchKit

public var SurveyTask: ORKOrderedTask {
    
    var steps = [ORKStep]()
    
    //Instructions step
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "Here are our questions:"
    instructionStep.text = "Please answer accurately, honestly, precisely, and truly."
    steps += [instructionStep]
    
    //Name question
    let nameAnswerFormat = ORKTextAnswerFormat(maximumLength: 20)
    nameAnswerFormat.multipleLines = false
    let nameQuestionStepTitle = "What is your name?"
    let nameQuestionStep = ORKQuestionStep(identifier: "QuestionStep", title: nameQuestionStepTitle, answer: nameAnswerFormat)
    steps += [nameQuestionStep]
    
    //'What is your quest' question
    let questQuestionStepTitle = "What is your quest?"
    let textChoices = [
        ORKTextChoice(text: "Implement Hybrid Physical Systems", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Implement Hybrid Digital Systems", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ORKTextChoice(text: "Implement Hybrid Physical *and* Digital Systems", value: 2 as NSCoding & NSCopying & NSObjectProtocol)
    ]
    let questAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices)
    let questQuestionStep = ORKQuestionStep(identifier: "TextChoiceQuestionStep", title: questQuestionStepTitle, answer: questAnswerFormat)
    steps += [questQuestionStep]
    
    
    //Summary step
    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "Right. Off you go!"
    summaryStep.text = "That was easy!"
    steps += [summaryStep]
    
    
    return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
}
