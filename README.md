# Termine

## up and running
```
mix deps.get
mix deps.compile
mix ecto.create
mix ecto.migrate
mix run priv/repo/seeds.exs
mix phx.server
```
Redis should also be running on localhost:6379

## start mining
- Register a Dummy account at localhost:4000
- navigate to localhost:4000/graphiql
### Run the following commands
```
mutation{
  createPlayer(username: "Your Username"){
    id
    username
    location{
      hash
      name
      introText
    }
    inventory{
      inventoryItems{
        resource{
          name
        }
        amount
      }
    }
    playerMiners{
      id
    }
  }
}
```
#### Take the id from playerMiners and run
```
mutation{
  sendPlayerMiner(id: OUTPUT ID){
    id
    location{
      id
      hash
      name
      introText
    }
  }
}
```
#### Check your inventory and updates on the node with
```
query{
  self{
    username
    inventory{
      inventoryItems{
        resource{
          name
        }
        amount
      }
    }
    location{
      name
      introText
      currentState{
        inspectText
      }
    }
  }
}
```

#### Repeat the previous steps (log out and register a new account) in order to get more miners on the node

### Check on all the Players inventory with
```
query {
  players {
    username
    inventory{
      inventoryItems{
        resource{
          name
        }
        amount
      }
    }
  }
}
```
