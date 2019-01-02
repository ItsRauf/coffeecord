_Channel = require "./Channel"

class Guild
  ###*
   * @param {Object} guild
   * @constructor
  ###
  constructor: (guild) ->
    for key in Object.keys guild
      this[key] = guild[key]
    this.channels = guild.channels.map (channel) ->
      new _Channel channel

module.exports = Guild