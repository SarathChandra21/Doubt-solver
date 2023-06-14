class PagesController < ApplicationController
    def home
    end
    def stats
    end
    def update
        if StudentTopic.find_by(student_id: params[:s_id], topic_id: params[:t_id]).nil?
            s = StudentTopic.new(student_id: params[:s_id], topic_id: params[:t_id])
            s.save
        else
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
