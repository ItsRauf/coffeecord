class BaseUser
  ###*
   * @param {Object} user
   * @constructor
  ###
  constructor: (user) ->
    for key in Object.keys user
      this[key] = user[key]
    this.bot = user.bot || false

module.exports = BaseUser