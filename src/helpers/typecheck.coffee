module.exports = (val) ->
  Object.prototype.toString
    .call val
      .slice 8, -1
      .toLowerCase()
