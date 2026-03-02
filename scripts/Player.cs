using Godot;
using System;
using System.Runtime.CompilerServices;

public partial class Player : Area2D
{
	[Export]
	public int Speed { get; set; } = 400;

	public Vector2 ScreenSize;

	private AnimatedSprite2D playerSprite;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		ScreenSize = GetViewportRect().Size;
		playerSprite = GetNode<AnimatedSprite2D>("PlayerSprite");
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		var velocity = Vector2.Zero; // The player's movement vector.
		if (Input.IsActionPressed("move_right"))
		{
			velocity.X += 1;
			playerSprite.FlipH = false;
		}

		if (Input.IsActionPressed("move_left"))
		{
			velocity.X -= 1;
			playerSprite.FlipH = true;
		}

		if (velocity.Length() > 0)
		{
			velocity = velocity.Normalized() * Speed;
			playerSprite.Play();
		}
		else
		{
			playerSprite.Stop();
		}

		var halfX = (ScreenSize.X / 2) - 100;
		Position += velocity * (float)delta;
		Position = new Vector2(
			x: Mathf.Clamp(Position.X, 0 - halfX, 0 + halfX),
			y: Mathf.Clamp(Position.Y, 0, ScreenSize.Y)
		);
	}
}
