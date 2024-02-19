/**
 * 
 */
 
 
 // "yyyy-MM-dd HH:mm:ss"
function dateFormat(d) {
	
	function pad(n) { return n<10 ? "0"+n : n }
	
	return d.getFullYear()+"-"+
    pad(d.getMonth()+1)+"-"+
    pad(d.getDate())+" "+
    pad(d.getHours())+":"+
    pad(d.getMinutes())+":"+
    pad(d.getSeconds());

}

function contentScroll() {
	chatUl = document.querySelector('#chatBox');
	chatUl.scrollTop = chatUl.scrollHeight;
}