class Users::InvitationsController < Devise::InvitationsController
  def new
    @organization_id = current_user.organization.id
    self.resource = resource_class.new
    render :new
  end

  private
  def invite_resource(&block)
    resource_class.invite!(invite_params, current_inviter, &block)
  end

  def invite_params
    role = params['user']['role'] == '1' ? 'admin' : ''
    super.merge("role" => role, organization_id: params['user']['organization_id'])
  end
end