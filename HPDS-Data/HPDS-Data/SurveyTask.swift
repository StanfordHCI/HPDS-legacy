//
//  SurveyTask.swift
//  
//
//  Created by Michael Cooper on 2018-07-23.
//

import Foundation
import ResearchKit

public var SurveyTask: ORKOrderedTask {
    //A ResearchKit survey task.
    
    var steps = [ORKStep]()
    
    //Instructions step
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "Welcome!"
    instructionStep.text = "Please answer the following questions accurately, honestly, precisely, and truly."
    steps += [instructionStep]
    
    //Name question
    let nameAnswerFormat = ORKTextAnswerFormat(maximumLength: 20)
    nameAnswerFormat.multipleLines = false
    let nameQuestionStepTitle = "What is your name?"
    let nameQuestionStep = ORKQuestionStep(identifier: "QuestionStep", title: nameQuestionStepTitle, answer: nameAnswerFormat)
    print(nameAnswerFormat)
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
    print(questAnswerFormat)
    steps += [questQuestionStep]
    
    
    //Summary step
    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "Right. Off you go!"
    summaryStep.text = "That was easy!"
    steps += [summaryStep]
    
    return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
}
