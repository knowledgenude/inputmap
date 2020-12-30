package arm.inputmap;

import iron.system.Input;

class InputActionElement {
	public var key: String;
	var modifiers: Array<String>;

	public function new(key: String, modifiers: Array<String>): Void {
		this.key = key;
		this.modifiers = modifiers;
	}

	public function pressed(): Bool {
		return false;
	}

	public function released(): Bool {
		return false;
	}
}

class KeyboardActionElement extends InputActionElement {
	public function new(key: String, modifiers: Array<String>): Void {
		super(key, modifiers);
		this.key = key;
		this.modifiers = modifiers;
	}

	var keyboard: Keyboard = Input.getKeyboard();

	public override function pressed(): Bool {
		if (keyboard.started(key)) {
			if (modifiers.length > 0) {
				for (m in modifiers) {
					if (!keyboard.down(m)) return false;
				}
			}
			return true;
		}
		return false;
	}

	public override function released(): Bool {
		if (keyboard.released(key)) {
			if (modifiers.length > 0) {
				for (m in modifiers) {
					if (!keyboard.down(m)) return false;
				}
			}
			return true;
		}
		return false;
	}
}

class MouseActionElement extends InputActionElement {
	public function new(key: String, modifiers: Array<String>): Void {
		super(key, modifiers);
		this.key = key;
		this.modifiers = modifiers;
	}

	var mouse: Mouse = Input.getMouse();

	public override function pressed(): Bool {
		if (mouse.started(key)) {
			if (modifiers.length > 0) {
				for (m in modifiers) {
					if (!mouse.down(m)) return false;
				}
			}
			return true;
		}
		return false;
	}

	public override function released(): Bool {
		if (mouse.released(key)) {
			if (modifiers.length > 0) {
				for (m in modifiers) {
					if (!mouse.down(m)) return false;
				}
			}
			return true;
		}
		return false;
	}
}

class GamepadActionElement extends InputActionElement {
	public function new(key: String, modifiers: Array<String>): Void {
		super(key, modifiers);
		this.key = key;
		this.modifiers = modifiers;
	}

	var gamepad: Gamepad = Input.getGamepad();

	public override function pressed(): Bool {
		if (gamepad.started(key)) {
			if (modifiers.length > 0) {
				for (m in modifiers) {
					if (gamepad.down(m) <= 0.0) return false;
				}
			}
			return true;
		}
		return false;
	}

	public override function released(): Bool {
		if (gamepad.released(key)) {
			if (modifiers.length > 0) {
				for (m in modifiers) {
					if (gamepad.down(m) <= 0.0) return false;
				}
			}
			return true;
		}
		return false;
	}
}