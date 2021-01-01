package arm.inputmap;

import kha.FastFloat;
import iron.math.Vec4;
import arm.inputmap.InputAxis;
import arm.inputmap.InputAction;

class InputMap {
	static var axes: Map<String, InputAxis>;
	static var actions: Map<String, InputAction>;

	public var index: Int;
	public var currentTag: String;
	public var pressure: FastFloat;

	public function new(index: Int, ?pressure: FastFloat): Void {
		this.index = index;
		var p = pressure == null ? 0.0 : pressure;
		this.pressure = p;
	}

	public function setCurrentTag(tag: String): Void {
		currentTag = tag;
	}

	public function createAxis(name: String): Void {
		if (axes == null) axes = new Map<String, InputAxis>();
		axes[name] = new InputAxis(this);
	}

	public function createAction(name: String): Void {
		if (actions == null) actions = new Map<String, InputAction>();
		actions[name] = new InputAction(this);
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