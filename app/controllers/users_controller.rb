class UsersController < ApplicationController
	before_action :correct_user, only: [:edit, :show, :update]
	def new
<<<<<<< HEAD
		#render 'signup'
		@user=User.new
	end
	def create

=======
		@user=User.new
	end
	def create
		@user = User.new(user_params)
		if @user.save
			flash[:success] = "Sign up successful"
			redirect_to login_path
		else
			render 'new'
		end
>>>>>>> d5908abbf46b4978d043da86d02f02dc454df41b
	end
	def show
		 @user = User.find(params[:id])
	end
	def edit
		
		correct_user
	end
	def update
		# @user = User.find(params[:id])
		@user = current_user
		if @user && @user.update_attributes(user_params)
			flash.now[:success] = "Update successfully"
			redirect_to @user
		else
			render 'edit'
		end
	end
	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end
		def correct_user
	      @user = User.find(params[:id])
		 	if !correct_user?(@user)
		        flash.now[:danger] = "You are not allowed to change this sort of information"
		        redirect_to root_path
	      	end
    	end
<<<<<<< HEAD


=======
>>>>>>> d5908abbf46b4978d043da86d02f02dc454df41b
end
