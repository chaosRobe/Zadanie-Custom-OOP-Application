using Godot;
using System;


public partial class character_body_2d : CharacterBody2D
{
    [Export] public float acceleration = 10f;
    [Export] public float max_speed = 800f;
    
    [Export] public float rotation_speed = 0.1f;
    public override void _Process(double delta){
        var sceen = GD.Load("res://laser.tscn");
        var input_vector = new Vector2(0, Input.GetAxis("up","down"));
        Velocity += input_vector.Rotated(GlobalRotation) * acceleration;
        Velocity = Velocity.LimitLength(max_speed);
        if(Input.IsActionPressed("right")){
            Rotate(rotation_speed);
        }
        if(Input.IsActionPressed("left")){
            Rotate(rotation_speed*-1);
        }
        if (input_vector.Y == 0){
            Velocity = Velocity.MoveToward(Vector2.Zero,3);
        }

        MoveAndSlide();


       Vector2 screen_size = GetViewportRect().Size;
       if(GlobalPosition.Y<0){
        GlobalPosition = new Vector2(GlobalPosition.X,screen_size.Y);
       }
        if(GlobalPosition.Y>screen_size.Y){
        GlobalPosition = new Vector2(GlobalPosition.X,0);
       }
        if(GlobalPosition.X<0){
        GlobalPosition = new Vector2(screen_size.X,GlobalPosition.Y);
       }
        if(GlobalPosition.X>screen_size.X){
        GlobalPosition = new Vector2(0,GlobalPosition.Y);
       }
    }
}
