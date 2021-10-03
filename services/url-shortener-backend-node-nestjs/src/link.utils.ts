const murmurhash = require("murmurhash")
const Hashids = require('hashids');
const hashids = new Hashids();
let SEQUENCE = 1;
export const generateId = (url: string) => {
    const hash: number = murmurhash.v3(url) & 0x7fffffff;
    const sequence = SEQUENCE++ % 1024
    const id = hash << 10 | sequence;
    return hashids.encode(id);
};
export const validUrl = (string: string) => {
    try {
        let url = new URL(string);
        return url.protocol.match("https?:")
    } catch (_) {
        return false;
    }
}