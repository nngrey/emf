class LogicModelsController < ApplicationController

  # def new
  #   @program = Program.find(params[:program_id])
  #   @logic_model = @program.build_logic_model
  #   ["community support and engagement", "staff", "volunteers", "funding"].each do |input|
  #     @logic_model_input = @logic_model.logic_model_inputs.build(description: input)
  #   end
  #   @activity = @logic_model.activities.new
  #   @output = @logic_model.outputs.new
  #   @outcome = @logic_model.outcomes.new
  #   @impact = @logic_model.impacts.new
  # end

  # def create
  #   @program = Program.find(params[:program_id])
  #   @logic_model = @program.build_logic_model(logic_model_params)
  #   if @logic_model.save
  #     redirect_to logic_model_path(@logic_model)
  #   else
  #     render "new"
  #   end
  # end

  def edit
    @logic_model = LogicModel.find(params[:id])
    @logic_model_input = @logic_model.logic_model_inputs.new unless @logic_model.logic_model_inputs.any?
    @activity = @logic_model.activities.new unless @logic_model.activities.any?
    @output = @logic_model.outputs.new
    @outcome = @logic_model.outcomes.new
    @impact = @logic_model.impacts.new
  end

  def update
    @logic_model = LogicModel.find(params[:id])
    if @logic_model.update_attributes(logic_model_params)
      redirect_to logic_model_path(@logic_model)
    else
      render 'edit'
    end
  end

  def show
    @logic_model = LogicModel.find(params[:id])
  end

  def new_inputs
    @logic_model = LogicModel.find(params[:id])
    @program = @logic_model.program
    if @logic_model.logic_model_inputs.blank?
      ["community support and engagement", "staff", "volunteers", "funding"].each do |input|
        @logic_model_input = @logic_model.logic_model_inputs.build(description: input)
      end
    end
  end

  def create_inputs
    @logic_model = LogicModel.find(params[:id])
    @logic_model_inputs = build_and_validate_associations('logic_model_inputs')
    if @logic_model_inputs.all?(&:valid?) && @logic_model.save
      redirect_to new_logic_model_activity_path(@logic_model)
    else
      render 'new_inputs'
    end
  end

  def new_outputs
    @logic_model = LogicModel.find(params[:id])
    @logic_model.outputs.new if @logic_model.outputs.blank?
  end

  def create_outputs
    @logic_model = LogicModel.find(params[:id])
    @outputs = build_and_validate_associations('outputs')
    if @outputs.all?(&:valid?) && @logic_model.save
      redirect_to new_outcomes_logic_model_path(@logic_model)
    else
      render 'new_outputs'
    end
  end

  def new_outcomes
    @logic_model = LogicModel.find(params[:id])
    @logic_model.outcomes.new if @logic_model.outcomes.blank?
  end

  def create_outcomes
    @logic_model = LogicModel.find(params[:id])
    @outcomes = build_and_validate_associations('outcomes')
    if @outcomes.all?(&:valid?) && @logic_model.save
      redirect_to new_impacts_logic_model_path(@logic_model)
    else
      render 'new_outcomes'
    end
  end

  def new_impacts
    @logic_model = LogicModel.find(params[:id])
    @logic_model.impacts.new if @logic_model.impacts.blank?
  end

  def create_impacts
    @logic_model = LogicModel.find(params[:id])
    @impacts = build_and_validate_associations('impacts')
    if @impacts.all?(&:valid?) && @logic_model.save
      redirect_to logic_model_path(@logic_model)
    else
      render 'new_impacts'
    end
  end

  private

  #neither validates_associated nor "required: true" inline in the form are working
  #it may be a clash with cocoon or simply the way I have organized things
  #these methods depend on presence validations in the model

  def build_and_validate_associations(step)
    items = []
    if logic_model_params[("#{step}_attributes").to_sym].blank?
      item = @logic_model.send(step.to_sym).new
      item.errors.add(:description, "cannot be blank")
      items << item
    else
      items = validate_presence_of_description(step)
    end
    items
  end

  def validate_presence_of_description(step)
    items = []
    logic_model_params[("#{step}_attributes").to_sym].each do |k, v|
      if v[:description].blank?
        item = @logic_model.send(step.to_sym).new
        item.errors.add(:description, "cannot be blank")
      else
        item = @logic_model.send(step.to_sym).new(description: v[:description])
      end
      items << item
    end
    items
  end

  def logic_model_params
    params.fetch(:logic_model, {}).permit(
      :budget, :_destroy,
      logic_model_inputs_attributes:
        [:id, :description, :_destroy],
      activities_attributes:
        [:id, :name, :description, :start_date, :end_date, :budget, :_destroy],
      outputs_attributes:
        [:id, :description, :_destroy],
      outcomes_attributes:
        [:id, :description, :_destroy],
      impacts_attributes:
        [:id, :description, :_destroy],
    )
  end
end