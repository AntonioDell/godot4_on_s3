extends Node


var _image_names := []


func _ready():
	# Check if DataRepository is ready
	if DataRepository.is_data_info_loaded:
		_init_sprite()
	else:
		# If not, connect a signal to call '_init_sprite' as soon as the DataRepository is ready
		DataRepository.connect("data_info_loaded",Callable(self,"_init_sprite"))


func _init_sprite():
	_image_names = DataRepository.get_image_names()
	await _randomize_sprite()


func _on_randomize_image_btn_pressed():
	_randomize_sprite()


func _randomize_sprite():
	_image_names.shuffle()
	var image_to_load = _image_names[0]
	var image = await DataRepository.get_image(image_to_load) as Image
	image.resize(256, 256)
	var image_texture := ImageTexture.create_from_image(image)
	$ImageFromBucket.texture = image_texture
