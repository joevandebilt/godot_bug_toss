using Godot;
using System;

public partial class MainMenu : Node
{
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		GetNode<TextureButton>("MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/New Game Button").Pressed += newGame;
		GetNode<TextureButton>("MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Hi Scores Button").Pressed += hiScore;
		GetNode<TextureButton>("MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Quit Button").Pressed += quitGame;
	}

	private void newGame() => GetTree().ChangeSceneToFile("res://scenes/Game Screen.tscn");
	private void hiScore() => GetTree().ChangeSceneToFile("res://scenes/HiScore.tscn");
	private void quitGame() =>	GetTree().Quit();
}
