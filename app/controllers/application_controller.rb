class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(user)
    if user.profile.empty?
      stored_location_for(user) || new_profile_path
    else
      dashboard_path
    end
  end
end
