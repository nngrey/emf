class ProgramsController < ApplicationController

  def new
    @program = Program.new
    @budget = @program.budgets.build
  end

  def create
    @organization = Organization.first
    @program = @organization.programs.new(program_params)
    if @program.save
      @program.create_framework(name: "Framework for #{@program.name}")
      logic_model = @program.create_logic_model
      redirect_to new_inputs_logic_model_path(logic_model)
    else
      render "new"
    end
  end

  def show
    @categories = ['appropriateness', 'efficiency', 'effectiveness', 'impact', 'sustainability']
    @program = Program.find(params[:id])
    @survey_template = @program.framework.survey_templates.first if @program.framework.survey_templates.any?
    if @survey_template.present? && @survey_template.data_combinations.any?
      @data_combinations = @survey_template.data_combinations
    end
  end

  def overview
    @tab = params[:tab].present? ? params[:tab] : 'details'
    @program = Program.find(params[:id])
    @categories = ['appropriateness', 'efficiency', 'effectiveness', 'impact', 'sustainability']
    @survey_template = @program.framework.survey_templates.first if @program.framework.survey_templates.any?
    if @survey_template.present? && @survey_template.data_combinations.any?
      @data_combinations = @survey_template.data_combinations
    end
    @logic_model = @program.logic_model
    @timeline_array = @logic_model.present? ? @logic_model.timeline_data : []
    @budget_array = @program.budget_data
    @framework = @program.framework
    @evaluative_questions = @framework.evaluative_questions
    @survey_templates = @framework.survey_templates
  end

  private
  def program_params
    params.require(:program).permit(:id, :name, :budget)
  end
end