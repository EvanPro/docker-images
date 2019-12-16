/**
 * 将整数转为ip 拼接为目标ip+端口号
 * @param {*} r 参见：https://nginx.org/en/docs/njs/index.html
 */
function longtoip(r) {
    var port = r.variables["port"];

    var i = r.variables["targetip"];

    return ((i >> 24) & 0xFF)+"." + ((i >> 16) & 0xFF) + "." + ((i >> 8) & 0xFF) + "." + (i & 0xFF) + ":" + port;
}
