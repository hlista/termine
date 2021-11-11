defmodule TermineWeb.Schema.Mutations.NodeTest do
  use Termine.DataCase, async: true

  @create_node_doc """
  mutation CreateNode($name: String!, $intro_text: String!, $current_state_id: ID!) {
    createNode(name: $name, intro_text: $intro_text, current_state_id: $current_state_id) {
      id
      name
      hash
      intro_text
      current_state{
        id
      }
    }
  }
  """

  @update_node_doc """
  mutation UpdateNode($id: ID!, $name: String!, $intro_text: String!, $current_state_id: ID!, $state_id_array: list_of(ID!)){
    updateNode(id: $id, name: $name, intro_text: $intro_text, current_state_id: $current_state_id, state_id_array, $state_id_array){
      id
      name
      hash
      intro_text
      current_state{
        id
      }
      state_id_array
    }
  }
  """
end