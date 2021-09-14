class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[show destroy edit update]

  def index
    @profiles = policy_scope(Profile)
  end

  def new
    @profile = Profile.new
    authorize @profile
  end

  def create
    @profile = Profile.new(profile_params)
    authorize @profile
    @profile.user = current_user
    if @profile.save
      redirect_to dashboard_path(profile_id: @profile.id)
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def destroy
    @id = params[:id]
    @profile = Profile.find(@id)
    authorize @profile
    @profile.destroy
    redirect_to profiles_path
  end

  def update
  end

  private

  # USUAL HELPERS
  def profile_params
    params.require(:profile).permit(:name)
  end

  def set_profile
    @profile = Profile.find(params[:id])
  end
end
