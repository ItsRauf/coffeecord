_Channel = require "./Channel"

_this = null

class Guild
  ###*
   * @param {Object} guild
   * @constructor
  ###
  constructor: (guild) ->
    for key in Object.keys guild
      this[key] = guild[key]
    this.channels = new Map()
    _this = this
    guild.channels.map (channel) ->
      channel = new _Channel channel
      _this.channels.set channel.id, channel

module.exports = Guild