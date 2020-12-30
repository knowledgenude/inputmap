package arm.inputmap;

import arm.inputmap.InputConfig;

class InputAction {

	public function new(): Void {}

	var map: Array<InputConfig> = [];

	public function addKeyboardInput(key: String, ?modifiers: Array<String>): InputConfig {
		var mod = modifiers == null ? new Array<String>() : modifiers;
		return addCustomInput(new KeyboardConfig(key, mod));
	}

	public function addMouseInput(button: String, ?modifiers: Array<String>): InputConfig {
		var mod = modifiers == null ? new Array<String>() : modifiers;
		return addCustomInput(new MouseConfig(button, mod));
	}

	public function addGamepadInput(button: String, ?modifiers: Array<String>): InputConfig {
		var mod = modifiers == null ? new Array<String>() : modifiers;
		return addCustomInput(new GamepadConfig(button, mod));
	}

	public function addCustomInput(input: InputConfig): InputConfig {
		map.push(input);
		return input;
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
