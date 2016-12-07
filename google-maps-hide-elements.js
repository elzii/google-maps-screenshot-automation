/**
 * Notes
 *
 * Syria St, Tripoli, Lebanon
 * - https://www.google.com/maps/@34.4444692,35.8528996,749m/data=!3m1!1e3
 *
 * Chrome DevTools Events
 * - https://developers.google.com/web/tools/chrome-devtools/console/events
 * 
 */


var d = document;

/**
 * List of elements to hide
 */
var selectorsToHide = [
  '#omnibox-container',
  '#rap-card',
  '.app-viewcard-strip',
  '#vasquette',
  '#watermark',
  '#minimap',
  '.scene-footer'
]

/**
 * Click Hamburger Nav
 */
d.querySelectorAll('.searchbox-hamburger')[0].click()

setTimeout(function() {


  /**
   * Turn off labels
   */
  d.querySelectorAll('[jsaction="settings.intent.labels"]')[0].click()


  /**
   * Hide unwanted elements
   */
  selectorsToHide.forEach(function(selector) {
    var el = d.querySelectorAll(selector)
    if ( el.length ) {
      el[0].style.display = 'none'
    }
  })

  /**
   * Disable wheelDeltaX
   */
  document.addEventListener('mousewheel', function(event) {  
    if ( event.wheelDeltaX > 0 || event.wheelDeltaX < 0 ) return;
    console.log(event.wheelDeltaX)
  })


}, 2000)





function sleep(miliseconds) {
  var currentTime = new Date().getTime();
  while (currentTime + miliseconds >= new Date().getTime()) {
  }
}