enum DineInWorkmanager {
  periodic("com.example.restaurant_app", "com.example.restaurant_app");

  final String uniqueName;
  final String taskName;

  const DineInWorkmanager(this.uniqueName, this.taskName);
}
