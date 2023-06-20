class SendNotificationMailer < ApplicationMailer
    include Rails.application.routes.url_helpers
    def send_email(question)
        @question = question
        @student = Student.find(@question.student_id)
        @teacher = Teacher.find(@question.teacher_id)
        mail to: @student.email , subject: "Question answered"
    end
end
