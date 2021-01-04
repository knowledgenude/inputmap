package arm;

import iron.object.Object;
import arm.inputmap.InputMap;
import armory.trait.physics.RigidBody;

class Test extends iron.Trait {

	var rb: RigidBody;
	var input: InputMap;

	public function new() {
		super();

		notifyOnInit(function() {
			rb = object.getTrait(RigidBody);

			input = new InputMap(0);
			input.setCurrentTag("Keyboard");
			input.createAxis("move", 0.0, 10); // name, pressure, deadzone
			input.createAction("action"); // optional params: pressure, deadzone

			var action = input.getAction("action");
			action.addKeyboardComponent("Keyboard", "w", ["control"]);
			action.addKeyboardComponent("Keybiard", "up", ["alt"]);
			action.addKeyboardComponent("Keyboard", "a");

			var move = input.getAxis("move");
			move.addMouseComponent("x", "Keyboard", "movement x", "movement x"); // position, tag, positive key, negative key
			move.addKeyboardComponent("x", "Keyboard", "d", "a");
			move.addKeyboardComponent("y", "Keyboard", "w", "s");
			move.setScale(5.0, 5.0);
			//move.enableNormalize(); // don't use normalize for values outside 0-1 range like mouse movement
		});

		notifyOnUpdate(function() {
			var moveVec = input.getVec("move");
			rb.setLinearVelocity(moveVec.x, moveVec.y, moveVec.z);

			if (input.isActionPressed("action")) trace("action pressed");
			if (input.isActionReleased("action")) trace("action released");
		});
	}
}