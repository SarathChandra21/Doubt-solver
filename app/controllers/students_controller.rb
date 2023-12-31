class StudentsController < ApplicationController
    before_action :set_student, only: [:show,:edit,:update,:destroy]
    before_action :require_student, only: [:edit, :update]
    before_action :require_same_student, only: [:edit, :update, :destroy]
    def show
        @questions = @student.questions.order('created_at DESC').paginate(page: params[:page], per_page: 4)
    end

    def index
        @students = Student.paginate(page: params[:page], per_page: 6)
    end

    def new
        @student = Student.new
    end

    def edit
        
    end

    def update
        if @student.update(student_params)
           flash[:notice] = "Your account information was successfully updated."
           redirect_to student_path(@student)
        else 
            render 'edit'
        end 
    end

    def create
        @student = Student.new(student_params)
        if @student.save
            session[:student_id] = @student.id
            flash[:notice] = "Hi #{@student.name}, Welcome to doubts solver, you have successfully signed up."
            redirect_to questions_path
        else
            render 'new'
        end
    end

    def destroy
        @student.destroy
        session[:student_id] = nil if @student == current_student
        flash[:notice] = "Account and all associated questions were deleted"
        redirect_to questions_path
    end

    private
    def student_params
        params.require(:student).permit(:name, :email, :password)
    end

    def set_student
        if logged_in_as_student? && Student.where(id:params[:id]) == []
            flash[:alert] = "Oops, the account was deleted."
            redirect_to root_path
        else
            @student = Student.find(params[:id])
        end
        
    end

    def require_same_student
        if current_student != @student
            flash[:alert] = "You can only edit your own account"
            redirect_to @student
        end
    end
end