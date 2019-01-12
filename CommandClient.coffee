_Client = require "./Client"
TypeCheck = require "./src/helpers/typecheck"

_this = null

class CommandClient extends _Client
  constructor: (token, options, prefix) ->
    super(token, options)
    if TypeCheck(prefix) is "string"
      this._prefix = prefix 
    else
      throw new Error "Typeof prefix is not equal to string"
    this._commands = new Map()
    this.on "MESSAGE_CREATE", (msg) ->
      if msg.content.startsWith prefix
        name = msg.content.split(" ")[0].slice prefix.length
        tempArgs = msg.content.split " "
        tempArgs.shift()
        args = tempArgs
        if this._commands.has name
          cmd = this._commands.get name
          cmd.function(msg, args)
    _this = this
  addCommand: (name, func, options) -> 
    await _this._commands.set(name, {function: func, options: options})
  deleteCommand: (name) ->
    res = await _this._commands.delete name
    if res is false
      throw new Error "Command Deletion Failed! Does it exist?\nNote: Command names are case-sensitive"
  commands: ->
    Array.from _this._commands.keys()

module.exports = CommandClient
