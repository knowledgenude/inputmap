package arm.inputmap;

import kha.FastFloat;
import arm.inputmap.InputActionComponent;

class InputAction {
	static var components: Map<InputActionComponent, String>;

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

	public function addKeyboardComponent(tag: String, key: String, ?modifiers): Void {
		var mod = modifiers == null ? new Array<String>() : modifiers;
		addCustomComponent(new KeyboardActionComponent(this, key, mod), tag);
	}

	public function addMouseComponent(tag: String, button: String, ?modifiers): Void {
		var mod = modifiers == null ? new Array<String>() : modifiers;
		addCustomComponent(new MouseActionComponent(this, button, mod), tag);
	}

	public function addGamepadComponent(tag: String, button: String, ?modifiers): Void {
		var mod = modifiers == null ? new Array<String>() : modifiers;
		addCustomComponent(new GamepadActionComponent(this, button, mod), tag);
	}

	public function addCustomComponent(component: InputActionComponent, tag: String): Void {
		if (components == null) components = new Map<InputActionComponent, String>();
		components[component] = tag;
	}

	public function removeComponent(component: InputActionComponent): Void {
		components.remove(component);
	}

	public function pressed(): Bool {
		for (component => tag in components) {
			if (tag == parent.currentTag) {
				if (component.started()) return true;
			}
		}
		return false;
	}

	public function released(): Bool {
		for (component => tag in components) {
			if (tag == parent.currentTag) {
				if (component.released()) return true;
			}
		}
		return false;
	}
}