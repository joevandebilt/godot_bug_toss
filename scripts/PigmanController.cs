using Godot;
using HelloGodot.scripts;
using System;

public partial class PigmanController : Area2D
{
	[Export]
	public int Speed { get; set; } = 400;

	private float targetX = 0f;

	private float minX = 0f;
	private float maxX = 0f;
	private bool movingLeft = false;

	private Vector2 screenSize;
	private AnimatedSprite2D pigmanSprite;
	private GameController gameController;

	private Random random = new Random(DateTime.Now.Millisecond);

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		screenSize = GetViewportRect().Size;
		pigmanSprite = GetNode<AnimatedSprite2D>("PigmanSprite");
		gameController = GetNode<GameController>("..");

		var halfX = (screenSize.X / 2) - 100;
		minX = 0 - halfX;
		maxX = halfX;

		targetX = SetNewTarget();

		gameController.GameStart += () =>
		{
			pigmanSprite.Animation = "Run";
			pigmanSprite.Play();
		};

		gameController.GameOver += (score) =>
		{
			pigmanSprite.Animation = "Idle";
			pigmanSprite.Stop();
		};
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		if (pigmanSprite.Animation != "Run")
			return;

		//Target reached
		if ((movingLeft && Position.X < targetX) || (!movingLeft && Position.X > targetX))
		{
			//Drop Bug
			gameController.DropNewBug(Position);

			targetX = SetNewTarget();
		}

		var velocity = Vector2.Zero;
		if (targetX < Position.X)
		{
			velocity.X = -1;
			pigmanSprite.FlipH = false;
		}
		else
		{
			velocity.X = 1;
			pigmanSprite.FlipH = true;
		}

		Position += velocity.Normalized() * Speed * (float)delta;		
	}

	private float SetNewTarget()
	{
		var newTarget = minX + (random.NextSingle() * (screenSize.X - 100));

		movingLeft = newTarget < Position.X;
		
		GD.Print($"New X Target: {newTarget}");
		return newTarget;
	}
}
