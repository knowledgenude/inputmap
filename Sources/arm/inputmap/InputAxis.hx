package arm.inputmap;

import kha.FastFloat;
import iron.math.Vec4;
import arm.inputmap.InputAxisComponent;

class InputAxis {
	static var componentsX = new Map<InputAxisComponent, String>();
	static var scaleX: FastFloat = 1.0;

	static var componentsY = new Map<InputAxisComponent, String>();
	static var scaleY: FastFloat = 1.0;

	static var normalize: Bool = false;
	static var vec: Vec4 = new Vec4();

	final parent: InputMap;
	public final index: Int;
	public final deadzone: FastFloat;
	public final pressure: FastFloat;

	public function new(parent: InputMap, index: Int, pressure: FastFloat, deadzone: FastFloat) {
		this.parent = parent;
		this.index = index;
		this.pressure = pressure;
		this.deadzone = deadzone;
	}

	public function addKeyboardComponent(position: String, tag: String, positiveKey: String, ?negativeKey: String): Void {
		var n = negativeKey == null ? "" : negativeKey;
		addCustomComponent(position, new KeyboardAxisComponent(this, positiveKey, negativeKey), tag);
	}

	public function addMouseComponent(position: String, tag: String, positiveButton: String, ?negativeButton: String): Void {
		var n = negativeButton == null ? "" : negativeButton;
		addCustomComponent(position, new MouseAxisComponent(this, positiveButton, negativeButton), tag);
	}

	public function addGamepadComponent(position: String, tag: String, positiveButton: String, ?negativeButton: String): Void {
		var n = negativeButton == null ? "" : negativeButton;
		addCustomComponent(position, new GamepadAxisComponent(this, positiveButton, negativeButton), tag);
	}

	public function addCustomComponent(position: String, component: InputAxisComponent, tag: String): Void {
		switch (position) {
			case "x": componentsX[component] = tag;
			case "y": componentsY[component] = tag;
		}
	}

	public function removeComponent(position: String, component: InputAxisComponent): Void {
		switch (position) {
			case "x": componentsX.remove(component);
			case "y": componentsY.remove(component);
		}
	}

	public function setScale(x: FastFloat, y: FastFloat): Void {
		scaleX = x;
		scaleY = y;
	}

	public function enableNormalize(): Void {
		normalize = true;
	}

	public function disableNormalize(): Void {
		normalize = false;
	}

	public inline function get(): Vec4 {
		vec.set(0, 0, 0);

		for (component => tag in componentsX) {
			if (tag == parent.currentTag) if (component.get() != 0.0) vec.x += component.get();
		}

		for (component => tag in componentsY) {
			if (tag == parent.currentTag) if (component.get() != 0.0) vec.y += component.get();
		}

		if (normalize) vec.normalize();

		vec.x *= scaleX;
		vec.y *= scaleY;

		return vec;
	}
}
