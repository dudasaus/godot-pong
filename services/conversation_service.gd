extends Node

var message = ''
var index = 0

var message_queue = []

enum State {
	Active,
	Paused
}

var state = State.Active

func _ready() -> void:
	$CenterContainer/Label.text = ''

func _process(delta: float) -> void:
	if state == State.Active:
		if (index < message.length()):
			index += 1
			$CenterContainer/Label.text = message.substr(0, index)
		elif !message_queue.is_empty():
			var next = message_queue.pop_front()
			if typeof(next) == TYPE_FLOAT:
				state = State.Paused
				get_tree().create_timer(next).timeout.connect(func ():
					state = State.Active)
			elif next == '$clear':
				clear_message()
			else:
				message += '\n' + next
		
func set_message(msg: String):
	queue_message(msg)
	
func queue_message(msg):
	message_queue.push_back(msg)
	
func queue_messages(msgs):
	message_queue.append_array(msgs)
	
func clear_message():
	index = 0
	message = ''
	$CenterContainer/Label.text = message
