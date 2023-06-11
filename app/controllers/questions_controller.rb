class QuestionsController < ApplicationController
    before_action :set_question, only: [:show,:edit,:update,:destroy]
    
    def show
       
    end
    def index
        @questions = Question.paginate(page: params[:page], per_page: 3)
    end
    def create
        @question = Question.new(question_params)
        #@question.user = current_user
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
        
        if @question.update(question_params)
            flash[:notice] = "Question solved Successfully"
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
        @question = Question.find(params[:id])
    end

    def question_params
        params.require(:question).permit(:que,:ans)
    end

end
