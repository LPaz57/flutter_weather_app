String imageHandler(int id, String time) {
  if (id < 300) {
    return 'assets/img/storm.png';
  } else if (id < 400) {
    return 'assets/img/rain.png';
  } else if (id == 500) {
    return 'assets/img/night_rainy.png';
  } else if (id == 500 && time == 'night') {
    return 'assets/img/sun_rainy.png';
  } else if (id < 600) {
    return 'assets/img/rainy.png';
  } else if (id < 700) {
    return 'assets/img/snowy.png';
  } else if (id < 800) {
    return 'assets/img/foog.png';
  } else if (id == 800) {
    return 'assets/img/sunny.png';
  } else if (id <= 804) {
    return 'assets/img/cloud.png';
  } else if (id == 801) {
    return 'assets/img/cloudy.png';
  } else if (id == 801 && time == '') {
    return 'assets/img/night_cloudy.png';
  } else {
    return 'assets/img/cloudy.png';
  }
}

String getMessage(int temp) {
  if (temp > 25) {
    return 'It\'s 🍦 time';
  } else if (temp > 20) {
    return 'Time for shorts and 👕';
  } else if (temp < 10) {
    return 'You\'ll need 🧣 and 🧤';
  } else {
    return 'Bring a 🧥 just in case';
  }
}
