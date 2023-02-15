
var cityData = null;

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
    getJSON(data_url,
        function(err, data) {
            if (err !== null) {
                alert('Something went wrong while loading city data: ' + err);
            } else {
                cityData = JSON.parse(data);
            }
        });
}


function initCitySelect(elem) {
    var opt = document.createElement("option");
    opt.disabled = true;
    opt.selected = true;
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

function initCitySelector(countrySelectId, citySelectId) {
    var country_field = document.getElementById(countrySelectId);
    var city_field = document.getElementById(citySelectId);

    initCitySelect(city_field);

    country_field.onchange = function () {
        resetCitySelect(city_field);
        populateCitySelect(city_field, country_field.value);
    };
}