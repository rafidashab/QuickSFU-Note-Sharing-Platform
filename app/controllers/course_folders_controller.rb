class CourseFoldersController < ApplicationController
	require 'RMagick'
  	include Magick
	def show
		@course_folder = CourseFolder.find(params[:id])
		@notes = @course_folder.notes
		@user = @course_folder.user
	end
	def new
		if !logged_in?
			flash[:danger] = "Please log in to add courses"
			redirect_to welcome_path
		end
		@course_folder = CourseFolder.new
	end
	def create
		@course = Course.find_by(name: params[:course_folder][:name])
		@course_folder = CourseFolder.new(course_folder_params)
		@user = current_user
		if correct_user?(@user)
			if @course
				if !@user.course_folders.any? {|x| x.name == @course.name}
					@user.course_folders << @course_folder
					if @user.save 
						flash[:success] = "Add course successfully"
						redirect_to user_path(@user)
					else
						flash.now[:danger] = "Fail to add course"
						render 'new'
					end
				else
					flash.now[:danger] = "Course is already in your list"
					render 'new'
				end
			else
				flash.now[:danger] = "Course not found"
				render 'new'
			end
		else
			flash[:danger] = "You are not allowed to see/change this information"
			redirect_to user_path(@user)
		end

	end
	def edit
		if !logged_in?
			flash[:danger] = "Please log in to edit courses"
			redirect_to welcome_path
		end
		@course_folder = CourseFolder.find(params[:id])
	end
	def upload
		@course_folder = CourseFolder.find(params[:id])
		if !logged_in?
			flash[:danger] = "Please login to upload and edit notes"
			redirect_to welcome_path and return
		end
		if params[:notes]
				params[:notes].each { |item|
					itm = @course_folder.notes.create(item: item)
					thumbPath = File.dirname(itm.item.path) + "/" + itm.item_file_name.split('.')[0] + "_thumb.jpg"
					thumbnail = ImageList.new(itm.item.path)
					thumbnail[0].thumbnail!(276, 200).write(thumbPath)

					thumbFile = File.new(thumbPath)
					itm.update_attributes(thumbnail: thumbFile)
				}
		end
		redirect_to course_folder_path(@course_folder)
	end
	def update
		@course_folder = CourseFolder.find(params[:id])
		if @course_folder
			if @course_folder.update_attributes(course_folder_params)
				flash[:succes] = "Update successfully";
				redirect_to @course_folder
			end
		else
			flash[:danger] = "Course not found";
			redirect_to welcome_path
		end
	end
    
    def upvote
        @course_folder = CourseFolder.find(params[:id])
        @course_folder.upvote_by current_user
        redirect_to course_folder_path(@course_folder)
        
    end
    
    def downvote
        @course_folder = CourseFolder.find(params[:id])
        @course_folder.downvote_by current_user
        redirect_to course_folder_path(@course_folder)	
    end

    def destroy
    	CourseFolder.find(params[:id]).destroy
    	redirect_to request.referer
    	# course = params[:course_id]
    	# redirect_to course_path(course)
  	end
    
	private
		def course_folder_params
			params.require(:course_folder).permit(:name, :title, :year, :term, :notes)
		end
end
