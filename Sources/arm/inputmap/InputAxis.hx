package arm.inputmap;

import kha.FastFloat;
import iron.math.Vec4;
import arm.inputmap.InputAxisComponent;

class InputAxis {
	static var scaleX: FastFloat = 1.0;
	static var normalizeX: Bool = false;
	static var componentsX: Map<InputAxisComponent, String>;

	static var scaleY: FastFloat = 1.0;
	static var normalizeY: Bool = false;
	static var componentsY: Map<InputAxisComponent, String>;

	static var scaleZ: FastFloat = 1.0;
	static var normalizeZ: Bool = false;
	static var componentsZ: Map<InputAxisComponent, String>;

	static var vec: Vec4 = new Vec4();
	static var updatedVec: Vec4 = new Vec4();

	var parent: InputMap;

	public function new(parent: InputMap) {
		this.parent = parent;
	}

	public function addKeyboardComponent(position: String, tag: String, positiveKey: String, ?negativeKey: String): Void {
		var n = negativeKey == null ? "" : negativeKey;
		addCustomComponent(position, new KeyboardAxisComponent(parent, positiveKey, negativeKey), tag);
	}

	public function addMouseComponent(position: String, tag: String, positiveButton: String, ?negativeButton: String): Void {
		var n = negativeButton == null ? "" : negativeButton;
		addCustomComponent(position, new MouseAxisComponent(parent, positiveButton, negativeButton), tag);
	}

	public function addGamepadComponent(position: String, tag: String, positiveButton: String, ?negativeButton: String): Void {
		var n = negativeButton == null ? "" : negativeButton;
		addCustomComponent(position, new GamepadAxisComponent(parent, positiveButton, negativeButton), tag);
	}

	public function addCustomComponent(position: String, component: InputAxisComponent, tag: String): Void {
		if (parent.currentTag == null) parent.currentTag = tag;

		if (componentsX == null) componentsX = new Map<InputAxisComponent, String>();
		if (componentsY == null) componentsY = new Map<InputAxisComponent, String>();
		if (componentsZ == null) componentsZ = new Map<InputAxisComponent, String>();

		switch (position) {
			case "x": {
					componentsX[component] = tag;
			}
			case "y": {

					componentsY[component] = tag;
			}
			case "z": {
					componentsZ[component] = tag;
			}
		}
	}

	public function removeComponent(position: String, component: InputAxisComponent): Void {
		switch (position) {
			case "x": {
					componentsX.remove(component);
			}
			case "y": {

					componentsY.remove(component);
			}
			case "z": {
					componentsZ.remove(component);
			}
		}
	}

	public function setScale(x: FastFloat, y: FastFloat, z: FastFloat): Void {
		scaleX = x;
		scaleY = y;
		scaleZ = z;
	}

	public function setNormalize(x: Bool, y: Bool, z: Bool): Void {
		normalizeX = x;
		normalizeY = y;
		normalizeZ = z;
	}

	public inline function get(): Vec4 {
		update();
		updatedVec.set(vec.x, vec.y, vec.z);
		vec.normalize();

		updatedVec.x = normalizeX == false ? updatedVec.x * scaleX : vec.x * scaleX;
		updatedVec.y = normalizeY == false ? updatedVec.y * scaleY : vec.y * scaleY;
		updatedVec.z = normalizeZ == false ? updatedVec.z * scaleZ : vec.z * scaleZ;

		return updatedVec;
	}

	function update(): Void {
		vec.set(0, 0, 0);

		for (component => tag in componentsX) {
			if (tag == parent.currentTag) vec.x = component.get();
		}

		for (component => tag in componentsY) {
			if (tag == parent.currentTag) vec.y = component.get();
		}

		for (component => tag in componentsZ) {
			if (tag == parent.currentTag) vec.z = component.get();
		}
	}
}
