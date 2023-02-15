
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
