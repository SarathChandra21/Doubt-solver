class ApplicationController < ActionController::Base
    helper_method :current_student, :logged_in_as_student? , :current_teacher, :logged_in_as_teacher?

    def current_student
        @current_student ||= Student.find(session[:student_id]) if session[:student_id]
    end

    def logged_in_as_student?
        !!current_student
    end

    def require_student
        if !logged_in_as_student? 
            flash[:alert] = "You must be logged in as student to perform that action"
            redirect_to login_path
        end
    end

    def current_teacher
        @current_teacher ||= Teacher.find(session[:teacher_id]) if session[:teacher_id]
    end

    def logged_in_as_teacher?
        !!current_teacher
    end

    def require_teacher
        if !logged_in_as_teacher? 
            flash[:alert] = "You must be logged in as teacher to perform that action"
            redirect_to login2_path
        end
    end
end
