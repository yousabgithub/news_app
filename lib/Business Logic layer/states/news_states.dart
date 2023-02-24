abstract class NewsStates {}

class InitNewsStates extends NewsStates {}

class NewsDataLoadingState extends NewsStates {}

class NewsDataSuccessState extends NewsStates {}

class NewsDataErrorState extends NewsStates {}

class OnChangeCountryState extends NewsStates {}

class GetCountryPrefState extends NewsStates {}

class SearchNewsLoadingState extends NewsStates {}

class SearchNewsSuccessState extends NewsStates {}

class SearchNewsErrorState extends NewsStates {}

class ClearSearchDataSuccessState extends NewsStates {}
