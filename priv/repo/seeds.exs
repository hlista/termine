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
alias Termine.Worlds.Node
alias Termine.Worlds.State
alias Termine.StateTypes.Collectable
alias Termine.StateTypes.Loop
alias Termine.Items.Resource
alias Termine.Miners.Miner

node = Repo.insert! %Node{
  hash: "A8F34D",
  name: "The Deeprock Mines",
  intro_text: "According to local legend these mines are haunted"
}

state1 = Repo.insert! %State{
  inspect_text: "Inside the mines you find a deposit of copper ore",
  type: :mineable,
  has_been_completed: false,
  node_id: node.id

}

state2 = Repo.insert! %State{
  inspect_text: "With the copper ore depleted, you move further into the mines and find a human sized spider",
  type: :attackable,
  has_been_completed: false,
  node_id: node.id
}

state3 = Repo.insert! %State{
  inspect_text: "After defeating the spider you find yourself back at the entrance",
  type: :loop,
  has_been_completed: false,
  node_id: node.id
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

Repo.insert! %Loop{
  state_id: state3.id,
  go_to_state_id: state1.id
}

Repo.update! Ecto.Changeset.change(node, %{current_state_id: state1.id, state_id_array: [state1.id, state2.id, state3.id]})

miner = Repo.insert! %Miner{
  name: "Willace",
  description: "Willace has been with your family for generations"
}