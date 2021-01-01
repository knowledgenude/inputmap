package arm.inputmap;

import arm.inputmap.InputActionComponent;

class InputAction {
	static var components: Map<InputActionComponent, String>;

	var parent: InputMap;

	public function new(parent: InputMap): Void {
		this.parent = parent;
	}

	public function addKeyboardComponent(tag: String, key: String, ?modifiers): Void {
		var mod = modifiers == null ? new Array<String>() : modifiers;
		addCustomComponent(new KeyboardActionComponent(parent, key, mod), tag);
	}

	public function addMouseComponent(tag: String, button: String, ?modifiers): Void {
		var mod = modifiers == null ? new Array<String>() : modifiers;
		addCustomComponent(new MouseActionComponent(parent, button, mod), tag);
	}

	public function addGamepadComponent(tag: String, button: String, ?modifiers): Void {
		var mod = modifiers == null ? new Array<String>() : modifiers;
		addCustomComponent(new GamepadActionComponent(parent, button, mod), tag);
	}

	public function addCustomComponent(component: InputActionComponent, tag: String): Void {
		if (parent.currentTag == null) parent.currentTag = tag;
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