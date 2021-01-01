package arm.inputmap;

import kha.FastFloat;
import iron.system.Input;

class InputAxisComponent {
	var parent: InputMap;
	var positiveKey: String;
	var negativeKey: String;
	var scale: FastFloat;

	public function new(parent: InputMap, positiveKey: String, negativeKey: String): Void {
		this.parent = parent;
		this.positiveKey = positiveKey;
		this.negativeKey = negativeKey;
	}

	public function get(): FastFloat {
		return 0.0;
	}
}

class KeyboardAxisComponent extends InputAxisComponent {
	final keyboard: Keyboard = Input.getKeyboard();

	public function new(parent: InputMap, positiveKey: String, negativeKey: String): Void {
		super(parent, positiveKey, negativeKey);
		this.parent = parent;
		this.positiveKey = positiveKey;
		this.negativeKey = negativeKey;
	}

	public inline override function get(): FastFloat {
		scale = 0.0;
		if (keyboard.down(positiveKey)) scale++;
		if (keyboard.down(negativeKey)) scale--;
		return scale;
	}
}

class MouseAxisComponent extends InputAxisComponent {
	final mouse: Mouse = Input.getMouse();

	public function new(parent: InputMap, positiveKey: String, negativeKey: String): Void {
		super(parent, positiveKey, negativeKey);
		this.parent = parent;
		this.positiveKey = positiveKey;
		this.negativeKey = negativeKey;
	}

	public inline override function get(): FastFloat {
		scale = 0.0;
		if (mouse.down(positiveKey)) scale++;
		if (mouse.down(negativeKey)) scale--;
		return scale;
	}
}

class GamepadAxisComponent extends InputAxisComponent {
	final gamepad: Gamepad = Input.getGamepad();

	public function new(parent: InputMap, positiveKey: String, negativeKey: String): Void {
		super(parent, positiveKey, negativeKey);
		this.parent = parent;
		this.positiveKey = positiveKey;
		this.negativeKey = negativeKey;
	}

	public inline override function get(): FastFloat {
		scale = 0.0;
		if (gamepad.down(positiveKey) <= parent.pressure) scale++;
		if (gamepad.down(negativeKey) <= parent.pressure) scale--;
		return scale;
	}
}
