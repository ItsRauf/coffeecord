# CoffeeCord

## About

Discord Library written in CoffeeScript

## Code Example

```coffee
CoffeeCord = require "coffeecord"

Client = CoffeeCord.Client

Client.on "ready", ->
  console.log "Ready", "Logged in as #{Client.user.username}##{Client.user.discriminator}"

Client.connect()
```

## Motivation

## Installation

npm install @itsrauf/coffeecord
