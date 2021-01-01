package arm.inputmap;

import iron.system.Input;

class InputActionComponent {
	var parent: InputMap;
	var key: String;
	var modifiers: Array<String>;

	public function new(parent: InputMap, key: String, modifiers: Array<String>): Void {
		this.key = key;
		this.modifiers = modifiers;
		this.parent = parent;
	}

	public function started(): Bool {
		return false;
	}

	public function released(): Bool {
		return false;
	}
}

class KeyboardActionComponent extends InputActionComponent {

	final keyboard: Keyboard = Input.getKeyboard();

	public function new(parent: InputMap, key: String, modifiers: Array<String>): Void {
		super(parent, key, modifiers);
		this.parent = parent;
		this.key = key;
		this.modifiers = modifiers;
	}

	public inline override function started(): Bool {
		if (keyboard.started(key)) {
			for (m in modifiers) {
				if (!keyboard.down(m)) return false;
			}
			return true;
		}
		return false;
	}

	public inline override function released(): Bool {
		if (keyboard.released(key)) {
			for (m in modifiers) {
				if (!keyboard.down(m)) return false;
			}
			return true;
		}
		return false;
	}
}

class MouseActionComponent extends InputActionComponent {

	final mouse: Mouse = Input.getMouse();

	public function new(parent: InputMap, key: String, modifiers: Array<String>): Void {
		super(parent, key, modifiers);
		this.parent = parent;
		this.key = key;
		this.modifiers = modifiers;
	}

	public override function started(): Bool {
		if (mouse.started(key)) {
			for (m in modifiers) {
				if (!mouse.down(m)) return false;
			}
			return true;
		}
		return false;
	}

	public override function released(): Bool {
		if (mouse.released(key)) {
			for (m in modifiers) {
				if (!mouse.down(m)) return false;
			}
			return true;
		}
		return false;
	}
}

class GamepadActionComponent extends InputActionComponent {

	final gamepad: Gamepad;

	public function new(parent: InputMap, key: String, modifiers: Array<String>) {
		super(parent, key, modifiers);
		this.parent = parent;
		this.key = key;
		this.modifiers = modifiers;
		gamepad = Input.getGamepad(parent.index);
	}

	public inline override function started(): Bool {
		if (gamepad.started(key)) {
			for (m in modifiers) {
				if (gamepad.down(m) <= parent.pressure) return false;
			}
			return true;
		}
		return false;
	}

	public inline override function released(): Bool {
		if (gamepad.released(key)) {
			for (m in modifiers) {
				if (gamepad.down(m) <= parent.pressure) return false;
			}
			return true;
		}
		return false;
	}
}