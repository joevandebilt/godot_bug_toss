using Godot;
using HelloGodot.Extensions;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

public partial class HiScore : Control
{
	private const string highscores = "highscores.txt";

	private RichTextLabel highScoreTable;
	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		GetNode<Button>("MarginContainer/VBoxContainer/ReturnButton").Pressed += BackToMainMenu;
		highScoreTable = GetNode<RichTextLabel>("MarginContainer/VBoxContainer/HighScores");
		LoadHighScores();
	}

	private void BackToMainMenu() => GetTree().ChangeSceneToFile("res://scenes/Main-Menu.tscn");
	
	private void LoadHighScores()
	{
		if (File.Exists(highscores))
		{
			using var reader = new StreamReader(highscores);

			var scores = reader.ReadToEnd().Split('\n', StringSplitOptions.TrimEntries | StringSplitOptions.RemoveEmptyEntries).ToList();
			if (scores.Any())
			{
				var checksum = scores.First();
				scores.RemoveAt(0);

				var calculated_checksum = Md5Extensions.GetMd5Checksum(scores);

				if (calculated_checksum != checksum)
				{
					//Somebody modified this
					highScoreTable.Text = "You've been cheating :(";
				}
				else
				{
					var entries = new List<string>();
					foreach (var entry in scores)
					{
						var parts = entry.Split(',');
						if (parts.Length != 3)
							throw new ArgumentException("High Scores file has been corrupted");

						var name = parts[0];
						var score = int.Parse(parts[1]);
						var time = new DateTime(long.Parse(parts[2]));

						entries.Add($"[cell]{score}[/cell][cell padding=100,0,100,0]{name}[/cell][cell]{DateTime.Now.Subtract(time).Days} days ago[/cell]");
					}

					highScoreTable.Text = $"[table=3][cell][b]Score[/b][/cell][cell padding=100,0,100,0][b]Player[/b][/cell][cell][b]Time[/b][/cell]{string.Concat(entries)}[/table]";
				}
			}

		}
	}
}
