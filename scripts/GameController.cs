using Godot;
using HelloGodot.scripts;
using System;

public partial class GameController : Node2D
{
	private AnimatedSprite2D pigMan;
	private Timer gameTimer;
	private Label timeLabel;
	private Label scoreLabel;


    private int timeRemaining = 30;
	private int score = 0;


    [Signal]
    public delegate void GameStartEventHandler();

    [Signal]
    public delegate void GameOverEventHandler(int finalScore);

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
		EmitSignal(SignalName.GameStart);

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
            GameEnding();
            gameTimer.Stop();
		}
    }

    private void GameEnding()
	{
        EmitSignal(SignalName.GameOver, score);
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
