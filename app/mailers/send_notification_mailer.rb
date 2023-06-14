class SendNotificationMailer < ApplicationMailer
    def send_email(question)
        @question = question
        @student = Student.find(@question.student_id)
        @teacher = Teacher.find(@question.teacher_id)
        mail to: s@student.email , subject: "Question answered"
    end
end
