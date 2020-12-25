package arm;

import iron.system.Input;

class InputAction {

	public function new() {}

	var inputType: String;

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

	public function started(): Bool {
	// Keyboard
		for (keyboardInput in keyboardInputs) {
			if (keyboard.started(keyboardInput)) return true;
		}

	// Mouse
		for (mouseInput in mouseInputs) {
			if (mouse.started(mouseInput)) return true;
		}

	// Gamepad
		for (gamepadInput in gamepadInputs) {
			if (gamepad.started(gamepadInput)) return true;
		}
		return false;
	}

	public function down(): Bool {
	// Keyboard
		for (keyboardInput in keyboardInputs) {
			if (keyboard.down(keyboardInput)) return true;
		}

	// Mouse
		for (mouseInput in mouseInputs) {
			if (mouse.down(mouseInput)) return true;
		}

	// Gamepad
		for (gamepadInput in gamepadInputs) {
			if (gamepad.down(gamepadInput)) return true;
		}
		return false;
	}

	public function released(): Bool {
	// Keyboard
		for (keyboardInput in keyboardInputs) {
			if (keyboard.released(keyboardInput)) return true;
		}

	// Mouse
		for (mouseInput in mouseInputs) {
			if (mouse.released(mouseInput)) return true;
		}

	// Gamepad
		for (gamepadInput in gamepadInputs) {
			if (gamepad.released(gamepadInput)) return true;
		}
		return false;
	}
}