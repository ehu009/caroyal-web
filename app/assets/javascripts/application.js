//= require chartkick
//= require Chart.bundle
//= require city_select

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