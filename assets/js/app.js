// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html"

import React from "react";
import ReactDOM from "react-dom";
import { BrowserRouter as Router, Route, Link } from 'react-router-dom'

class Home extends React.Component {
	render() {
		return (
			<div>
				<h1>Hello React!</h1>
			</div>
		)
	}
}


class App extends React.Component {
	render() {
		return(
			<Router>
				<div>
					<Route exact path="/" component={Home}/>
				</div>
			</Router>
		)
	}
}

ReactDOM.render(
	<App/>,
	document.getElementById("termine-react")
)