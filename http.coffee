http = require "axios"
baseURL = "https://discordapp.com/api/v6"

###*
 * HTTP Requests
 * @param {String} _method
 * @param {String} _endpoint
 * @param {(String|Object)} _data
 * @param {String} _token
 * @return {Object}
###
module.exports = (_method, _endpoint, _data, _token) -> 
  new Promise (res, rej) ->
    http
      method: _method
      url: baseURL + _endpoint
      headers: 
        "Authorization": "Bot #{_token}"
        "Content-Type": "application/json"
      data: JSON.stringify _data
    .then res
    .catch rej