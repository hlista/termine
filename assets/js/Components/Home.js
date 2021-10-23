import React from "react";
import { useQuery, gql } from "@apollo/client";

const PLAYER_QUERY = gql`
	query GetPlayers {
		players {
			id
			username
		}
	}
`;

export default function Home() {

	const { data, loading, error } = useQuery(PLAYER_QUERY);

	if (loading) return <p>Loading...</p>;
	if (error) return <p>ERROR</p>;

	return data.players.map(({ id, username }) => (
		<div key={id}>
			<p>{username}</p>
		</div>
		));
}