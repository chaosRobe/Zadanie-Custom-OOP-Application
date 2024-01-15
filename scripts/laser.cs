using Godot;
using System;

public partial class laser : Area2D
{
    [Export] float speed = 30f;
    
    public override void _Process(double delta){
        var movement_vector = new Vector2(0,-1);
        GlobalPosition += movement_vector.Rotated(Rotation) * speed;
    }
    private void OnVisibleOnScreenNotifier2DScreenExited() {
        Console.WriteLine("delete");
        QueueFree();
    }
}
