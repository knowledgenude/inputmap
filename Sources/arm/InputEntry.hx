package arm;

import iron.system.Input;

class InputEntry {

	public var type: String;
	public var key: String;
	public var modifiers: Array<String>;

	public function new(key: String, modifiers: Array<String>) {
		this.key = key;
		this.modifiers = modifiers;
	}

	public function testModifiers() {
		var keyboard: Keyboard = Input.getKeyboard();

		if (modifiers.length == 0) return true;

		for (m in modifiers) {
			if (!keyboard.down(m)) return false;
		}

		return true;
	}
}