_Message = require "./Message"

_this = null

class Channel
  ###*
   * @param {Object} channel
   * @constructor
  ###
  constructor: (channel) ->
    for key in Object.keys channel
      this[key] = channel[key]
    _this = this

  ###*
   * Send a Message
   * @param {(String|Object)} content
   * @return {_Message}
  ###
  send: (content) ->
    __this = this
    if typeof content is "string"
      return await http "post", "/channels/#{_this.id}/messages", content: content, this._token
                    .then (data) ->
                      message = new _Message data.data
                      message.reply = message.reply.bind __this
                      message.edit = message.edit.bind __this
                      message.delete = message.delete.bind __this
                      return message
    if typeof content is "object"
      return await http "post", "/channels/#{_this.id}/messages", {content: content.content or content, embed: content.embed or content}, this._token
                    .then (data) ->
                      message = new _Message data.data
                      message.reply = message.reply.bind __this
                      message.edit = message.edit.bind __this
                      message.delete = message.delete.bind __this
                      return message
  ###*
   * Deletes Message
   * @param {(String|Number)} id Message ID
   * @return {*}
  ###
  delete: (id) ->
    __this = this
    return await http "delete", "/channels/#{_this.id}/messages/#{id}", null, __this._token
    
module.exports = Channel