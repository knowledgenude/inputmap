package arm.inputmap;

class InputAction {

	public function new() {}

	var inputs: Array<Dynamic> = [];

	public function addInput(input: Dynamic, key: String, ?modifiers: Array<String>) {
		var mod = modifiers == null ? new Array<String>() : modifiers;
		var input = new InputActionEntry(input, key, mod);
		inputs.push(input);
	}

	public function pressed() {
		for (i in inputs) {
			if (i.pressed()) return true;
		}

		return false;
	}

	public function released() {
		for (i in inputs) {
			if (i.released()) return true;
		}

		return false;
	}
}
