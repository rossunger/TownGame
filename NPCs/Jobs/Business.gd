extends Node
class_name Business # child of an inside house? 

export (String) var neighbourhood
export (String) var street
export (String) var address
export (Array, String) var staff = []
export (Array, String) var clients = []
export var clientsComeHere = true
export var staffWorkHere = true

func addClient(clientName):
	if clients.has(clientName): return false
	else:
		clients.append(clientName)
		return true

func removeClient(clientName):
	if not clients.has(clientName): return false
	else:
		clients.remove(clientName)
		return true
