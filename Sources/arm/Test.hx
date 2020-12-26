package arm;

class Test extends iron.Trait {

	var action1: InputModifier;
	var action2: InputAction;

	public function new() {
		super();

		notifyOnInit(function() {
			action1 = new InputModifier();
			action1.setInputs("keyboard", ["w", "up"]); // this action needs the modifier key down
			action1.setModifiers("keyboard", ["alt"]); // the modifier key does not have effect alone

			action2 = new InputAction();
			action2.setInputs("keyboard", ["s", "down"]); // this action does not need any modifier key
		});

		notifyOnUpdate(function() {
			if (action1.started()) trace("action1"); // press "w" or "up" while holding "alt"

			if (action2.started()) trace("action2"); // press "s" or "down"
		});
	}
}
