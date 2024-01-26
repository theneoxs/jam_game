extends Node

# Токен апихи лидербордов нашей игры
var game_API_key = "dev_634eede2bcb1426db56ad297b0e3a2e0"
var development_mode = true
var leaderboard_key = "leaderboard_main_key"
var session_token = ""

# Куча HTTP сендеров для своих задач
var auth_http = HTTPRequest.new()
var leaderboard_http = HTTPRequest.new()
var submit_score_http = HTTPRequest.new()

var set_name_http = HTTPRequest.new()
var get_name_http = HTTPRequest.new()

func _ready():
	#Показ имени пользователя (сохраненного)
	#$NameLine.text = player_name
	_authentication_request()

#Универсальный метод по отправке и приемке данных
func add_http_sender(http_sender, func_connect, url, header, method = HTTPClient.METHOD_POST, data = {}):
	add_child(http_sender)
	http_sender.request_completed.connect(func_connect)
	# Отправка запроса
	http_sender.request(url, header, method, JSON.stringify(data) if method != HTTPClient.METHOD_GET else "")

#Инициация соединения
func _authentication_request():
	# Проверка существования сессии пользователя (авторизовывался ли он уже?)
	var player_session_exists = false
	var player_identifier : String
	var file = FileAccess.open("user://LootLocker.data", FileAccess.READ)
	if file != null:
		player_identifier = file.get_as_text()
		print("player ID="+player_identifier)
		file.close()
		
	if player_identifier != null and player_identifier.length() > 1:
		print("player session exists, id="+player_identifier)
		player_session_exists = true
	if(player_identifier.length() > 1):
		player_session_exists = true
		
	# Данные для запроса
	var data = { 
		"game_key": game_API_key, 
		"game_version": "0.0.0.1", 
		"development_mode": development_mode
		}
	
	# Если пользователь уже входил однажды - использовать его идентификатор
	if(player_session_exists == true):
		data["player_identifier"] = player_identifier
	
	var headers = ["Content-Type: application/json"]
	var url = "https://api.lootlocker.io/game/v2/session/guest"
	
	# Нода для аутентификации
	auth_http = HTTPRequest.new()
	add_http_sender(auth_http, _on_authentication_request_completed, url, headers, HTTPClient.METHOD_POST, data)
	
	# Печать результатов для дебага
	print(data)

#Обработка инициации соединения
func _on_authentication_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	
	# Печать ответа сервера
	print(json.get_data())
	
	# Сохранение идентификатора в файл (можно в дальнейшем переиспользовать)
	var file = FileAccess.open("user://LootLocker.data", FileAccess.WRITE)
	file.store_string(json.get_data().player_identifier)
	file.close()
	
	# Сохранение токена в сессию
	session_token = json.get_data().session_token
	Global.user_name = json.get_data().player_name
	#Показ имени пользователя (сохраненного)
	#$NameLine.text = player_name
	
	# Очистка
	auth_http.queue_free()
	# Получение лидерборды
	_get_leaderboards()

#Получение всей лидерборды
func _get_leaderboards():
	print("Getting leaderboards")
	var url = "https://api.lootlocker.io/game/leaderboards/"+leaderboard_key+"/list?count=10"
	var headers = ["Content-Type: application/json", "x-session-token:"+session_token]
	
	leaderboard_http = HTTPRequest.new()
	add_http_sender(leaderboard_http, _on_leaderboard_request_completed, url, headers, HTTPClient.METHOD_GET)

#Обработка полученной лидерборды
func _on_leaderboard_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	
	print(json.get_data())
	
	# Форматирование лидерборды
	var leaderboardFormatted = ""
	for n in json.get_data().items.size():
		leaderboardFormatted += str(json.get_data().items[n].rank)+str(". ")
		leaderboardFormatted += str(json.get_data().items[n].player.name)+str(" - ")
		leaderboardFormatted += str(json.get_data().items[n].score)+str("\n")
	# Печать форматированной лидерборды
	print(leaderboardFormatted)
	
	leaderboard_http.queue_free()

#Сохранение нового счета
func _upload_score(score: int):
	var data = { 
		"score": str(score) 
		}
	var headers = ["Content-Type: application/json", "x-session-token:"+session_token]
	var url = "https://api.lootlocker.io/game/leaderboards/"+leaderboard_key+"/submit"
	submit_score_http = HTTPRequest.new()
	
	add_http_sender(submit_score_http, _on_upload_score_request_completed, url, headers, HTTPClient.METHOD_POST, data)
	
	# Печать для дебага
	print(data)

#Метод сохранения данных о новом имени пользователя
func _change_player_name(player_name):
	print("Changing player name")
	
	var data = { 
		"name": str(player_name) 
		}
	var url =  "https://api.lootlocker.io/game/player/name"
	var headers = ["Content-Type: application/json", "x-session-token:"+session_token]
	
	# Нода для установки имени 
	set_name_http = HTTPRequest.new()
	
	add_http_sender(set_name_http, _on_player_set_name_request_completed, url, headers, HTTPClient.METHOD_PATCH, data)

func _on_player_set_name_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	
	print(json.get_data())
	set_name_http.queue_free()

#Метод получения данных о пользователе по его идентификатору (имени)
func _get_player_name():
	print("Getting player name")
	var url = "https://api.lootlocker.io/game/player/name"
	var headers = ["Content-Type: application/json", "x-session-token:"+session_token]
	
	# Нода для получения пользователя
	get_name_http = HTTPRequest.new()
	
	add_http_sender(get_name_http, _on_player_get_name_request_completed, url, headers, HTTPClient.METHOD_GET)

#Обработка полученного имени
func _on_player_get_name_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	
	print(json.get_data().name)

#Обработка результата отправки рейтинга
func _on_upload_score_request_completed(result, response_code, headers, body) :
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	
	print(json.get_data())
	
	submit_score_http.queue_free()

#Обновление данных пользователей
func get_data():
	_get_player_name()

#Загрузка новых данных о пользователей
func update_data(user_name, score):
	_change_player_name(user_name)
	_upload_score(score)

