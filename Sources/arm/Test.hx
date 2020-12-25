package arm;

class Test extends iron.Trait {

	var action: InputAction;

	public function new() {
		super();

		notifyOnInit(function() {
			action = new InputAction();
			action.setInputs("keyboard", ["w", "up"]);
		});

		notifyOnUpdate(function() {
			trace(action.down());
		});
	}
}
