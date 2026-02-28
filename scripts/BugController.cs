using Godot;
using System;
using System.Diagnostics;
using System.Reflection.Metadata.Ecma335;

namespace HelloGodot.scripts
{
    public partial class BugController : Area2D
    {
        private int speed = 0;
        private int type = 0;
        private int score = 0;

        private Random random = new Random(DateTime.Now.Millisecond);


        public override void _Ready()
        {
            ApplyScale(new Vector2(2, 2));

            var sprite = new AnimatedSprite2D();
            sprite.SpriteFrames = GD.Load<SpriteFrames>("res://sprites/bug_animations.tres");

            type = random.Next(1, 11) switch
            {
                1 or 2 or 3 or 4 => 1,
                5 or 6 or 7 => 2,
                8 or 9 => 3,
                10 => 4,
                _ => 1
            };

            GD.Print($"Bug type: {type}");
            score = type switch
            {
                1 => 5,
                2 => 10,
                3 => 15,
                4 => 30,
                _ => throw new Exception("YOU FUCKED UP")
            };
            speed = random.Next(100, 300);
            sprite.Animation = $"bug_{type}";

            //Add sprite to this node
            this.AddChild(sprite);

            sprite.Play();

            var collisionShape = new CollisionShape2D();
            collisionShape.Shape = new CircleShape2D() { Radius = 17 };
            this.AddChild(collisionShape);

            AreaEntered += OnCollision;
            BodyEntered += OnCollision;
        }

        private void OnCollision(Node2D body)
        {
            if (body is Player player)
            {
                GD.Print($"Collided with player! Score: {score}");
                player.AddPoints(score);
                QueueFree();
            }
        }

        public override void _Process(double delta)
        {
            Position += Vector2.Down * speed * (float)delta;
            if (Position.Y > GetViewportRect().Size.Y)
            {
                QueueFree();
            }
        }
    }
}
