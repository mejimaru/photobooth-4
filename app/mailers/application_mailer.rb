class ApplicationMailer < ActionMailer::Base
  default from: OPTS.mail_settings['from']
  layout 'mailer'
end
