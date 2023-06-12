class ApplicationController < ActionController::Base
    helper_method :current_student, :logged_in_as_student?

    def current_student
        @current_student ||= Student.find(session[:student_id]) if session[:student_id]
    end

    def logged_in_as_student?
        !!current_student
    end

    def require_student
        if !logged_in_as_student? 
            flash[:alert] = "You must be logged in to perform that action"
            redirect_to login_path
        end
    end
end
