using Godot;
using HelloGodot.scripts;
using System;

public partial class GameController : Node2D
{
	AnimatedSprite2D pigMan;
	Timer gameTimer;
	Label timeLabel;
	Label scoreLabel;


    int timeRemaining = 30;
	int score = 0;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		pigMan = GetNode<AnimatedSprite2D>("Pigman/PigmanSprite");
		pigMan.Animation = "Standup";
		pigMan.Play();

		pigMan.AnimationFinished += StartGame;
	}

    private void StartGame()
	{
		pigMan.Animation = "Run";
		pigMan.Play();

		timeLabel = GetNode<Label>("TimeLabel");

        //Start countdown
        gameTimer = GetNode<Timer>("Timer");
        gameTimer.Start();
        gameTimer.Timeout += UpdateTimer;
	}

    private void UpdateTimer()
    {
		timeRemaining--;
		timeLabel.Text = $"Time Remaining: {timeRemaining:00}";

		if (timeRemaining <= 0)
		{
			GameOver();
            gameTimer.Stop();
		}
    }

    private void GameOver()
	{
		pigMan.Animation = "Idle";
	}

    public void DropNewBug(Vector2 position)
    {
        var newBug = new BugController();
        newBug.Position = position;
        newBug.BugCollected += AddPoints;
        AddChild(newBug);
    }

    private void UpdateScore()
    {
        if (scoreLabel == null)
            scoreLabel = GetNode<Label>("ScoreLabel");

        scoreLabel.Text = $"Score: {score:0000}";
    }

    private void AddPoints(int points)
    {
        score += points;
        UpdateScore();
    }
}
