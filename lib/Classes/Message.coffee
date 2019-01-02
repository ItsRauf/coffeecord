_User = require "./User"
http = require "../http"

_this = null

class Message
  ###*
   * @param {Object} message
   * @constructor
  ###
  constructor: (message) ->
    for key in Object.keys message
      this[key] = message[key]
    this.author = new _User message.author
    this.timestamp = new Date(message.timestamp).getTime()
    _this = this
  ###*
   * Replies to Message
   * @param {(String|Object)} content
   * @return {Message}
  ###
  reply: (content) -> 
    __this = this
    if typeof content is "string"
      return await http "post", "/channels/#{_this.channel_id}/messages", content: content, __this._token
                    .then (data) ->
                      message = new Message data.data
                      message.reply = message.reply.bind __this
                      message.edit = message.edit.bind __this
                      message.delete = message.delete.bind __this
                      return message
    if typeof content is "object"
      return await http "post", "/channels/#{_this.channel_id}/messages", {content: content.content or "", embed: content.embed or content}, __this._token
                    .then (data) ->
                      message = new Message data.data
                      message.reply = message.reply.bind __this
                      message.edit = message.edit.bind __this
                      message.delete = message.delete.bind __this
                      return message
  ###*
   * Edits Message
   * @param {(String|Object)} content
   * @return {Message}
  ###
  edit: (content) -> 
    __this = this
    if typeof content is "string"
      return await http "patch", "/channels/#{_this.channel_id}/messages/#{_this.id}", content: content, __this._token
                    .then (data) ->
                      message = new Message data.data
                      message.reply = message.reply.bind __this
                      message.edit = message.edit.bind __this
                      message.delete = message.delete.bind __this
                      return message
    if typeof content is "object"
      return await http "patch", "/channels/#{_this.channel_id}/messages/#{_this.id}", {content: content.content or "", embed: content.embed or content}, __this._token
                    .then (data) ->
                      message = new Message data.data
                      message.reply = message.reply.bind __this
                      message.edit = message.edit.bind __this
                      message.delete = message.delete.bind __this
                      return message
  ###*
   * Deletes Message
   * @return {*}
  ###
  delete: ->
    __this = this
    return await http "delete", "/channels/#{_this.channel_id}/messages/#{_this.id}", null, __this._token
  

module.exports = Message