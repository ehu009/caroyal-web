// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

//= require chartkick
//= require Chart.bundle


function open_nav(id) {
    var e = document.getElementById(id);
    e.classList.add('nav-veil-fadein');
    e.classList.remove('nav-veil-fadeout');
  }
  function close_nav(id) {
    var e = document.getElementById(id);
    e.classList.remove('nav-veil-fadein');
    e.classList.add('nav-veil-fadeout');
  }
  function unveil(id) {
    var e = document.getElementById(id);
    e.classList.add('veil-fadeout');
  }
  function remove_toast(id) {
    var e = document.getElementById(id);
    e.classList.remove('show');
  }



  
var cityData = null;
var cityDataAvailable = new Event("city-data-available");

function getCityData(data_url) {
    
    var getJSON = function(url, callback) {
        var xhr = new XMLHttpRequest();
        xhr.open('GET', url, true);
        xhr.onload = function() {
        var status = xhr.status;
        if (status === 200) {
            callback(null, xhr.response);
        } else {
            callback(status, xhr.response);
        }
        };
        xhr.send();
    };
    var dataset = {};
    getJSON(data_url,
        function(err, data) {
            if (err !== null) {
                alert('Something went wrong while loading city data: ' + err);
            } else {

                cityData = JSON.parse(data);
                dispatchEvent(cityDataAvailable);
            }
        });
        /*
    console.log(dataset[4])
    return dataset;*/
}


function initCitySelect(elem) {
  var opt = document.createElement("option");
  opt.disabled = true;
  opt.text = "Select a country first";
  elem.appendChild(opt);
}
function resetCitySelect(elem) {
  elem.innerHTML = '';
  initCitySelect(elem);
}
function addCitySelectOption(elem, option) {
  var opt = document.createElement("option");
  opt.value = option;
  opt.text = option;
  elem.appendChild(opt);
}

function populateCitySelect(elem, countryCode) {
  var filtered = cityData.filter(city => city['country'] == countryCode);
  var l = [];
  for (e of filtered) {
      l.push(e['name']);
  }
  for (e of l.sort()) {
      addCitySelectOption(elem, e);
  }
}

function initCitySelector(countrySelectId, citySelectId, initCountry, initCity) {
  var country_field = document.getElementById(countrySelectId);
  var city_field = document.getElementById(citySelectId);

  initCitySelect(city_field);
  
  addEventListener("city-data-available",
      () => {      
          if (initCountry != "") {
              if (initCity != "" | initCity != undefined) {
                  populateCitySelect(city_field, initCountry);
                  city_field.value = initCity;
              }
          }
          country_field.onchange = function () {
              resetCitySelect(city_field);
              populateCitySelect(city_field, country_field.value);
          };
      },
  false);
}
