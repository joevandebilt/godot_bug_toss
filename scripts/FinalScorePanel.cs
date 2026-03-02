using Godot;
using System;
using System.IO;

public partial class FinalScorePanel : Node2D
{
	private GameController gameController;
	private LineEdit playerName;
	private Button submitScoreButton;
	private RichTextLabel resultsLabel;

	private int finalScore = 0;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		Hide();

		gameController = GetNode<GameController>("..");
		gameController.GameOver += ShowFinal;

		submitScoreButton = GetNode<Button>("Panel/SaveScoreButton");
		submitScoreButton.Pressed += SaveScore;

		playerName = GetNode<LineEdit>("Panel/PlayerName");
		resultsLabel = GetNode<RichTextLabel>("Panel/ResultsLabel");
	}

	private void SaveScore()
	{
		//Save high scores logic here
		GetTree().ChangeSceneToFile("res://scenes/Hi-Score.tscn");
	}

	private void ShowFinal(int score)
	{
		resultsLabel.Text = $"You eat like a pig!\r\nScore: {score}";
		finalScore = score;
		Show();
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}
}
