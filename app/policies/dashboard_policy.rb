# app/policies/dashboard_policy.rb
class DashboardPolicy < Struct.new(:context, :dashboard)
  def show?
    if context.session[:profile_id]
      context.user == Profile.find(context.session[:profile_id]).user
    else
      true
    end
  end
end
