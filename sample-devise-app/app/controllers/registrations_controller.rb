class RegistrationsController < Devise::RegistrationsController

    prepend_before_filter :require_no_authentication, only: [:cancel ]
    
    def new
        @user = User.new
    end

    def create
        @user = User.new(registration_params)
        if @user.valid?
            @user.save
                redirect_to user_session_path
        else
            render 'new'
        end
    end

    def registration_params
        params.require(:user).permit(:name, :first_name, :last_name, :email, :password, :password_confirmation, :role)
    end

end
