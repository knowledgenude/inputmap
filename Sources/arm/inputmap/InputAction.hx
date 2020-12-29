package arm.inputmap;

import arm.inputmap.InputConfig;

class InputAction {

	public function new(): Void {}

	var map: Array<InputConfig> = [];

	public function addMouseInput(button: String, ?modifiers: Array<String>): Void {
		var mod = modifiers == null ? new Array<String>() : modifiers;
		var input: InputConfig = new MouseConfig(button, mod);
		map.push(input);
	}

	public function addKeyboardInput(key: String, ?modifiers: Array<String>): Void {
		var mod = modifiers == null ? new Array<String>() : modifiers;
		var input: InputConfig = new KeyboardConfig(key, mod);
		map.push(input);
	}

	public function addCustomInput(input: InputConfig): Void {
		map.push(input);
	}

	public function removeInput(input: InputConfig): Void {
		map.remove(input);
	}

	public function getInputByKey(key: String): InputConfig {
		for (input in map) {
			if (input.key == key) return input;
		}

		return null;
	}

	public function pressed(): Bool {
		for (input in map) {
			if (input.pressed()) return true;
		}

		return false;
	}

	public function released(): Bool {
		for (input in map) {
			if (input.released()) return true;
		}

		return false;
	}
}
