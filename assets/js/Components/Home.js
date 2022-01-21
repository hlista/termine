import React from "react";
import { useQuery, gql } from "@apollo/client";
import Actionbar from "./Actionbar.js"
import Location from "./Location.js"

export default function Home() {

	return(
		<div>
			<Location />
			<Actionbar />
		</div>
	);
}