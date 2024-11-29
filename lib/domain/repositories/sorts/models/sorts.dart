class Sorts {
  Sorts({required this.name, required this.option});
  final String name;
  final String option;
}

List<Sorts> getSorts() {
  return [
    Sorts(name: 'Актуальность и имя', option: 'relevance'),
    Sorts(name: 'Имя', option: 'name'),
    Sorts(name: 'Дата создания задачи', option: 'date')
  ];
}
