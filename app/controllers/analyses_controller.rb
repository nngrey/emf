class AnalysesController < ApplicationController
  def update
    @analysis = Analysis.find(params[:id])
    @analysis.update(display_value: params[:display_value])
  end
end
