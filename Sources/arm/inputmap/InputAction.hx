package arm.inputmap;

import arm.inputmap.InputActionElement;

class InputAction {
	public function new(): Void {}

	var elements: Array<InputActionElement> = [];

	public function addKeyboardElement(key: String, ?modifiers: Array<String>): InputActionElement {
		var mod = modifiers == null ? new Array<String>() : modifiers;
		return addCustomElement(new KeyboardActionElement(key, mod));
	}

	public function addMouseElement(button: String, ?modifiers: Array<String>): InputActionElement {
		var mod = modifiers == null ? new Array<String>() : modifiers;
		return addCustomElement(new MouseActionElement(button, mod));
	}

	public function addGamepadElement(button: String, ?modifiers: Array<String>): InputActionElement {
		var mod = modifiers == null ? new Array<String>() : modifiers;
		return addCustomElement(new GamepadActionElement(button, mod));
	}

	public function addCustomElement(element: InputActionElement): InputActionElement {
		elements.push(element);
		return element;
	}

	public function removeElement(element: InputActionElement): Void {
		elements.remove(element);
	}

	public function getElement(key: String): InputActionElement {
		for (e in elements) {
			if (e.key == key) return e;
		}

		return null;
	}

	public function pressed(): Bool {
		for (e in elements) {
			if (e.pressed()) return true;
		}

		return false;
	}

	public function released(): Bool {
		for (e in elements) {
			if (e.released()) return true;
		}

		return false;
	}
}
