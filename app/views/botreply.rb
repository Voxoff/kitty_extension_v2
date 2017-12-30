def reply(sender)
  my_reply = {
                "messaging_type": "RESPONSE",
                "recipient": {
                  "id": "#{sender}"
                },
                "message": {
                "attachment": {
                                "type": "template",
                                "payload": {
                                "template_type": "generic",
                                  "elements": [{
                                    "title": "Hello Kitty",
                                    "subtitle": "The best app for money sharing",
                                    "image_url": "https://scontent-lhr3-1.xx.fbcdn.net/v/t1.0-9/24293918_160361861383576_6874016573394267944_n.png?oh=90e1db160eb8e58d77aba118de11967e&oe=5A93E6C4",
                                    "buttons": [{
                                      "type": "web_url",
                                      "url": "#{ENV['NGROK']}",
                                      "title": "Open Kitty",
                                      "webview_height_ratio": "tall",
                                      "webview_share_button": "hide",
                                      "messenger_extensions": true
                                    }],
                                  }]
                                }
                              }
                }
              }
  return my_reply
end

def get_started_reply(sender)
  my_reply = {
                "messaging_type": "RESPONSE",
                "recipient": {
                  "id": "#{sender}"
                },
                "message": {
                  "text": "Hi there, I'm Kitty. I help you and your friends stay ontop of group spending. See your profile or find out more by clicking the buttons below.",
                  "quick_replies":[
                                    {
                                      "content_type":"text",
                                      "title":"See Profile",
                                      "payload":"See Profile",
                                    },
                                    {
                                      "content_type":"text",
                                      "title":"What is Kitty?",
                                      "payload":"Help",
                                    },
                                    {
                                      "content_type":"text",
                                      "title":"Future Plans",
                                      "payload":"Future Plans",
                                    },
                                    {
                                      "content_type":"text",
                                      "title":"FAQs",
                                      "payload":"Get Started Info"
                                    }
                                  ]
                }
              }
  return my_reply
end

def how_do_i_open_reply(sender)
  my_reply = {
                "messaging_type": "RESPONSE",
                "recipient": {
                  "id": "#{sender}"
                },
                "message": {
                  "text": "When in a group chat, just press the plus button above the keyboard to see all your Messenger Extensions. Kitty should be in there! If you don't see the plus button, please upgrade Messenger. ",
                  "quick_replies":[
                                    {
                                      "content_type":"text",
                                      "title":"See Profile",
                                      "payload":"See Profile",
                                    },
                                    {
                                      "content_type":"text",
                                      "title":"What is Kitty?",
                                      "payload":"Help",
                                    },
                                    {
                                      "content_type":"text",
                                      "title":"Future Plans",
                                      "payload":"Future Plans",
                                    },
                                    {
                                      "content_type":"text",
                                      "title":"FAQs",
                                      "payload":"Get Started Info"
                                    }
                                  ]
                }
              }
  return my_reply
end

def greeting_reply(sender)
  my_reply = {
                "messaging_type": "RESPONSE",
                "recipient": {
                  "id": "#{sender}"
                },
                "message": {
                  "text": "Hi there! See your profile or find out more by clicking the button's below.",
                  "quick_replies":[
                                    {
                                      "content_type":"text",
                                      "title":"See Profile",
                                      "payload":"See Profile",
                                    },
                                    {
                                      "content_type":"text",
                                      "title":"What is Kitty?",
                                      "payload":"Help",
                                    },
                                    {
                                      "content_type":"text",
                                      "title":"Future Plans",
                                      "payload":"Future Plans",
                                    },
                                    {
                                      "content_type":"text",
                                      "title":"FAQs",
                                      "payload":"Get Started Info"
                                    }
                                  ]
                }
              }
  return my_reply
end

def thumbsup_reply(sender)
  my_reply = {
                "messaging_type": "RESPONSE",
                "recipient": {
                  "id": "#{sender}"
                },
                "message": {
                  "text": "Thumbs up to you too! But I'm more interested in tracking your spending, so maybe ask me a question about that?",
                  "quick_replies":[
                                    {
                                      "content_type":"text",
                                      "title":"Start Kitty",
                                      "payload":"Start Kitty",
                                    },
                                    {
                                      "content_type":"text",
                                      "title":"What is Kitty?",
                                      "payload":"Help",
                                    },
                                    {
                                      "content_type":"text",
                                      "title":"FAQs",
                                      "payload":"Get Started Info"
                                    }
                                  ]
                }
              }
  return my_reply
end

def generic_sticker_reply(sender)
  my_reply = {
                "messaging_type": "RESPONSE",
                "recipient": {
                  "id": "#{sender}"
                },
                "message": {
                  "text": "Thanks for the emoji... Seriously though, I'm more interested in tracking your spending, so ask me a question about that?"
                }
              }
  return my_reply
end

def basic_info_reply(sender)
  my_reply = {
                "messaging_type": "RESPONSE",
                "recipient": {
                  "id": "#{sender}"
                },
                "message": {
                  "text": "I'm Kitty! I'll help you track shared expenses right inside your group chats. Never let anyone forget to pay you back again!",
                  "quick_replies":[
                                    {
                                      "content_type":"text",
                                      "title":"Start Kitty",
                                      "payload":"Start Kitty",
                                    },
                                    {
                                      "content_type":"text",
                                      "title":"More Details",
                                      "payload":"Help",
                                    },
                                    {
                                      "content_type":"text",
                                      "title":"FAQs",
                                      "payload":"FAQs"
                                    }
                                  ]
                }
              }
  return my_reply
end

def future_plans_reply(sender)
  my_reply = {
                "messaging_type": "RESPONSE",
                "recipient": {
                  "id": "#{sender}"
                },
                "message": {
                  "text": "Kitty has loads of development plans for the future. Our three main targets right now are: 1. Integrate closely with Facebook Payments 2. Enable splitting by percentages 3. Develop receipt recognition technology. More details will be given on our website.",
                  "quick_replies":[
                                    {
                                      "content_type":"text",
                                      "title":"Start Kitty",
                                      "payload":"Start Kitty",
                                    },
                                    {
                                      "content_type":"text",
                                      "title":"See website",
                                      "payload":"Website",
                                    },
                                    {
                                      "content_type":"text",
                                      "title":"FAQs",
                                      "payload":"FAQs"
                                    }
                                  ]
                }
              }
  return my_reply
end

def help_reply(sender)
  my_reply = {
                "messaging_type": "RESPONSE",
                "recipient": {
                  "id": "#{sender}"
                },
                "message": {
                  "text": "What sort of help do you need? I can explain how to start working with Kitty, explain more about Kitty and more...",
                  "quick_replies":[
                                    {
                                      "content_type":"text",
                                      "title":"Start Kitty",
                                      "payload":"Start Kitty",
                                    },
                                    {
                                      "content_type":"text",
                                      "title":"More Details",
                                      "payload":"Help",
                                    },
                                    {
                                      "content_type":"text",
                                      "title":"FAQs",
                                      "payload":"FAQs"
                                    }
                                  ]
                }
              }
  return my_reply
end

def more_details_reply(sender)
  my_reply = {
                "messaging_type": "RESPONSE",
                "recipient": {
                  "id": "#{sender}"
                },
                "message": {
                  "text": "Kitty is a messenger extension. This is a web application built right into Facebook Messenger. Kitty wants to help you track your group expenses, whether thats with your flat mates, on a group holiday or between a couple. Once in Kitty, you will find a Dashboard for your spending, and if you open Kitty in a group chat, you will be able to track spending for that Group!",
                  "quick_replies":[
                                    {
                                      "content_type":"text",
                                      "title":"Start Kitty",
                                      "payload":"Start Kitty",
                                    },
                                    {
                                      "content_type":"text",
                                      "title":"FAQs",
                                      "payload":"FAQs"
                                    }
                                  ]
                }
              }
  return my_reply
end

def starting_kitty_reply(sender)
  my_reply = {
                "messaging_type": "RESPONSE",
                "recipient": {
                  "id": "#{sender}"
                },
                "message":{
                            "attachment":{
                              "type":"template",
                              "payload":{
                                "template_type":"button",
                                "text": "Click the button below to create/open your profile! However, the real magic begins when you open the Kitty app in a group chat. Just press the + button and then click on Kitty! (Only on mobile for now)",
                                "buttons":[
                                  {
                                    "type": "web_url",
                                    "url": "#{ENV['NGROK']}",
                                    "title": "Open Kitty",
                                    "webview_height_ratio": "tall",
                                    "webview_share_button": "hide",
                                    "messenger_extensions": true
                                  },
                                ]
                              }
                            }
                          }
              }
  return my_reply
end

def faq_reply(sender)
  my_reply = {
                "messaging_type": "RESPONSE",
                "recipient": {
                  "id": "#{sender}"
                },
                "message": {
                  "text": "There are normally three questions we get asked: 1. How does Kitty work? 2. Does Kitty intrude on my group chat? 3. Can I pay people through Kitty? Would you like to find out about them?",
                  "quick_replies":[
                                    {
                                      "content_type":"text",
                                      "title":"Question 1?",
                                      "payload":"Question1",
                                    },
                                    {
                                      "content_type":"text",
                                      "title":"Question 2?",
                                      "payload":"Question2",
                                    },
                                    {
                                      "content_type":"text",
                                      "title":"Question 3?",
                                      "payload":"Question3",
                                    }
                                  ]
                }
              }
  return my_reply
end

def how_does_kitty_work_reply(sender)
  my_reply = {
                "messaging_type": "RESPONSE",
                "recipient": {
                  "id": "#{sender}"
                },
                "message": {
                  "text": "Kitty is built right into Messenger. When you open it up, Kitty will use your public profile details (i.e. name and profile pciture) to create a dashboard. If you open Kitty in a chat with a friend/friends, you can then create a Kitty to keep track of all your shared spending. Kitty will simplify repayments over time so that buying a round is never a hassle again.",
                  "quick_replies":[
                                    {
                                      "content_type":"text",
                                      "title":"Question 2?",
                                      "payload":"Question2",
                                    },
                                    {
                                      "content_type":"text",
                                      "title":"Question 3?",
                                      "payload":"Question3",
                                    },
                                    {
                                      "content_type":"text",
                                      "title":"Start Kitty",
                                      "payload":"Start Kitty",
                                    }
                                  ]
                }
              }
  return my_reply
end

def does_kitty_intrude_reply(sender)
  my_reply = {
                "messaging_type": "RESPONSE",
                "recipient": {
                  "id": "#{sender}"
                },
                "message": {
                  "text": "When you create a Kitty for a group, a message is sent to the group so that your friends can join the Kitty. Past this, Kitty can always sit quietly in the background and never send another message to the group again. If you want to share new expenses or repayments with your friends though, you can do this easily when they are added. You can also set repayment reminders!",
                  "quick_replies":[
                                    {
                                      "content_type":"text",
                                      "title":"Question 1?",
                                      "payload":"Question1",
                                    },
                                    {
                                      "content_type":"text",
                                      "title":"Question 3?",
                                      "payload":"Question3",
                                    },
                                    {
                                      "content_type":"text",
                                      "title":"Start Kitty",
                                      "payload":"Start Kitty",
                                    }
                                  ]
                }
              }
  return my_reply
end

def can_i_pay_reply(sender)
  my_reply = {
                "messaging_type": "RESPONSE",
                "recipient": {
                  "id": "#{sender}"
                },
                "message": {
                  "text": "Right now, Kitty is just for tracking expenses over time and you can settle up with people when you do pay them back via Bank Transfer, Cash etc. Person to person in app payments will be coming soon though!",
                  "quick_replies":[
                                    {
                                      "content_type":"text",
                                      "title":"Question 1?",
                                      "payload":"Question1",
                                    },
                                    {
                                      "content_type":"text",
                                      "title":"Question 2?",
                                      "payload":"Question2",
                                    },
                                    {
                                      "content_type":"text",
                                      "title":"Start Kitty",
                                      "payload":"Start Kitty",
                                    }
                                  ]
                }
              }
  return my_reply
end

def see_profile_reply(sender)
  my_reply = {
                "messaging_type": "RESPONSE",
                "recipient": {
                  "id": "#{sender}"
                },
                "message":{
                            "attachment":{
                              "type":"template",
                              "payload":{
                                "template_type":"button",
                                "text": "Here's your Dashboard!",
                                "buttons":[
                                  {
                                    "type": "web_url",
                                    "url": "#{ENV['NGROK']}",
                                    "title": "Open Kitty",
                                    "webview_height_ratio": "tall",
                                    "webview_share_button": "hide",
                                    "messenger_extensions": true
                                  },
                                ]
                              }
                            }
                          }
              }
  return my_reply
end

def website_info_reply(sender)
  my_reply = {
                "messaging_type": "RESPONSE",
                "recipient": {
                  "id": "#{sender}"
                },
                "message":{
                            "attachment":{
                              "type":"template",
                              "payload":{
                                "template_type":"button",
                                "text": "You want to find out more about us on our website? Awesome! The link is below:",
                                "buttons":[
                                  {
                                    "type": "web_url",
                                    "url": "http://www.kittysplit.co.uk/",
                                    "title": "Open Kitty",
                                    "webview_height_ratio": "full",
                                  },
                                ]
                              }
                            }
                          }
              }
  return my_reply
end
