import PerfectHTTP
import PerfectHTTPServer

struct Message : Encodable {
	let hello: String
}
func handler(request: HTTPRequest, response: HTTPResponse) {
	defer { response.completed() }
	let message = Message(hello: "world")
	do {
		try response.setBody(json: message)
	} catch {
		response.status = .internalServerError
	}
}

var routes = Routes()
routes.add(method: .get, uri: "/", handler: handler)

try HTTPServer.launch(name: "localhost", port: 8080, routes: routes)
