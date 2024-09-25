  final Map<int, List<DateTime>> _monthCellsMap = {};

  generateMonthCells(DateTime month) async {
    List<DateTime> cells = [];
    var totalDaysInMonth = DateUtils.getDaysInMonth(month.year, month.month);

    var firstDayDt = DateTime(month.year, month.month, 1);
    var previousMonthDt = firstDayDt.subtract(const Duration(days: 1));
    var nextMonthDt = DateTime(month.year, month.month, totalDaysInMonth)
        .add(const Duration(days: 1));

    var firstDayOfWeek = firstDayDt.weekday;
    var previousMonthDays =
        DateUtils.getDaysInMonth(previousMonthDt.year, previousMonthDt.month);

    var previousMonthCells = List.generate(
        firstDayOfWeek - 1,
        (index) => DateTime(previousMonthDt.year, previousMonthDt.month,
            previousMonthDays - index));
    cells.addAll(previousMonthCells.reversed);

    var currentMonthCells = List.generate(totalDaysInMonth,
        (index) => DateTime(month.year, month.month, index + 1));
    cells.addAll(currentMonthCells);

    var remainingCellCount = 35 - cells.length;
    if (cells.length > 35) {
      remainingCellCount = 42 - cells.length;
    }
    var nextMonthCells = List.generate(remainingCellCount,
        (index) => DateTime(nextMonthDt.year, nextMonthDt.month, index + 1));
    cells.addAll(nextMonthCells);
    _monthCellsMap[month.month] = cells;
  }

  void generateYearData() {
    List.generate(12, (index) {
      generateMonthCells(DateTime(_today.year, index + 1, 1));
    });
  }
