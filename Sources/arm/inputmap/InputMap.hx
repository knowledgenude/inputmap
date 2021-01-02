package arm.inputmap;

import kha.FastFloat;
import iron.math.Vec4;
import arm.inputmap.InputAxis;
import arm.inputmap.InputAction;

class InputMap {
	static var axes = new Map<String, InputAxis>();
	static var actions = new Map<String, InputAction>();

	public var index: Int;
	public var currentTag: String;

	public function new(index: Int): Void {
		this.index = index;
	}

	public function setCurrentTag(tag: String): Void {
		currentTag = tag;
	}

	public function createAxis(name: String, ?pressure: FastFloat, ?deadzone: FastFloat): Void {
		var p = pressure == null ? 0.0 : pressure;
		var d = deadzone == null ? 0.0 : deadzone;
		axes[name] = new InputAxis(this, index, p, d);
	}

	public function createAction(name: String, ?pressure: FastFloat, ?deadzone: FastFloat): Void {
		var p = pressure == null ? 0.0 : pressure;
		var d = deadzone == null ? 0.0 : deadzone;
		actions[name] = new InputAction(this, index, p, d);
	}

	public inline function getAxis(name: String): InputAxis {
		return axes[name];
	}

	public inline function getAction(name: String): InputAction {
		return actions[name];
	}

	public inline function getVec(name: String): Vec4 {
		return axes[name].get();
	}

	public inline function isActionPressed(name: String): Bool {
		return actions[name].pressed();
	}

	public inline function isActionReleased(name: String): Bool {
		return actions[name].released();
	}
}