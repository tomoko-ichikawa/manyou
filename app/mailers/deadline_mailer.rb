class DeadlineMailer < ApplicationMailer

  def deadline(list)
    @list = list
    mail to: "takator@yahoo.co.jp", subject: "taskを投稿しました"
  end
end
