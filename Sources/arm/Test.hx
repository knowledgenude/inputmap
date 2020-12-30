package arm;

import arm.inputmap.InputAction;

class Test extends iron.Trait {

	var action1: InputAction;
	var action2: InputAction; // Action to remove a input

	var input1: Dynamic; // Stores an input to futher remove it

	public function new() {
		super();

		notifyOnInit(function() {
			action1 = new InputAction();
			input1 = action1.addKeyboardInput("w"); // This input is added and stored. Control + R to remove it
			action1.addMouseInput("left");
			action1.addGamepadInput("cross", ["l1", "r1"]);

			action2 = new InputAction();
			action2.addKeyboardInput("r", ["control"]);
		});

		notifyOnUpdate(function() {
			if (action1.pressed()) trace("action1");

			if (action2.pressed()) {
				action1.removeInput(input1);
			}
		});
	}
}