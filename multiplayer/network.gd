extends Node

const DEFAULT_PORT = 28900
const MAX_CLIENT = 4
var server = null
var client = null
var ip_address = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "Windows":
		ip_address = IP.get_local_addresses()[3]
	elif OS.get_name() == "Android":
		ip_address = IP.get_local_addresses()[0]
	else:
		ip_address = IP.get_local_addresses()[3]
	for ip in IP.get_local_addresses():
		if ip.begins_with("192.168."):
			ip_address = ip


func _connected_to_server():
	print("Success connected to server")

func _server_disconnected():
	print("Disconnected server")


func _on_connect_pressed():
	server = ENetMultiplayerPeer.new()
	server.create_server(DEFAULT_PORT, MAX_CLIENT)
	


func _on_disconnect_pressed():
	pass # Replace with function body.
