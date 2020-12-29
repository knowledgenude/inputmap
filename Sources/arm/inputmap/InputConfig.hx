package arm.inputmap;

import iron.system.Input;

class InputConfig {

	public var key: String;
	var modifiers: Array<String>;

	public function new(key: String, modifiers: Array<String>) {
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

class KeyboardConfig extends InputConfig {

	public function new(key: String, modifiers: Array<String>) {
		super(key, modifiers);
		this.key = key;
		this.modifiers = modifiers;
	}

	var keyboard: Keyboard = Input.getKeyboard();

	public override function pressed() {
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

	public override function released() {
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

class MouseConfig extends InputConfig {

	public function new(key: String, modifiers: Array<String>) {
		super(key, modifiers);
		this.key = key;
		this.modifiers = modifiers;
	}

	var mouse: Mouse = Input.getMouse();

	public override function pressed() {
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

	public override function released() {
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