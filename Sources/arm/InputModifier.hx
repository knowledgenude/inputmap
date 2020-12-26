package arm;

import iron.system.Input;

class InputModifier extends InputAction {

	var keyboardModifiers: Array<String> = [];
	var mouseModifiers: Array<String> = [];
	var gamepadModifiers: Array<String> = [];

	public function new() {
		super(); 
	}

	public function setModifiers(inputType: String, modifiers: Array<String>) {
		switch(inputType) {
			case "keyboard": keyboardModifiers = modifiers;
			case "mouse": mouseModifiers = modifiers;
			case "gamepadModifier": gamepadModifiers = modifiers;
		}
	}

	public function clearModifiers(inputType: String) {
		switch(inputType) {
			case "keyboard": keyboardModifiers = [];
			case "mouse": mouseModifiers = [];
			case "gamepadModifier": gamepadModifiers = [];
		}
	}

	public function addModifier(inputType: String, modifier: String) {
		switch (inputType) {
			case "keyboard": keyboardModifiers.push(modifier);
			case "mouse": mouseModifiers.push(modifier);
			case "gamepad": gamepadModifiers.push(modifier);
		}
	}

	public function removeModifier(inputType: String, modifier: String) {
		switch (inputType) {
			case "keyboard": keyboardModifiers.remove(modifier);
			case "mouse": mouseModifiers.remove(modifier);
			case "gamepad": gamepadModifiers.remove(modifier);
		}
	}

	public override function started() {
		if (super.started()) {
			for (k in keyboardModifiers) {
				if (keyboard.down(k)) return true;
			}
		
			for (m in mouseModifiers) {
				if (mouse.down(m)) return true;
			}

			for (g in gamepadModifiers) {
				if (gamepad.down(g)) return true;
			}
		}

		return false;
	}

	public override function released() {
		if (super.released()) {
			for (k in keyboardModifiers) {
				if (keyboard.down(k)) return true;
			}
		
			for (m in mouseModifiers) {
				if (mouse.down(m)) return true;
			}

			for (g in gamepadModifiers) {
				if (gamepad.down(g)) return true;
			}
		}

		return false;
	}

}