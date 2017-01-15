class LogicModelsController < ApplicationController

  def new
    @program = Program.find(params[:program_id])
    @logic_model = @program.build_logic_model
    ["community support and engagement", "staff", "volunteers", "funding"].each do |input|
      @logic_model_input = @logic_model.logic_model_inputs.build(description: input)
    end
    @activity = @logic_model.activities.new
    @output = @logic_model.outputs.new
    @outcome = @logic_model.outcomes.new
    @impact = @logic_model.impacts.new
  end

  def create
    @program = Program.find(params[:program_id])
    @logic_model = @program.build_logic_model(logic_model_params)
    if @logic_model.save
      redirect_to logic_model_path(@logic_model)
    else
      render "new"
    end
  end

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
    @logic_model_inputs = logic_model_inputs_with_errors
    if @logic_model_inputs.all?(&:valid?) && @logic_model.update_attributes(logic_model_params)
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
    @outputs = outputs_with_errors
    if @outputs.all?(&:valid?) && @logic_model.update_attributes(logic_model_params)
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
    @outcomes = outcomes_with_errors
    if @outcomes.all?(&:valid?) && @logic_model.update_attributes(logic_model_params)
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
    @impacts = impacts_with_errors
    binding.pry
    if @impacts.all?(&:valid?) && @logic_model.update_attributes(logic_model_params)
      redirect_to logic_model_path(@logic_model)
    else
      render 'new_impacts'
    end
  end

  private

  #neither validates_associated nor "required: true" inline in the form are working
  #it may be a clash with cocoon or simply the way I have organized things
  #these methods depend on presence validations in the model
  def logic_model_inputs_with_errors
    logic_model_inputs = []
    if logic_model_params[:logic_model_inputs_attributes].blank?
      logic_model_input = @logic_model.logic_model_inputs.new
      logic_model_input.errors.add(:description, "cannot be blank")
      logic_model_inputs << logic_model_input
    else
      logic_model_params[:logic_model_inputs_attributes].each do |k, v|
        if v[:description].blank?
          logic_model_input = @logic_model.logic_model_inputs.new
          logic_model_input.errors.add(:description, "cannot be blank")
        else
          logic_model_input = @logic_model.logic_model_inputs.new(description: v[:description])
        end
        logic_model_inputs << logic_model_input
      end
    end
    logic_model_inputs
  end

  def outputs_with_errors
    outputs = []
    if logic_model_params[:outputs_attributes].blank?
      output = @logic_model.outputs.new
      output.errors.add(:description, "cannot be blank")
      outputs << output
    else
      logic_model_params[:outputs_attributes].each do |k, v|
        if v[:description].blank?
          output = @logic_model.outputs.new
          output.errors.add(:description, "cannot be blank")
        else
          output = @logic_model.outputs.new(description: v[:description])
        end
        outputs << output
      end
    end
    outputs
  end

  def outcomes_with_errors
    outcomes = []
    if logic_model_params[:outcomes_attributes].blank?
      outcome = @logic_model.outcomes.new
      outcome.errors.add(:description, "cannot be blank")
      outcomes << outcome
    else
      logic_model_params[:outcomes_attributes].each do |k, v|
        if v[:description].blank?
          outcome = @logic_model.outcomes.new
          outcome.errors.add(:description, "cannot be blank")
        else
          outcome = @logic_model.outcomes.new(description: v[:description])
        end
        outcomes << outcome
      end
    end
    outcomes
  end

  def impacts_with_errors
    impacts = []
    if logic_model_params[:impacts_attributes].blank?
      impact = @logic_model.impacts.new
      impact.errors.add(:description, "cannot be blank")
      impacts << impact
    else
      logic_model_params[:impacts_attributes].each do |k, v|
        if v[:description].blank?
          impact = @logic_model.impacts.new
          impact.errors.add(:description, "cannot be blank")
        else
          impact = @logic_model.impacts.new(description: v[:description])
        end
        impacts << impact
      end
    end
    binding.pry
    impacts
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