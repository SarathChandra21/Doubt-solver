class SessionsController < ApplicationController
    def new
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
        flash[:notice] = "Logged out"
        redirect_to root_path
    end

end
