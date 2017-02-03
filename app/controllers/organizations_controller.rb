class OrganizationsController < ApplicationController

  # redirect to root if there is no organization record
  around_filter :catch_not_found

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      current_user.update(organization_id: @organization.id, role: 'admin')
      redirect_to organization_path(@organization)
    else
      render "new"
    end
  end

  def show
    @organization = Organization.find(params[:id])
  end

  private

  def catch_not_found
    yield
  rescue ActiveRecord::RecordNotFound
    redirect_to root_url
  end

  def organization_params
    params.require(:organization).permit(:name)
  end
end
