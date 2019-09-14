import 'rails-plus/es6/libs';
import 'modules/pagy.js.erb';

import Rails      from 'rails-ujs';
import Turbolinks from 'turbolinks';

Rails.start();
Turbolinks.start();

if (document.readyState !== 'loading') {
  const event = document.createEvent('Event');
  event.initEvent('DOMContentLoaded', true, true);
  window.document.dispatchEvent(event);
}
