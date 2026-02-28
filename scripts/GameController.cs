using Godot;
using System;

public partial class GameController : Node2D
{
	AnimatedSprite2D pigMan;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		pigMan = GetNode<AnimatedSprite2D>("Pigman/PigmanSprite");
		pigMan.Animation = "Standup";
		pigMan.Play();

		pigMan.AnimationFinished += StartGame;
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}

	private void StartGame()
	{
		pigMan.Animation = "Run";
		pigMan.Play();

		//Start pigman AI
		//Unlock player controls
	}
}
