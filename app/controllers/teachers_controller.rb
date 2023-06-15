class TeachersController < ApplicationController
    before_action :set_teacher, only: [:show,:edit,:update,:destroy]
    before_action :require_teacher, only: [:edit, :update]
    before_action :require_same_teacher, only: [:edit, :update, :destroy]
    def show
        @questions = @teacher.questions.paginate(page: params[:page], per_page: 2)
    end

    def index
        @teachers = Teacher.paginate(page: params[:page], per_page: 2)
    end

    def new
        @teacher = Teacher.new
    end

    def edit
        
    end

    def update
        if @teacher.update(teacher_params)
           flash[:notice] = "Your account information was successfully updated."
           redirect_to teacher_path(@teacher)
        else 
            render 'edit'
        end 
    end

    def create
        @teacher = Teacher.new(teacher_params)
        if @teacher.save
            session[:teacher_id] = @teacher.id
            flash[:notice] = "Hi #{@teacher.name}, Welcome to doubts solver, you have successfully signed up."
            redirect_to questions_path
        else
            render 'new'
        end
    end

    def destroy
        @teacher.destroy
        session[:teacher_id] = nil if @teacher == current_teacher
        flash[:notice] = "Account and all associated questions were deleted"
        redirect_to questions_path
    end

    private
    def teacher_params
        params.require(:teacher).permit(:name, :email, :password)
    end

    def set_teacher
        if Teacher.where(id:params[:id]) == []
            flash[:alert] = "Oops the account was deleted"
            redirect_to teachers_path
        else
            @teacher = Teacher.find(params[:id])
        end
    end

    def require_same_teacher
        if current_teacher != @teacher
            flash[:alert] = "You can only edit your own account"
            redirect_to @teacher
        end
    end
end