class ProfilesController < ApplicationController
  
  # GET to /users/:user_id/profile/new
  def new
    # Render blank profile details form
    @profile = Profile.new
  end

  # POST to /users/:user_id/profile
  def create
    # Ensure that we have the user who is filling out the form
    @user = User.find( params[:user_id] )
    # Create profile linked to this specific user
    @profile = @user.build_profile( profile_params )
    if @profile.save
      flash[:success] = 'Profile updated!'
      redirect_to user_path( id: params[:user_id] )
    else
      render action: :new
      flash[:warning] = 'Sorry, something went wrong!'
    end
  end

  # GET to /users/:user_id/profile/edit
  def edit
    # Edit profile linked to this specific user
    @user = User.find( params[:user_id] )
    @profile = @user.profile
  end

  # PUT to /users/:user_id/profile
  def update
    # Retrieve the user from the user database
    @user = User.find( params[:user_id] )
    # Retrieve that users profile
    @profile = @user.profile
    # Mass assign edited profile attributes and save
    if @profile.update_attributes(profile_params)
      flash[:success] = 'Profile Updated!'
      # Redirect user to their profile page
      redirect_to user_path(id: params[:user_id])
    else
      render action: :edit
      flash[:warning] = 'Sorry, something went wrong!'
    end
  end

  private 
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
    end
end
