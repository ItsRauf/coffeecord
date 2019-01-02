CoffeeCord = require "./lib/Constants"

Client = new CoffeeCord.Client("NDcwODA1NTkxMDk1MjQ2ODQ5.DwqFRA.q9mWcZKpf0dWrFRK-2O9ZrOqCFQ", {
  status:
    game: 
      name: "CoffeeCord"
      type: 0
    status: "idle"
})

Client.on "READY", () ->
  console.log "Ready!", "Logged in as #{Client.user.username}"

Client.on "MESSAGE_CREATE", (message) ->
  if message.content.startsWith "c!"
    msg = message.content.substr 2
    switch msg
      when "ping"
        message.reply "pong"
          .then (msg) ->
            embed = new CoffeeCord.Embed
              title: "Ping"
              description: "#{msg.timestamp - message.timestamp}ms"
            msg.edit embed
            

Client.on "GUILD_CREATE", (guild) -> 

Client.connect()