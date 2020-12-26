package arm;

import iron.system.Input;

class InputAction {
	public function new() {}

	var keyboard: Keyboard = Input.getKeyboard();
	var keyboardInputs: Array<String> = [];

	var mouse: Keyboard = Input.getKeyboard();
	var mouseInputs: Array<String> = [];

	var gamepad: Keyboard = Input.getKeyboard();
	var gamepadInputs: Array<String> = [];

	public function setInputs(inputType: String, inputs: Array<String>) {
		switch (inputType) {
			case "keyboard": keyboardInputs = inputs;
			case "mouse": mouseInputs = inputs;
			case "gamepad": gamepadInputs = inputs;
		}
	}

	public function clearInputs(inputType: String) {
		switch (inputType) {
			case "keyboard": keyboardInputs = [];
			case "mouse": mouseInputs = [];
			case "gamepad": gamepadInputs = [];
		}
	}

	public function addInput(inputType: String, input: String) {
		switch (inputType) {
			case "keyboard": keyboardInputs.push(input);
			case "mouse": mouseInputs.push(input);
			case "gamepad": gamepadInputs.push(input);
		}
	}

	public function removeInput(inputType: String, input: String) {
		switch (inputType) {
			case "keyboard": keyboardInputs.remove(input);
			case "mouse": mouseInputs.remove(input);
			case "gamepad": gamepadInputs.remove(input);
		}
	}

	public function started() {
		for (k in keyboardInputs) {
			if (keyboard.started(k)) return true;
		}

		for (m in mouseInputs) {
			if (mouse.started(m)) return true;
		}

		for (g in gamepadInputs) {
			if (gamepad.started(g)) return true;
		}

		return false;
	}

	public function released() {
		for (k in keyboardInputs) {
			if (keyboard.released(k)) return true;
		}

		for (m in mouseInputs) {
			if (mouse.released(m)) return true;
		}

		for (g in gamepadInputs) {
			if (gamepad.released(g)) return true;
		}

		return false;
	}
}