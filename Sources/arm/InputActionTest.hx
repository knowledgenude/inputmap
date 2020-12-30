package arm;

import arm.inputmap.InputAction;

class InputActionTest extends iron.Trait {

	var action1: InputAction;
	var action2: InputAction; // Action to remove a input

	var input1: Dynamic; // Stores an input to futher remove it

	public function new() {
		super();

		notifyOnInit(function() {
			action1 = new InputAction();
			input1 = action1.addKeyboardElement("w"); // This input is added and stored. Control + R to remove it
			action1.addMouseElement("left");
			action1.addGamepadElement("cross", ["l1", "r1"]);

			action2 = new InputAction();
			action2.addKeyboardElement("r", ["control"]);
		});

		notifyOnUpdate(function() {
			if (action1.pressed()) trace("action1");

			if (action2.pressed()) {
				action1.removeElement(input1);
			}
		});
	}
}