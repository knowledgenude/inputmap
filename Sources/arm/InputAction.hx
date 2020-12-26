package arm;

import iron.system.Input;

class InputAction {

	var keyboard = Input.getKeyboard();
	var mouse = Input.getMouse();
	var gamepad = Input.getGamepad();

	public function new() {}

	var keyboardInputs: Array<InputEntry> = [];
	var mouseInputs: Array<InputEntry> = [];
	var gamepadInputs: Array<InputEntry> = [];

	public function addKeyboardInput(key: String, ?modifiers: Array<String>) {
		var m = modifiers == null ? new Array<String>() : modifiers;
		keyboardInputs.push(new InputEntry(key, m));
	}

	public function addMouseInput(key: String, ?modifiers: Array<String>) {
		var m = modifiers == null ? new Array<String>() : modifiers;
		mouseInputs.push(new InputEntry(key, m));
	}

	public function addGamepadInput(key: String, ?modifiers: Array<String>) {
		var m = modifiers == null ? new Array<String>() : modifiers;
		gamepadInputs.push(new InputEntry(key, m));
	}

	public function started() {
		for (input in keyboardInputs) {
			if (keyboard.started(input.key)) {
				if (input.testModifiers()) return true;
			}
		}

		for (input in mouseInputs) {
			if (mouse.started(input.key)) {
				if (input.testModifiers()) return true;
			}
		}

		for (input in gamepadInputs) {
			if (gamepad.started(input.key)) {
				if (input.testModifiers()) return true;
			}
		}

		return false;
	}

	public function released() {
		for (input in keyboardInputs) {
			if (keyboard.released(input.key)) {
				if (input.testModifiers()) return true;
			}
		}

		for (input in mouseInputs) {
			if (mouse.released(input.key)) {
				if (input.testModifiers()) return true;
			}
		}

		for (input in gamepadInputs) {
			if (gamepad.released(input.key)) {
				if (input.testModifiers()) return true;
			}
		}

		return false;
	}

}