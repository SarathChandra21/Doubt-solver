class SessionsController < ApplicationController
    def new
        if logged_in_as_student?
            flash[:alert] = "You are already logged in"
            redirect_to root_path
        elsif logged_in_as_teacher?
            flash[:alert] = "You are already logged in"
            redirect_to root_path
        end
    end
    def create
        student = Student.find_by(email: params[:session][:email].downcase)
        if student && student.authenticate(params[:session][:password])
            session[:student_id] = student.id
            flash[:notice] = "Logged in successfully"
            redirect_to student
        else
            flash.now[:alert] = "Wrong credentials"
            render 'new'
        end
    end
    def destroy
        session[:student_id] = nil
        session[:teacher_id] = nil
        flash[:notice] = "Logged out"
        redirect_to root_path
    end
    def new2
        if logged_in_as_student?
            flash[:alert] = "You are already logged in"
            redirect_to root_path
        elsif logged_in_as_teacher?
            flash[:alert] = "You are already logged in"
            redirect_to root_path
        end
    end
    def create2
        teacher = Teacher.find_by(email: params[:session][:email].downcase)
        if teacher && teacher.authenticate(params[:session][:password])
            session[:teacher_id] = teacher.id
            flash[:notice] = "Logged in successfully"
            redirect_to teacher
        else
            flash.now[:alert] = "Wrong credentials"
            render 'new2'
        end
    end

end
