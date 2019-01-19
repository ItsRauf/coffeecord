# Classes
_User = require "./src/User"
_Guild = require "./src/Guild"
_Message = require "./src/Message"
http = require "./http"

# Modules
WS = require "ws"
EE = require "events"
OS = require "os"

Socket = new WS "wss://gateway.discord.gg/?v=6&encoding=json"

_this = null


class Client extends EE
  ###*
   * @param {String} token
   * @param {Object} [options]
   * @constructor
  ###
  constructor: (token, options) ->
    super()
    this._connected = false
    this._token = token
    if options?
      this._options = options
    else
      this._options = 
        status: {}
    this._heartbeat_interval = null
    this._session_id = null
    this.guilds = new Map()
    _this = this
  connect: ->
    Socket.on "open", () ->
      # Do Nothing Now
    Socket.on "message", (message) ->
      msg = JSON.parse message
      if msg.op is 10
        _this._heartbeat_int = msg.d.heartbeat_interval
        ###*
         * Send a Heartbeat
         * @return {*}
        ###
        beginHeartbeat = ->
          await Socket.send JSON.stringify 
            op: 1
            d: null
        beginHeartbeat().then( -> 
          setInterval(beginHeartbeat, _this._heartbeat_int)
        )
        await Socket.send JSON.stringify
          op: 2
          d: 
            "token": _this._token
            "properties": 
              "$os": "#{OS.platform()}"
              "$browser": "CoffeeCord"
              "$device": "CoffeeCord"
            "compress": false
            "large_threshold": 250
            "shard": [0, 1]
            "presence": _this._options.status
      if msg.op is 1
        Socket.send JSON.stringify
            op: 1
            d: null
      if msg.op is 0
        if _this._options.debug
          console.log msg.t
        switch msg.t
          when "READY"
            _this.connected = true
            _this.session_id = msg.d.session_id
            _this.user = new _User msg.d.user
            _this.emit "READY"
          when "MESSAGE_CREATE"
            message = new _Message msg.d
            message.guild = _this.guilds.get message.guild_id
            message.channel = message.guild.channels.get message.channel_id
            message.reply = message.reply.bind _this
            message.edit = message.edit.bind _this
            message.delete = message.delete.bind _this
            _this.emit "MESSAGE_CREATE", message
          when "GUILD_CREATE"
            msg.d.members.map (user) ->
              user = new _User user.user
            guild = new _Guild msg.d
            channels = [ ...guild.channels.values() ]
            channels.map (channel) ->
              channel.send.bind _this
            _this.guilds.set guild.id, guild
            _this.emit "GUILD_CREATE", guild
  ###*
   * Send a Message
   * @param {(String|Object)} content
   * @param {(String|Number)} id Channel ID
   * @return {_Message}
  ###
  send: (content, id) -> 
    __this = this
    if typeof content is "string"
      return await http "post", "/channels/#{id}/messages", content: content, this._token
                    .then (data) ->
                      message = new _Message data.data
                      message.reply = message.reply.bind __this
                      message.edit = message.edit.bind __this
                      message.delete = message.delete.bind __this
                      return message
    if typeof content is "object"
      return await http "post", "/channels/#{id}/messages", {content: content.content or content, embed: content.embed or content}, this._token
                    .then (data) ->
                      message = new _Message data.data
                      message.reply = message.reply.bind __this
                      message.edit = message.edit.bind __this
                      message.delete = message.delete.bind __this
                      return message

module.exports = Client
