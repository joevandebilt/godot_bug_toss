using Godot;
using HelloGodot.Extensions;
using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;

public partial class FinalScorePanel : Node2D
{
	private GameController gameController;
	private LineEdit playerName;
	private Button submitScoreButton;
	private RichTextLabel resultsLabel;

	private int finalScore = 0;

	private const string highscores = "highscores.txt";

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
		var scores = new List<string>();
		if (File.Exists(highscores))
		{
			using var reader = new StreamReader(highscores);
			scores = reader.ReadToEnd().Split('\n', StringSplitOptions.TrimEntries | StringSplitOptions.RemoveEmptyEntries).ToList();
			if (scores.Any())
				scores.RemoveAt(0);
		}
		scores.Add($"{playerName.Text},{finalScore},{DateTime.Now.Ticks}");

		using (var writer = new StreamWriter(highscores, append: false))
		{
			writer.WriteLine(Md5Extensions.GetMd5Checksum(scores));
			scores.ForEach(s => writer.WriteLine(s));
		}

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
