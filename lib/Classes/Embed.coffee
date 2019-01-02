_this = null

class Embed
  ###*
   * @param {Object} embed                    embed
   * @param {String} [embed.title]            embed title
   * @param {String} [embed.description]      embed description
   * @param {String} [embed.url]              embed url
   * @param {Date}   [embed.timestamp]        embed timestanp
   * @param {Number} [embed.color]            embed color
   * @param {Object} [embed.footer]           embed footer
   * @param {String} [embed.footer.text]      embed footer text
   * @param {String} [embed.footer.icon_url]  embed footer icon url
   * @param {Object} [embed.image]            embed image
   * @param {String} [embed.image.url]        embed image url
   * @param {Number} [embed.image.height]     embed title
   * @param {Number} [embed.image.width]      embed title
   * @param {Object} [embed.thumbnail]        embed thumbnail
   * @param {String} [embed.thumbnail.url]    embed thumbnail url
   * @param {Number} [embed.thumbnail.height] embed thumbnail height
   * @param {Number} [embed.thumbnail.width]  embed thumbnail width
   * @param {Object} [embed.video]            embed video
   * @param {String} [embed.video.url]        embed video url
   * @param {Number} [embed.video.height]     embed video height
   * @param {Number} [embed.video.width]      embed video width
   * @param {Object} [embed.provider]         embed provider
   * @param {String} [embed.provider.name]    embed provider name
   * @param {String} [embed.provider.url]     embed provider url
   * @param {Object} [embed.author]           embed author
   * @param {String} [embed.author.name]      embed author name
   * @param {String} [embed.author.url]       embed author url
   * @param {String} [embed.author.icon_url]  embed author icon url
   * @param {Object[]} [embed.fields]         embed fields
   * @param {String} [embed.fields[].name]    embed fields name
   * @param {String} [embed.fields[].value]   embed fields value
   * @param {Boolean} [embed.fields[].inline] embed fields inline
   * @constructor
  ###
  constructor: (embed) ->
    for key in Object.keys embed
      this[key] = embed[key]
    if this.timestamp
      this.timestamp = embed.timestamp.toISOString()
    _this = this

module.exports = Embed