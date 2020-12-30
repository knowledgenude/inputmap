package arm.inputmap;

import kha.FastFloat;
import iron.math.Vec4;
import arm.inputmap.InputAxisElement;

class InputAxis {
	public function new(): Void {}

	var elementsX: Array<InputAxisElement> = [];
	var normalizeX: Bool = false;
	var scaleX: FastFloat = 1.0;

	var elementsY: Array<InputAxisElement> = [];
	var normalizeY: Bool = false;
	var scaleY: FastFloat = 1.0;

	var elementsZ: Array<InputAxisElement> = [];
	var normalizeZ: Bool = false;
	var scaleZ: FastFloat = 1.0;

	var vec: Vec4 = new Vec4();

	public function addKeyboardElement(position: String, positiveKey: String, ?negativeKey: String): InputAxisElement {
		var n = negativeKey == null ? "" : negativeKey;
		
		return addCustomElement(position, new KeyboardAxisElement(positiveKey, n));
	}

	public function addCustomElement(position: String, element: InputAxisElement): InputAxisElement {
		switch (position) {
			case "x": elementsX.push(element);
			case "y": elementsY.push(element);
			case "z": elementsZ.push(element);
		}
		return element;
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

	public function get(): Vec4 {
		update();
		var updatedVec: Vec4 = new Vec4(vec.x, vec.y, vec.z);
		vec.normalize();

		updatedVec.x = normalizeX == false ? updatedVec.x * scaleX : vec.x * scaleX;
		updatedVec.y = normalizeY == false ? updatedVec.y * scaleY : vec.y * scaleY;
		updatedVec.z = normalizeZ == false ? updatedVec.z * scaleZ : vec.z * scaleZ;

		return updatedVec;
	}

	public function update(): Void {
		vec.set(0, 0, 0);

		for (e in elementsX) {
			if (e.get() != 0.0) vec.x = e.get();
		}

		for (e in elementsY) {
			if (e.get() != 0.0) vec.y = e.get();
		}

		for (e in elementsZ) {
			if (e.get() != 0.0) vec.z = e.get();
		}
	}
}
