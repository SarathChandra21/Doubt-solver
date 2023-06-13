class TopicsController < ApplicationController
    before_action :require_admin, except: [:index, :show]
    def show
        @topic = Topic.find(params[:id])
        @questions = @topic.questions.paginate(page: params[:page], per_page: 3)
    end
    def new 
        @topic = Topic.new
    end
    def index
        @topics = Topic.paginate(page: params[:page], per_page: 3)
    end
    def create
        @topic = Topic.new(topic_params)
        if @topic.save
            flash[:notice] = "Topic created Successfully"
            redirect_to topics_path
        else
            render 'new'
        end

    end
    def edit
        @topic = Topic.find(params[:id])
    end
    def update
        @topic = Topic.find(params[:id])
        if @topic.update(topic_params)
            flash[:notice] = "Topic name updated successfully"
            redirect_to @topic
        else
            render 'edit'
        end
    end
    private
    def topic_params
        params.require(:topic).permit(:name)
    end
    def require_admin
        if !(logged_in_as_student? && current_student.admin?)
            flash[:alert] = "Only admins can perform that action"
            redirect_to topics_path
        end
    end
end