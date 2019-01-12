BaseUser = require "./BaseUser"

class User extends BaseUser
  ###*
   * @param {Object} user
   * @constructor
  ###
  constructor: (user) ->
    super(user)
    this.mention = "<@#{this.id}>"

module.exports = User