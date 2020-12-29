package arm;

import arm.inputmap.InputAction;
import arm.inputmap.GamepadConfig; // custom input example

class Test extends iron.Trait {

	var action1: InputAction;
	var action2: InputAction;

	public function new() {
		super();

		notifyOnInit(function() {
			action1 = new InputAction();
			action1.addKeyboardInput("w");
			action1.addMouseInput("left");

			action2 = new InputAction();
			action2.addKeyboardInput("r", ["control"]);

			action1.addCustomInput(new GamepadConfig("cross", ["l1", "r1"])); // add the custom input
		});

		notifyOnUpdate(function() {
			if (action1.pressed()) trace("action1");

			if (action2.pressed()) {
				action1.removeInput(action1.getInputByKey("w"));
			}
		});
	}
}