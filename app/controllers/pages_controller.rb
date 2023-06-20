class PagesController < ApplicationController
    def home
        if logged_in_as_student?
            t = StudentTopic.where(student_id:current_student.id).pluck(:topic_id)
            q = QuestionTopic.where(topic_id:t).pluck(:question_id)
            @questions = Question.where(id:q).paginate(page: params[:page], per_page: 3)
        end
    end
    def stats
    end
    def update
        if params[:x1]=='Follow' && StudentTopic.find_by(student_id: params[:s_id], topic_id: params[:t_id]).nil?
            s = StudentTopic.new(student_id: params[:s_id], topic_id: params[:t_id])
            s.save
        elsif params[:x1]=='Unfollow' && !StudentTopic.find_by(student_id: params[:s_id], topic_id: params[:t_id]).nil?
            StudentTopic.destroy_by(student_id: params[:s_id], topic_id: params[:t_id])
        end

        respond_to do |format|
            format.js  # <-- will render `app/views/posts/update.js.erb`
        end
    end
    # def follow
    #     s = StudentTopic.new(student_id: params[:student_id], topic_id: params[:topic_id])
    #     s.save

    # end
    # def unfollow
    #     StudentTopic.destroy_by(student_id: params[:student_id], topic_id: params[:topic_id])
    # end
end
