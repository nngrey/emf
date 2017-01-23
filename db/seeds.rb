require 'ffaker'

def seed_framework
  organization = Organization.create(name: 'Communidad Connect')
  program = organization.programs.create(
    name: "NicaAgua",
    start_date: "01/02/2017",
    end_date: "15/11/2017")

  actual_budget = program.budgets.create(name: 'actual', total: 10000)

  ['01/01/2017', '03/02/2017', '01/03/2017', '02/04/2017', '04/05/2017', '01/06/2017'].each do |date|
    actual_budget.budget_entries.create(amount: (2000 * rand()).round, date: date)
  end

  logic_model = program.create_logic_model
  ['staff', 'funding', 'volunteers'].each do |attr|
    logic_model.logic_model_inputs.create(description: attr)
  end
  activity_data =
    [
      {
        name: 'baseline survey',
        description: 'Staff will survey households that received filters.',
        start_date: "01/01/2017",
        end_date: "01/03/2017",
        budget: 1500
      },
      {
        name: 'initial training',
        description: 'Volunteers will be trained to distribute filters.',
        start_date: "01/05/2017",
        end_date: "01/05/2017",
        budget: 1000
      },
      {
        name: 'distribute filters',
        description: 'Volunteers will distribute filters to the local community.',
        start_date: "01/15/2017",
        end_date: "01/25/2017",
        budget: 2000
      },
      {
        name: 'fix filters',
        description: 'Volunteers will check and fix or replace filters.',
        start_date: "01/15/2017",
        end_date: "03/15/2017",
        budget: 1500
      },
      {
        name: 'survey',
        description: 'Staff will survey households that received filters.',
        start_date: "03/15/2017",
        end_date: "03/20/2017",
        budget: 1500
      }
    ]

    # binding.pry
  activity_data.each do |data|
    logic_model.activities.create(
      name: data[:name],
      description: data[:description],
      start_date: data[:start_date],
      end_date: data[:end_date],
      budget: data[:budget])
  end
  ['trained volunteers', 'households with filters'].each do |attr|
    logic_model.outputs.create(description: attr)
  end
  ['volunteers have increased understanding of benefits of filters', 'communities are using filters'].each do |attr|
    logic_model.outcomes.create(description: attr)
  end
  ['reduction in diarrheal diseases'].each do |attr|
    logic_model.impacts.create(description: attr)
  end

  framework = program.create_framework
  survey_template = framework.survey_templates.create(name: 'Baseline survey')

  indicator = PerformanceIndicator.create(description: 'percentage of people who agree with the problem', data_source: 'survey')
  eval_question = framework.evaluative_questions.create(category: 'appropriateness', description: 'To what degree does the community agree with the problem', performance_indicators: [indicator])
  indicator = PerformanceIndicator.create(description: 'percentage of people who agree with the solution', data_source: 'observation')
  eval_question = framework.evaluative_questions.create(category: 'appropriateness', description: 'To what degree does the community agree with the solution', performance_indicators: [indicator])

  indicator = PerformanceIndicator.create(description: 'budget per beneficiary', data_source: 'survey')
  eval_question = framework.evaluative_questions.create(category: 'efficiency', description: 'Was the funding used efficiently', performance_indicators: [indicator])
  indicator2 = PerformanceIndicator.create(description: 'Number of filters installed', data_source: 'survey')
  indicator3 = PerformanceIndicator.create(description: 'Number of filters working after 6 weeks', data_source: 'observation')
  eval_question = framework.evaluative_questions.create(category: 'efficiency', description: 'Were activities carried out on time and with the desire results', performance_indicators: [indicator3, indicator2])

  indicator = PerformanceIndicator.create(description: 'percentage of people using the filters', data_source: 'survey')
  indicator1 = PerformanceIndicator.create(description: 'percentage of people who understand the benefits of using filters', data_source: 'observation')
  eval_question = framework.evaluative_questions.create(category: 'effectiveness', description: 'To what degree was the intervention adopted', performance_indicators: [indicator, indicator1])

  indicator = PerformanceIndicator.create(description: 'reduction in diarrheal diseases', data_source: 'clinical record')
  eval_question = framework.evaluative_questions.create(category: 'impact', description: 'Did the populations health improve', performance_indicators: [indicator])
  indicator = PerformanceIndicator.create(description: 'reduction in missed school days', data_source: 'school record')
  eval_question = framework.evaluative_questions.create(category: 'impact', description: 'Were children able to maintain daily schedule', performance_indicators: [indicator])

  indicator = PerformanceIndicator.create(description: 'percentage of people who want to continue using the filters', data_source: 'survey')
  eval_question = framework.evaluative_questions.create(category: 'impact', description: 'Does the population want to continue their new behaviors', performance_indicators: [indicator])

  data_question = survey_template.data_questions.create(description: 'Was a water filter installed?', question_type: 'Yes / No', display_value: 'Pie chart', survey_template_id: survey_template.id, performance_indicator_id: indicator2.id)
  data_question2 = survey_template.data_questions.create(description: 'Did the water filter function correctly?', question_type: 'Yes / No', display_value: 'Bar chart', survey_template_id: survey_template.id, performance_indicator_id: indicator3.id)
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
  data_combination = survey_template.data_combinations.create(title: 'Sucessful Filter Implementation', description: 'Filter was installed and functioned correctly.', category: 'efficiency', criterion_1: data_question.options.first.id, criterion_2: data_question2.options.first.id, data_question_1_id: data_question.id, data_question_2_id: data_question2.id, data_label_1: 'Successful installation', data_label_2: 'Failed installations')
  data_combination.analyses.create(title: data_combination.title, description: data_combination.description, display_value: 'Pie chart')
end

seed_framework

