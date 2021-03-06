class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :librarian_or_admin?
  helper_method :correct_user?

  private
    def current_user
      begin
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      rescue Exception => e
        nil
      end
    end

    def user_signed_in?
      return true if current_user
    end

    def librarian_or_admin?(user=nil)
      user ||= current_user
      user_signed_in? && (user.librarian? || user.is_comp_admin? || user.is_admin?)
    end

    def correct_user?
      @user = User.find(params[:id])
      unless current_user == @user
        redirect_to root_url, :alert => "Access denied."
      end
    end

    def authenticate_user!
      if !current_user
        redirect_to root_url, :alert => 'You need to sign in for access to this page.'
      end
    end

    def check_auth
      return if current_user.try(:is_admin?)
      return if current_user.try(:librarian?)
      where = request.env["HTTP_REFERER"] || root_path
      redirect_to where, alert: 'Only librarians and admins can take that action.'
    end

end
