class SessionsController < Devise::SessionsController
    
    def new
        @user = User.new
    end
    
    def create
        super
    end

    def destroy
        sign_out
        redirect_to new_user_session_path
    end
end
