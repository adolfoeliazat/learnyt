class AuthorizedController < InheritedResources::Base
  # Authorization
  authorize_resource

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to root_url
  end

  # Responders
  respond_to :html, :js

  # Resource setup
  protected
    def collection
      instance_eval("@#{controller_name.pluralize} ||= end_of_association_chain.paginate(:page => params[:page])")
    end
end
