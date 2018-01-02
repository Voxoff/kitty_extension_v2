################################################################################
################################################################################
################################################################################
################################################################################


# All the useful Facebook curls.
# --> ALWAYS <-- Replace the ngrok and the access token to your own
# You should set the whitelist domain before setting the home url


################################################################################
################################################################################
################################################################################
################################################################################

EAAdHTu6J8uMBAKGf6QDZB4KWD07UZAC9q3lPAs3Hwk4CojqZA4pBSqPnSQ8EY3ZB0Pk8yrBD8x9AUYghHMziMjb7JtW6N6ZCFHjZAheQvdDa15gBMaLOMtcFLcXZB4wF9oUN1oJhSDDHT6rVcuTVzJsPmmGzVZBseciNquyRVBHBLAZDZD

# this gets all info from fb
curl -X GET "https://graph.facebook.com/v2.6/me/messenger_profile?fields=whitelisted_domains,payment_settings,target_audience,home_url,account_linking_url,greeting,persistent_menu,get_started&access_token=EAAKziwfhwZC0BACq9bkcyPMfrd249H3TNapPL8gcDyBqykPixjFZANNR3kWb2ZAdEZBiXyQyogIhsHOqDeMmKw8PyLMXiZAM2phZCczLF4YrT9CSpYcj8JM1zIzaJEA2C8pzX3SfoV5ZA317J3WOfepIZARsmSZB9ZCJ7Lg5MqPIpU9QZDZD"

# Gets all the whitelisted domain.

curl -X GET "https://graph.facebook.com/v2.6/me/messenger_profile?fields=whitelisted_domains&access_token=EAAdHTu6J8uMBAJATzQaUGcUvOuGQJ94d7nG5wXaIunLDmtdz0nZBWkd7sK8GSsrXnr9IhFDP1eRRjhVV8QCdxFIUWaWBM4wqte2FKzUSoN8tlXqAEk8Su1uIPdJ2G6DL0bYwn5mscLwxqXJegY2ZCpNhsYqxHZB4BIuOuVvAgZDZD"


# ADAPT this to whitelist domain. "add" != "remove"
curl -X POST -H "Content-Type: application/json" -d '{
  "setting_type" : "domain_whitelisting",
  "whitelisted_domains" : ["https://kittyextension.herokuapp.com"],
  "domain_action_type": "add"
}' "https://graph.facebook.com/v2.6/me/thread_settings?access_token=EAAdHTu6J8uMBAKGf6QDZB4KWD07UZAC9q3lPAs3Hwk4CojqZA4pBSqPnSQ8EY3ZB0Pk8yrBD8x9AUYghHMziMjb7JtW6N6ZCFHjZAheQvdDa15gBMaLOMtcFLcXZB4wF9oUN1oJhSDDHT6rVcuTVzJsPmmGzVZBseciNquyRVBHBLAZDZD"


# This initiates the home url for Kitty
curl -X POST -H "Content-Type: application/json" -d ' {
  "home_url" : {
     "url": "https://kittyextension.herokuapp.com",
     "webview_height_ratio": "tall",
     "webview_share_button": "hide",
     "in_test":false
  }
}' "https://graph.facebook.com/v2.6/me/messenger_profile?access_token=EAAdHTu6J8uMBAKGf6QDZB4KWD07UZAC9q3lPAs3Hwk4CojqZA4pBSqPnSQ8EY3ZB0Pk8yrBD8x9AUYghHMziMjb7JtW6N6ZCFHjZAheQvdDa15gBMaLOMtcFLcXZB4wF9oUN1oJhSDDHT6rVcuTVzJsPmmGzVZBseciNquyRVBHBLAZDZD"

# this initaites the greeting

curl -X POST -H "Content-Type: application/json" -d '{
    "greeting": "[
                    {
                      "locale":"default",
                      "text":"Here to help track group spending. Press get started to see you dashboard or learn how to get started with your friends."
                    }
                  ]",
}' "https://graph.facebook.com/v2.6/me/messenger_profile?access_token=EAAdHTu6J8uMBAKGf6QDZB4KWD07UZAC9q3lPAs3Hwk4CojqZA4pBSqPnSQ8EY3ZB0Pk8yrBD8x9AUYghHMziMjb7JtW6N6ZCFHjZAheQvdDa15gBMaLOMtcFLcXZB4wF9oUN1oJhSDDHT6rVcuTVzJsPmmGzVZBseciNquyRVBHBLAZDZD"

# This is the get started payload

curl -X POST -H "Content-Type: application/json" -d '{
  "get_started":{
    "payload":"We are Kitty!"
  }
}' "https://graph.facebook.com/v2.6/me/messenger_profile?access_token=EAAdHTu6J8uMBAKGf6QDZB4KWD07UZAC9q3lPAs3Hwk4CojqZA4pBSqPnSQ8EY3ZB0Pk8yrBD8x9AUYghHMziMjb7JtW6N6ZCFHjZAheQvdDa15gBMaLOMtcFLcXZB4wF9oUN1oJhSDDHT6rVcuTVzJsPmmGzVZBseciNquyRVBHBLAZDZD"

#This is for the get started page


 curl -X POST -H "Content-Type: application/json" -d '{
 "greeting":[
     {
     "locale":"default",
     "text":"Extension to help track group spending. Press get started to see you dashboard or learn how to get started with your friends."
     }, {
     "locale":"en_US",
     "text":"Extension to help track group spending. Press get started to see you dashboard or learn how to get started with your friends."
     }
 ]
 }' "https://graph.facebook.com/v2.6/me/messenger_profile?access_token=EAAdHTu6J8uMBAKGf6QDZB4KWD07UZAC9q3lPAs3Hwk4CojqZA4pBSqPnSQ8EY3ZB0Pk8yrBD8x9AUYghHMziMjb7JtW6N6ZCFHjZAheQvdDa15gBMaLOMtcFLcXZB4wF9oUN1oJhSDDHT6rVcuTVzJsPmmGzVZBseciNquyRVBHBLAZDZD"
