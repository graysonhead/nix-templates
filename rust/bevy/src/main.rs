use bevy::prelude::*;

fn main() {
    App::new()
        .insert_resource(ClearColor(Color::BLACK))
        .add_plugins(DefaultPlugins)
        .add_startup_system(spawn_scene)
        .add_system(rotate_scene)
        .run();
}

#[derive(Reflect, Component)]
pub struct Rotate {}

fn spawn_scene(mut commands: Commands, assets: Res<AssetServer>) {
    let lighthouse = assets.load("lighthouse.glb#Scene0");
    commands.spawn(PointLightBundle {
        point_light: PointLight {
            intensity: 150.0,
            shadows_enabled: true,
            ..default()
        },
        transform: Transform::from_xyz(0.0, 0.0, 0.0),
        ..default()
    });
    commands
        .spawn(SceneBundle {
            scene: lighthouse,
            transform: Transform::from_xyz(0.0, 0.0, 0.0),
            ..Default::default()
        })
        .insert(Rotate{});
    let mut camera_transform = Transform::from_xyz(-5.0, 2.0, -5.0);
    let camera_direction =
        (Transform::from_xyz(0.0, 0.0, 0.0).translation - camera_transform.translation).normalize();
    camera_transform.look_at(camera_direction, Vec3::Y);
    commands.spawn(Camera3dBundle {
        transform: camera_transform,
        ..Default::default()
    });
}

fn rotate_scene(mut scene_object: Query<(Entity, &Rotate, &mut Transform)>) {
    for (_, _, mut transform) in &mut scene_object {
        transform.rotate_y(0.1);
    }
}
