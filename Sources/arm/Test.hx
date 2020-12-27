package arm;

import iron.system.Input;
import arm.inputmap.InputAction;

class Test extends iron.Trait {

	var keyboard = Input.getKeyboard();
	var mouse = Input.getMouse();

	var action1: InputAction;

	public function new() {
		super();

		notifyOnInit(function() {
			action1 = new InputAction();

			action1.addInput(keyboard, "w");
			action1.addInput(keyboard, "up", ["alt"]);
			action1.addInput(mouse, "left");
		});

		notifyOnUpdate(function() {
			if (action1.pressed()) trace("action1");
		});
	}
}