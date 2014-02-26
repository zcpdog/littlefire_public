class UserMailer < ActionMailer::Base
  default from: "no-reply@maishoudang.com"
  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: '欢迎注册我和我的小伙伴们都惊呆了网站')
  end
end
