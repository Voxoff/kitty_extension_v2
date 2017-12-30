require_relative '../views/botreply'
class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token, :authenticate_user!

  def messenger
    if params["hub.verify_token"] == ENV['messenger_verification_token']
      render plain: params["hub.challenge"]
    else
      render plain: "error"
    end
  end

  def messenger_receive_message
    therequest = request.body.read
    data = JSON.parse(therequest)
    entries = data["entry"]
    sender = nil
    text = nil
    my_reply = nil
    entries.each do |entry|
      entry["messaging"].each do |messaging|
        if messaging["read"]
          # do nothing
        elsif messaging["delivery"]
          #do nothing
        elsif messaging["postback"]
          # Error check
          if messaging["postback"]["title"] == "Get Started"
            sender = messaging["sender"]["id"]
            my_reply = get_started_reply(sender)
          end
        elsif messaging["message"]
          sender = messaging["sender"]["id"]
          sticker = messaging["message"]["sticker_id"]
          text = messaging["message"]["text"]

          unless sticker.nil?
            if sticker.to_s.include?("369239263222822")
              my_reply = thumbsup_reply(sender)
            else
              my_reply = generic_sticker_reply(sender)
            end
          end

          unless text.nil?
            if text.downcase.include?("get started")
              my_reply = get_started_reply(sender)
            elsif text.downcase.include?("hey") || text.downcase.include?("hello") || text.downcase.include?("hi") || text.downcase.include?("whats up") || text.downcase.include?("what's up")
              my_reply = greeting_reply(sender)
            elsif text.downcase.include?("what is kitty") || text.downcase.include?("info")
              my_reply = basic_info_reply(sender)
            elsif text.downcase.include?("help") || text.downcase.include?("confused")
              my_reply = help_reply(sender)
            elsif text.downcase.include?("see profile")
              my_reply = see_profile_reply(sender)
            elsif text.downcase.include?("more details")
              my_reply = more_details_reply(sender)
            elsif text.downcase.include?("start kitty") || text.downcase.include?("starting kitty")
              my_reply = starting_kitty_reply(sender)
            elsif text.downcase.include?("faq")
              my_reply = faq_reply(sender)
            elsif text.downcase.include?("question 1")
              my_reply = how_does_kitty_work_reply(sender)
            elsif text.downcase.include?("question 2")
              my_reply = does_kitty_intrude_reply(sender)
            elsif text.downcase.include?("question 3")
              my_reply = can_i_pay_reply(sender)
            elsif text.downcase.include?("website")
              my_reply = website_info_reply(sender)
            elsif text.downcase.include?("future plans") || text.downcase.include?("future")
              my_reply = future_plans_reply(sender)
            elsif text.downcase.include?("how do i open") || text.downcase.include?("how to open") || text.downcase.include?("open") || text.downcase.include?("group chat")
              my_reply = how_do_i_open_reply(sender)
            else
              my_reply = reply(sender)
            end
          end
        end
      end
      HTTP.post(url, json: my_reply)
      puts my_reply
      render plain: my_reply
    end
  end

  def url
    "https://graph.facebook.com/v2.6/me/messages?access_token=#{ENV['ACCESS_TOKEN']}"
  end
end
