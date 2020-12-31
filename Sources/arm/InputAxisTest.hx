package arm;

import iron.object.Object;
import arm.inputmap.InputAxis;
import armory.trait.physics.RigidBody;

class InputAxisTest extends iron.Trait {

	var rb: RigidBody;

	var move: InputAxis;

	public function new() {
		super();

		notifyOnInit(function() {
			rb = object.getTrait(RigidBody);

			move = new InputAxis();

			move.addKeyboardElement("y", "w", "s");
			move.addKeyboardElement("x", "d", "a");
			move.addMouseElement("x", "right", "left");

			move.setNormalize(true, true, true);
			move.setScale(5.0, 5.0, 5.0);
		});

		notifyOnUpdate(function() {
			trace(move.get());

			rb.setLinearVelocity(move.get().x, move.get().y, move.get().z);
		});
	}
}