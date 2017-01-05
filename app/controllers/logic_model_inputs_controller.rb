# class LogicModelInputsController < ApplicationController

#   def new
#     @logic_model = LogicModel.find(params[:logic_model_id])
#     ["community support and engagement", "staff", "volunteers", "funding"].each do |input|
#       @logic_model_input = @logic_model.logic_model_inputs.build(description: input)
#     end
#   end

#   def create
#     binding.pry
#   end

# private

#   def logic_model_input_params
#     params.require(:logic_model_input).permit(:description)
#   end
# end