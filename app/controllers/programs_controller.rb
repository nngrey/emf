class ProgramsController < ApplicationController

  def new
    @program = Program.new
  end

  def create
    @organization = Organization.first
    @program = @organization.programs.new(program_params)
    if @program.save
      framework = @program.framework || @program.create_framework(name: "Framework for #{@program.name}")
      # logic_model = @program.logic_model || @program.create_logic_model
      redirect_to new_program_logic_model_path(@program)
      # redirect_to new_framework_evaluative_question_path(@framework)
    else
      render "new"
    end
  end

  private
  def program_params
    params.require(:program).permit(:id, :name)
  end
end