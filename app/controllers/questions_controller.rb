class QuestionsController < ApplicationController
    before_action :set_question, only: [:show,:edit,:update,:destroy]
    before_action :require_student, except: [:show, :index, :edit, :update]
    before_action :require_teacher, only: [:edit,:update]
    before_action :require_same_student, only: [ :destroy]
    def show
       
    end
    def index
        @questions = Question.paginate(page: params[:page], per_page: 3)
    end
    def index1
        if session[:student_id]
           @questions = Question.where(student_id:session[:student_id]).paginate(page: params[:page], per_page: 3)
        else
            flash[:alert] = "You have to login to view your questions"
            redirect_to login_path
        end
    end
    def index2
        keyword = params[:search]
        @questions = Question.where("que LIKE ?","%#{keyword}%").paginate(page: params[:page], per_page: 3)
        respond_to do |format|
            format.html { render 'index' } 
        end
    end
    def create
        @question = Question.new(question_params)
        @question.student = current_student
        @question.teacher = Teacher.first
        if @question.save 
            flash[:notice] = "Question posted Successfully"
            redirect_to @question
        else
            render 'new'
        end
    end
    def edit
    end
    def update 
        @question.teacher = current_teacher
        if @question.update(question_params)
            flash[:notice] = "Question solved Successfully"
            if @question.notify_me == 1
                SendNotificationMailer.send_email(@question).deliver_now
            end
            redirect_to @question
        else
            render 'edit'
        end
    end
    def new
        @question = Question.new
    end
    def destroy
        
        @question.destroy
        redirect_to questions_path
    end

    private

    def set_question
        if Question.where(id:params[:id]) == []
            flash[:alert] = "Oops the question was deleted by the student!!!"
            redirect_to questions_path
        else
            @question = Question.find(params[:id])
        end
    end

    def question_params
        params.require(:question).permit(:que,:ans,:notify_me,topic_ids: [])
    end
    
    def require_same_student
        if current_student != @question.student
            flash[:alert] = "You can only delete your own question"
            redirect_to @question
        end
    end

end
