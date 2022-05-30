class SessionController < ApplicationController
  def new; end
    def create
      user = User.find_by(email: params[:email])
      # finds existing user, checks to see if user can be authenticated
      if user.present? && user.authenticate(params[:password])
      # sets up user.id sessions
        session[:user_id] = user.id
        redirect_to root_path, notice: 'Logged in successfully'
      else
        flash.now[:alert] = 'Invalid email or password'
        render :new
      end
    end
    def edit
      @user = User.find(params[:id])
    end
  
    def update
      @user = User.find(params[:id])
      # logger.debug "Log Film: #{@film.inspect}"
      if @user.update(user_params)
        logger.debug "Log Film: #{user_params.inspect}"
        redirect_to root_path, notice: 'Successfully Edit Account'
      else
        redirect_to edit_account_path, notice: "Invalid Format #{@user.errors.full_messages.to_sentence}"
      end
    end
    def get_datauser
      render json: { data: User.all }
    end
    def destroy
      # deletes user session
      session[:user_id] = nil
      redirect_to root_path, notice: 'Logged Out'
    end
    private
    def user_params
      params.require(:user).permit(:name)
    end
end
