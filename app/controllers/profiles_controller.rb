class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[show destroy edit update]

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user
    if @profile.save
      redirect_to dashboard_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def delete
  end

  def update
  end

  private

  def profile_params
    params.require(:profile).permit(:name)
  end

  def set_profile
    @profile = Profile.find(params[:id])
  end
end
