require 'sendgrid-ruby'
include SendGrid


SendGrid::API_KEY = ENV['SENDGRID_API_KEY']

