class ProgramsController < ApplicationController

  def new
    @program = Program.new
  end

  def create
    @organization = Organization.first
    @program = @organization.programs.new(program_params)
    if @program.save
      @program.create_framework(name: "Framework for #{@program.name}")
      redirect_to new_program_logic_model_path(@program)
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
    @program = Program.find(params[:id])
    @categories = ['appropriateness', 'efficiency', 'effectiveness', 'impact', 'sustainability']
    @survey_template = @program.framework.survey_templates.first if @program.framework.survey_templates.any?
    if @survey_template.present? && @survey_template.data_combinations.any?
      @data_combinations = @survey_template.data_combinations
    end
    @logic_model = @program.logic_model
    @framework = @program.framework
    @evaluative_questions = @framework.evaluative_questions
    @survey_templates = @framework.survey_templates
  end

  private
  def program_params
    params.require(:program).permit(:id, :name, :budget)
  end
end