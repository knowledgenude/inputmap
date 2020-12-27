package arm.inputmap;

class InputActionEntry {

	var input: Dynamic;
	var key: String;
	var modifiers: Array<String>;

	public function new(input: Dynamic, key: String, modifiers: Array<String>) {
		this.input = input;
		this.key = key;
		this.modifiers = modifiers;
	}

	public function pressed() {
		if (input.started(key)) {
			if (modifiers.length > 0) {
				for (m in modifiers) {
					if (!input.down(m)) return false;
				}
			}

			return true;
		}

		return false;
	}

	public function released() {
		if (input.released(key)) {
			if (modifiers.length > 0) {
				for (m in modifiers) {
					if (!input.down(m)) return false;
				}
			}

			return true;
		}

		return false;
	}
}
