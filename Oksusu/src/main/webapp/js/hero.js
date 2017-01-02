//콤마찍기
function Money(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

//콤마풀기
function unMoney(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, '');
}

//입력시콤마
function inputNumberFormat(obj) {
    obj.value = comma(uncomma(obj.value));
}

// post 전송
function postToUrl(path, params, method) {
    method = method || "post";  //method 부분은 입력안하면 자동으로 post가 된다.
    var form = document.createElement("form");
    form.setAttribute("method", method);
    form.setAttribute("action", path);
    //input type hidden name(key) value(params[key]);
    for(var key in params) {
        var hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "hidden");
        hiddenField.setAttribute("name", key);
        hiddenField.setAttribute("value", params[key]);
        form.appendChild(hiddenField);
    }
    document.body.appendChild(form);
    form.submit();
}