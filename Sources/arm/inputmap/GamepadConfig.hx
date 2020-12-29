package arm.inputmap;

import iron.system.Input;

class GamepadConfig extends InputConfig {

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