extends Node

var message = ''
var index = 0

var message_queue = []

enum State {
	Active,
	Paused
}

var state = State.Active

class SignalHolder:
	# Literally just holds a signal. Fixes some pass by value errors on the
	# array.
	signal done

func _ready() -> void:
	$CenterContainer/Label.text = ''

func _process(delta: float) -> void:
	if state == State.Active:
		if (index < message.length()):
			index += 1
			$CenterContainer/Label.text = message.substr(0, index)
		elif !message_queue.is_empty():
			var next = message_queue.pop_front()
			if next is SignalHolder:
				next.done.emit()
			elif typeof(next) == TYPE_FLOAT:
				state = State.Paused
				get_tree().create_timer(next).timeout.connect(func ():
					state = State.Active)
			elif next == '$clear':
				clear_message()
			else:
				message += '\n' + next
	
func queue_messages(msgs: Array) -> Signal:
	# msgs: an array of...
	#  string: messages, put together with newlines.
	#  '$clear': special string to clear messages.
	#  float: seconds to wait before the next message
	# Returns a signal that emits upon completion of all the messages. 
	message_queue.append_array(msgs)
	var sh = SignalHolder.new()
	message_queue.push_back(sh)
	return sh.done
	
func clear_message():
	index = 0
	message = ''
	$CenterContainer/Label.text = message
