package arm;

import iron.system.Input;

class InputEntry {

	var keyboard: Keyboard = Input.getKeyboard();
	var mouse: Mouse = Input.getMouse();
	var gamepad: Gamepad = Input.getGamepad();

	public var type: String;
	public var key: String;
	public var modifiers: Array<String>;

	public function new(type: String, key: String, modifiers: Array<String>) {
		this.type = type;
		this.key = key;
		this.modifiers = modifiers;
	}

	public function getModifier() {
		switch(type) {
			case "keyboard": {
				if (modifiers.length == 0) return true;

				for (m in modifiers) {
					if (!keyboard.down(m)) return false;
				}
			}
			case "mouse": {
				if (modifiers.length == 0) return true;

				for (m in modifiers) {
					if (!mouse.down(m)) return false;
				}
			}
			/*
			case "gamepad": {
				if (modifiers.length == 0) return true;

				for (m in modifiers) {
					if (!gamepad.down(m)) return false;
				}
			}
			*/
		}

		return true;
	}
}