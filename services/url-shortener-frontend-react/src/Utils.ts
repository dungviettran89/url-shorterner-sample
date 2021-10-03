export const validUrl = (string: string) => {
    try {
        let url = new URL(string);
        return url.protocol.match("https?:")
    } catch (_) {
        return false;
    }
}