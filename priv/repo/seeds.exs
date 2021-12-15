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
alias Termine.StateTypes.{Collectable, Loop, BlockUntil}
alias Termine.Items.Resource
alias Termine.Miners.Miner

node1 = Repo.insert! %Node{
  hash: "A8F34D",
  name: "The Deeprock Mines",
  intro_text: "According to local legend these mines are haunted"
}

state1 = Repo.insert! %State{
  inspect_text: "Inside the mines you find a deposit of copper ore",
  type: :mineable,
  has_been_completed: false,
  node_id: node1.id

}

state2 = Repo.insert! %State{
  inspect_text: "With the copper ore depleted, you move further into the mines and find a human sized spider",
  type: :attackable,
  has_been_completed: false,
  node_id: node1.id
}

state3 = Repo.insert! %State{
  inspect_text: "After defeating the spider you find yourself back at the entrance",
  type: :loop,
  has_been_completed: false,
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

Repo.insert! %Loop{
  state_id: state3.id,
  go_to_state_id: state1.id
}

Repo.update! Ecto.Changeset.change(node1, %{current_state_id: state1.id, state_id_array: [state1.id, state2.id, state3.id]})

miner = Repo.insert! %Miner{
  name: "Willace",
  description: "Willace has been with your family for generations"
}

node2 = Repo.insert! %Node{
  hash: "EF84ED",
  name: "The Hills of Everport",
  intro_text: "Lush rolling green hills for as far as the eye can see"
}

state4 = Repo.insert! %State{
  inspect_text: "All you can see are hills",
  type: :block_until,
  has_been_completed: false,
  node_id: node2.id
}

Repo.insert! %BlockUntil{
  state_id: state4.id,
  until_state_id: state3.id
}

state41 = Repo.insert! %State{
  inspect_text: "You cleared the deeprock mines and have progressed The Hills of Everport to the next state",
  type: :block,
  has_been_completed: false,
  node_id: node2.id
}

Repo.update! Ecto.Changeset.change(node2, %{current_state_id: state4.id, state_id_array: [state4.id, state41.id]})

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
  has_been_completed: false,
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
  has_been_completed: false,
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
  has_been_completed: false,
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