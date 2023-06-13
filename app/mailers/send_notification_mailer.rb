class SendNotificationMailer < ApplicationMailer
    def send_email(student)
        mail to: student.email , subject: "Question answered"
    end
end
