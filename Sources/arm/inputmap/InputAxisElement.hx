package arm.inputmap;

import kha.FastFloat;
import iron.system.Input;

class InputAxisElement {
	var positiveKey: String;
	var negativeKey: String;
	var scale: FastFloat;

	public function new(positiveKey: String, negativeKey: String): Void {
		this.positiveKey = positiveKey;
		this.negativeKey = negativeKey;
	}

	public function get(): FastFloat {
		return 0.0;
	}
}

class KeyboardAxisElement extends InputAxisElement {
	public function new(positiveKey: String, negativeKey: String): Void {
		super(positiveKey, negativeKey);
		this.positiveKey = positiveKey;
		this.negativeKey = negativeKey;
	}

	final keyboard: Keyboard = Input.getKeyboard();

	public inline override function get(): FastFloat {
		scale = 0.0;
		if (keyboard.down(positiveKey)) scale += 1.0;
		if (keyboard.down(negativeKey)) scale -= 1.0;
		return scale;
	}
}

class MouseAxisElement extends InputAxisElement {
	public function new(positiveKey: String, negativeKey: String): Void {
		super(positiveKey, negativeKey);
		this.positiveKey = positiveKey;
		this.negativeKey = negativeKey;
	}

	final mouse: Mouse = Input.getMouse();

	public inline override function get(): FastFloat {
		scale = 0.0;
		if (mouse.down(positiveKey)) scale += 1.0;
		if (mouse.down(negativeKey)) scale -= 1.0;
		return scale;
	}
}

class GamepadAxisElement extends InputAxisElement {
	public function new(positiveKey: String, negativeKey: String): Void {
		super(positiveKey, negativeKey);
		this.positiveKey = positiveKey;
		this.negativeKey = negativeKey;
	}

	final gamepad: Gamepad = Input.getGamepad();

	public inline override function get(): FastFloat {
		scale = 0.0;
		if (gamepad.down(positiveKey) > 0.0) scale += 1.0;
		if (gamepad.down(negativeKey) > 0.0) scale -= 1.0;
		return scale;
	}
}