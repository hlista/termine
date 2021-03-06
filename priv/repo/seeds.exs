# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Termine.Repo.insert!(%Termine.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Termine.Repo
alias Termine.Worlds.{Node, State, Neighbor}
alias Termine.StateTypes.{Collectable}
alias Termine.Items.Resource
alias Termine.Miners.Miner
alias Termine.Accounts
alias Termine.Characters.Player
alias Termine.Characters.Inventory
alias Termine.Miners.PlayerMiner

node1 = Repo.insert! %Node{
  hash: "A8F34D",
  name: "The Deeprock Mines",
  intro_text: "According to local legend these mines are haunted"
}

state1 = Repo.insert! %State{
  inspect_text: "Inside the mines you find a deposit of copper ore",
  type: :mineable,
  node_id: node1.id

}

state2 = Repo.insert! %State{
  inspect_text: "With the copper ore depleted, you move further into the mines and find a human sized spider",
  type: :attackable,
  node_id: node1.id
}

copper = Repo.insert! %Resource{
  name: "Copper Ore"
}

spider = Repo.insert! %Resource{
  name: "Spider Silk"
}

Repo.insert! %Collectable{
  amount: 20,
  state_id: state1.id,
  resource_id: copper.id
}

Repo.insert! %Collectable{
  amount: 20,
  state_id: state2.id,
  resource_id: spider.id
}

Repo.update! Ecto.Changeset.change(node1, %{current_state_id: state1.id, state_id_array: [state1.id, state2.id]})

node2 = Repo.insert! %Node{
  hash: "EF84ED",
  name: "The Hills of Everport",
  intro_text: "Lush rolling green hills for as far as the eye can see"
}

state4 = Repo.insert! %State{
  inspect_text: "All you can see are hills",
  type: :block,
  node_id: node2.id
}


Repo.update! Ecto.Changeset.change(node2, %{current_state_id: state4.id, state_id_array: [state4.id]})

Repo.insert! %Neighbor{
  parent_node_id: node1.id,
  child_node_id: node2.id
}

Repo.insert! %Neighbor{
  parent_node_id: node2.id,
  child_node_id: node1.id
}

node3 = Repo.insert! %Node{
  hash: "DEF34A",
  name: "The Mines of Everport",
  intro_text: "An industrial mine used by the Everport Trading Company"
}

state5 = Repo.insert! %State{
  inspect_text: "You make your way into the mines and find it empty of the usual company miners. You look around and find a deposit of copper ore",
  type: :mineable,
  node_id: node3.id

}

Repo.insert! %Collectable{
  amount: 200,
  state_id: state5.id,
  resource_id: copper.id
}

state6 = Repo.insert! %State{
  inspect_text: "As the morning progresses more and more company miners enter into the mines and begin mining the copper",
  type: :mineable,
  node_id: node3.id
}

Repo.insert! %Collectable{
  amount: 100,
  state_id: state6.id,
  resource_id: copper.id
}

state7 = Repo.insert! %State{
  inspect_text: "At mid day the mines are full of company miners and it is hard to find a spot to mine copper",
  type: :block,
  node_id: node3.id
}

Repo.update! Ecto.Changeset.change(node3, %{current_state_id: state5.id, state_id_array: [state5.id, state6.id, state7.id]})

Repo.insert! %Neighbor{
  parent_node_id: node3.id,
  child_node_id: node2.id
}

Repo.insert! %Neighbor{
  parent_node_id: node2.id,
  child_node_id: node3.id
}

miner = Repo.insert! %Miner{
  name: "Willace",
  description: "You met Willace in the stone tavern inn and paid for his lodging. He hasn't left your side since"
}

users = Enum.map(1..100, fn x ->
  email_address = Integer.to_string(x) <> "@" <> Integer.to_string(x)
  password = "111111111111"
  {:ok, user} = Accounts.register_user(%{email: email_address, password: password})
  player = Repo.insert! %Player{
    user_id: user.id,
    location_id: node1.id,
    username: Integer.to_string(x)
  }
  Repo.insert! %Inventory {
    player_id: player.id
  }
  Repo.insert! %PlayerMiner {
    player_id: player.id,
    miner_id: miner.id
  }
end)