package arm.inputmap;

import kha.FastFloat;
import iron.system.Input;

class InputAxisComponent {
	var parent: InputAxis;
	var positiveKey: String;
	var negativeKey: String;
	var scale: FastFloat;

	public function new(parent: InputAxis, positiveKey: String, negativeKey: String): Void {
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

	public function new(parent: InputAxis, positiveKey: String, negativeKey: String): Void {
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

	public function new(parent: InputAxis, positiveKey: String, negativeKey: String): Void {
		super(parent, positiveKey, negativeKey);
		this.parent = parent;
		this.positiveKey = positiveKey;
		this.negativeKey = negativeKey;
	}

	public inline override function get(): FastFloat {
		scale = 0.0;
		var movX: FastFloat = mouse.movementX;
		var movY: FastFloat = mouse.movementY;

		switch (positiveKey) {
			case "moved x": if (movX > parent.deadzone) scale++;
			case "moved y":	if (movY > parent.deadzone) scale++;
			case "mouse movement x": if (movX > parent.deadzone) return movX - parent.deadzone;
			case "mouse movement y": if (movY > parent.deadzone) return movY - parent.deadzone;
			default: if (mouse.down(positiveKey)) scale++;
		}
		switch (negativeKey) {
			case "moved x": if (movX < -parent.deadzone) scale--;
			case "moved y": if (movY < -parent.deadzone) scale--;
			default: if (mouse.down(negativeKey)) scale--;
		}
		return scale;
	}
}

class GamepadAxisComponent extends InputAxisComponent {
	final gamepad: Gamepad;

	public function new(parent: InputAxis, positiveKey: String, negativeKey: String): Void {
		super(parent, positiveKey, negativeKey);
		this.parent = parent;
		this.positiveKey = positiveKey;
		this.negativeKey = negativeKey;
		gamepad = Input.getGamepad(parent.index);
	}

	public inline override function get(): FastFloat {
		scale = 0.0;
		var rightMovX = gamepad.rightStick.movementX;
		var rightMovY = gamepad.rightStick.movementY;
		var leftMovX = gamepad.leftStick.movementX;
		var leftMovY = gamepad.leftStick.movementY;

		// Avoid division by zero
		var rightTrigger = gamepad.down("r2") > 0.0 ? (gamepad.down("r2") - parent.pressure) / (1 - parent.pressure): 0.0;
		var leftTrigger = gamepad.down("l2") > 0.0 ? (gamepad.down("r2") - parent.pressure) / (1 - parent.pressure): 0.0;

		switch (positiveKey) {
			case "right stick moved x": if (rightMovX > parent.deadzone) scale++;
			case "right stick moved y": if (rightMovY > parent.deadzone) scale++;
			case "right stick movement x": if (rightMovX > parent.deadzone) return rightMovX - parent.deadzone;
			case "right stick movement y": if (rightMovY > parent.deadzone) return rightMovY - parent.deadzone;
			case "left stick moved x": if (leftMovX > parent.deadzone) scale++;
			case "left stick moved y": if (leftMovY > parent.deadzone) scale++;
			case "left stick movement x": if (leftMovX > parent.deadzone) return leftMovX - parent.deadzone;
			case "left stick movement y": if (leftMovY > parent.deadzone) return leftMovY - parent.deadzone;
			case "right trigger": return rightTrigger;
			case "left trigger": return leftTrigger;
			default: if (gamepad.down(positiveKey) > parent.pressure) scale++;
		}

		switch (positiveKey) {
			case "right stick moved x": if (rightMovX < -parent.deadzone) scale--;
			case "right stick moved y": if (rightMovY < -parent.deadzone) scale--;
			case "left stick moved x": if (leftMovX < -parent.deadzone) scale--;
			case "left stick moved y": if (leftMovY < -parent.deadzone) scale--;
			default: if (gamepad.down(positiveKey) < -parent.pressure) scale--;
		}

		return scale;
	}
}
