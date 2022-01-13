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

const SELF_QUERY = gql`
	query Self {
		self{
			location{
				name
				introText
				currentState{
					inspectText
				}
			}
		}
	}
`;

export default function Home() {

	const { data, loading, error } = useQuery(SELF_QUERY);

	if (loading) return <p>Loading...</p>;
	if (error) return <p>{error.message}</p>;

	return(
		<div className="flex flex-col">
			<p className="text-center text-4xl"> {data.self.location.name} </p>
			<p className="text-center"> {data.self.location.introText} </p>
			<p className="text-center text-2xl"> {data.self.location.currentState.inspectText} </p>

		</div>
		);
}