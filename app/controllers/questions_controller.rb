class QuestionsController < ApplicationController
    before_action :set_question, only: [:show,:edit,:update,:destroy]
    before_action :require_student, except: [:show, :index, :edit, :update, :unanswered, :index2]
    before_action :require_teacher, only: [:edit,:update]
    before_action :require_same_student, only: [ :destroy]
    before_action :check_answer_present, only: [ :update]
    def show
       if !(logged_in_as_student? || logged_in_as_teacher?)
            flash[:alert] = "Login to view question briefly"
            redirect_to root_path
       end
    end
    def index
        @questions = Question.order('created_at DESC').paginate(page: params[:page], per_page: 6)
    end
    def index1
        if session[:student_id]
           @questions = Question.where(student_id:session[:student_id]).order('created_at DESC').paginate(page: params[:page], per_page: 4)
        else
            flash[:alert] = "You have to login as student to view your questions"
            redirect_to login_path
        end
    end
    def index2
        keyword = params[:search]
        @questions = Question.where("que LIKE ?","%#{keyword}%").order('created_at DESC')
        respond_to do |format|
            format.js {render layout: false}
            format.html { render 'index2'}
        end
    end
    def unanswered
        if logged_in_as_teacher?
            @questions = Question.where(ans: nil).paginate(page: params[:page], per_page: 4)
        else
            flash[:alert] = "You have to login as teacher to view unanswered questions"
            redirect_to login2_path
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
        @domainforemail = request.host_with_port
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
            flash[:alert] = "Oops, Question got deleted. Sorry for the inconvenience"
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
    def check_answer_present
        if !@question.ans.nil? && current_teacher.id != @question.teacher_id
            flash[:alert] = "The question has already been answered by some other teacher. You can answer other questions."
            redirect_to questions_path
        end
    end

end
