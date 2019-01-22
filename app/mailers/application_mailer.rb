# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'question@example.com'
  layout 'mailer'
end
