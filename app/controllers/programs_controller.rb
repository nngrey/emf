class ProgramsController < ApplicationController

  def new
    @program = Program.new
  end

  def create
    @organization = Organization.first
    @program = @organization.programs.new(program_params)
    if @program.save
      @program.create_framework(name: "Framework for #{@program.name}")
      # logic_model = @program.logic_model || @program.create_logic_model
      redirect_to new_program_logic_model_path(@program)
      # redirect_to new_framework_evaluative_question_path(@framework)
    else
      render "new"
    end
  end

  def show
    @categories = ['appropriateness', 'efficiency', 'effectiveness', 'impact', 'sustainability']
    @program = Program.find(params[:id])
    @analyses = []
    @survey_template = @program.framework.survey_templates.first if @program.framework.survey_templates.any?
    if @survey_template.present? && @survey_template.data_combinations.any?
      @analyses = @survey_template.data_combinations.map{|dc| dc.analyses}.flatten
    end
  end

  private
  def program_params
    params.require(:program).permit(:id, :name, :budget)
  end
end