require('../../packs/views/users/new.js')

const fakeDOMLoaded = () => {
  const fakeEvent = document.createEvent('Event')
  fakeEvent.initEvent('DOMContentLoaded', true, true)
  window.document.dispatchEvent(fakeEvent)
}

fakeDOMLoaded()