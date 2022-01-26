import React from "react";
import { useQuery, gql } from "@apollo/client";
import Location from "./Location.js"
import Inventory from "./Inventory.js"
import Minerbar from "./Minerbar.js"

export default function Home() {

	return(
		<div className="h-screen overflow-hidden">
			<div className="flex">
				<Inventory />
				<Location />
				<Minerbar />
			</div>
		</div>
	);
}