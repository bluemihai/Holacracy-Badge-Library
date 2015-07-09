class SessionsController < ApplicationController

  def new
    redirect_to '/auth/google_oauth2'
  end

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by(name: auth.info.name)
    if user && auth.info.email.ends_with?('@holacracyone.com')
      reset_session
      user.update_attributes(email: auth.info.email)
      session[:user_id] = user.id
      redirect_to users_path, :notice => 'Signed in!'
    else
      redirect_to root_path, :alert => 'Sorry, you are not an authorized H1 Partner.'
    end
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
