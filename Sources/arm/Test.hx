package arm;

import iron.object.Object;
import arm.inputmap.InputMap;
import armory.trait.physics.RigidBody;

class Test extends iron.Trait {

	var rb: RigidBody;

	var input: InputMap;
	var traceSomething: Dynamic;

	public function new() {
		super();

		notifyOnInit(function() {
			rb = object.getTrait(RigidBody);

			input = new InputMap(0);
			input.setCurrentTag("Keyboard");

			input.createAction("traceSomething");
			traceSomething = input.getAction("traceSomething");
			traceSomething.addKeyboardComponent("Keyboard", "w", ["control"]);
			traceSomething.addKeyboardComponent("Keyboard", "up");
			traceSomething.addMouseComponent("Keyboard", "left");
	
			input.createAxis("move");
			var move = input.getAxis("move");
			move.addKeyboardComponent("y", "Keyboard", "w", "s");
			move.addKeyboardComponent("x", "Keyboard", "d", "a");
			move.addMouseComponent("x", "Keyboard", "right", "left");
			move.setScale(5.0, 5.0);
			move.enableNormalize();
		});

		notifyOnUpdate(function() {
			if (input.isActionReleased("traceSomething")) trace("Action done!");
			//or if (traceSomething.released()) trace("Action done!");

			var moveVec = input.getVec("move");
			rb.setLinearVelocity(moveVec.x, moveVec.y, moveVec.z);
		});
	}
}