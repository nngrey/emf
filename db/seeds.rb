require 'ffaker'

def seed_framework
  organization = Organization.create(name: 'Communidad Connect')
  program = organization.programs.create(name: "NicaAgua")
  framework = program.create_framework(name: "Framework for NicaAgua")
  survey_template = framework.survey_templates.create(name: 'Baseline survey')
  eval_question = framework.evaluative_questions.create(category: 'effectiveness', description: 'To what degree were water filters installed')
  indicator = eval_question.performance_indicators.create(description: 'Number of filters installed')
  data_question = survey_template.data_questions.create(description: 'Was a water filter installed?', question_type: 'Yes / No', display_value: 'Pie chart', survey_template_id: survey_template.id)
  data_question2 = survey_template.data_questions.create(description: 'Did the water filter function correctly?', question_type: 'Yes / No', display_value: 'Bar chart', survey_template_id: survey_template.id)
  data_question.options.create(description: 'Yes')
  data_question.options.create(description: 'No')
  data_question2.options.create(description: 'Yes')
  data_question2.options.create(description: 'No')
  20.times do
    survey = survey_template.surveys.create()
    survey_question = survey.survey_questions.create(description: data_question.description, question_type: data_question.question_type, data_question_id: data_question.id)
    survey_question2 = survey.survey_questions.create(description: data_question2.description, question_type: data_question2.question_type, data_question_id: data_question2.id)
    response = survey_question.survey_responses.create(input_value: ['Yes', 'Yes', 'Yes', 'No'].sample, data_question_id: data_question.id)
    if response.input_value == 'No'
      survey_question2.survey_responses.create(input_value: 'No', data_question_id: data_question2.id)
    else
      survey_question2.survey_responses.create(input_value: ['Yes', 'Yes', 'No'].sample, data_question_id: data_question2.id)
    end
  end
  data_combination = survey_template.data_combinations.create(title: 'Sucessful Filter Implementation', description: 'Filter was installed and functioned correctly.', criterion_1: data_question.options.first.id, criterion_2: data_question2.options.first.id, data_question_1_id: data_question.id, data_question_2_id: data_question2.id, display_value: 'Pie chart', data_label_1: 'Successful installation', data_label_2: 'Failed installations')
  data_combination.analyses.create(title: data_combination.title, description: data_combination.description, display_value: 'Pie chart')
end

seed_framework

