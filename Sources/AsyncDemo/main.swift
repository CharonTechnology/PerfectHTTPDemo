import Foundation

import PerfectHTTP
import PerfectHTTPServer

func handler(request: HTTPRequest, response: HTTPResponse) {
	response.setHeader(.contentType, value: "text/html")
	response.appendBody(string: """
		<!DOCTYPE html>
		<html>
			<title>hello, world</title>
			<body>hello, world!</body>
		</html>
	""")
	DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
		response.completed()
	}
}

var routes = Routes()
routes.add(method: .get, uri: "/", handler: handler)

try HTTPServer.launch(name: "localhost", port: 8080, routes: routes)
