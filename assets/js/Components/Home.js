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
	if (error) return <p>{error.message}</p>;

	return data.players.map(({ id, username }) => (
		<div key={id}>
			<h1 className="font-bold">{username}</h1>
		</div>
		));
}