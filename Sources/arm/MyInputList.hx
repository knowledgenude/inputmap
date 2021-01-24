package arm;

import kha.FastFloat;
import libraries.InputMap;

class MyInputList {
	var traceSomething1 = new ActionMap(); // Press 'space' or 'enter'
	var traceSomething2 = new ActionMap(); // Hold 'CTRL' and press 'ALT'
	var traceWithMouse = new ActionMap(); // Press 'left' mouse button
	var moveForward = new AxisMap(); // 'W' and 'S'

	var kMoveForward: InputCommand; // This var is declared here to allow us to set its scale trought a function

	public function new() {
		var kTraceSomething1 = traceSomething1.addKeyboard("PC");
		kTraceSomething1.setKeys(["space", "enter"]);

		var kTraceSomething2 = traceSomething2.addKeyboard("PC");
		kTraceSomething2.setKeys(["alt"]);
		kTraceSomething2.setMods(["control"]);

		var kTraceWithMouse = traceWithMouse.addKeyboard("PC");
		kTraceWithMouse.setDisplacementKeys(["left"]); // Displacement keys here are the mouse. It can be handled together with the keyboard keys
		// ex kTraceWithMouse.setDisplacementMods() to add a mouse modifier or setMods() to add keyboard modifiers

		kMoveForward = moveForward.addKeyboard("PC");
		kMoveForward.setKeys(["w"]);
		kMoveForward.setMods(["s"]); // The modifiers for axis map are the negative keys
	}

	public function getTraceSomething1() {
		return traceSomething1.started("PC");
	}

	public function getTraceSomething2() {
		return traceSomething2.started("PC");
	}

	public function getTraceWithMouse() {
		return traceWithMouse.started("PC");
	}

	public function getMoveForward() {
		return moveForward.getAxis("PC");
	}

	public function getMoveForwardScale() {
		return moveForward.getScale(); // Get the current scale of this input axis. By default it is set to 1.0
		// This scale needs to be multiplied later to avoid further normalization issues
		// In the class you would use: getMoveForward() * getMoveForwardScale(). See in the main script :)
	}

	public function setMoveForwardScale(moveForwardScale: FastFloat) { // Allows to further set the speed of the movement
		return kMoveForward.setScale(moveForwardScale);
	}
}
