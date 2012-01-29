jasmine.DnReporter = function(params) {
};

jasmine.DnReporter.prototype.reportRunnerResults = function(spec) {
  if (window.webkitNotifications.checkPermission() === 0) {
    var results = spec.results();
    var notification;

    var totalCount   = results.totalCount;
    var passedCount    = results.passedCount;
    var failedCount = results.failedCount;
    var body = passedCount + " / " + totalCount + " specs passed, " + failedCount + " failures";

    // icons from http://size7.deviantart.com/
    if (results.passed()) {
      iconUrl = 'http://www.freeiconsweb.com/Icons-show/soft-icons-48/Tick.png';
      title = 'Passed';
    } else {
      iconUrl = 'http://www.freeiconsweb.com/Icons-show/soft-icons-48/Cross.png';
      title = 'Failed';
    }
    notification = window.webkitNotifications.createNotification(iconUrl, title, body);
    setTimeout(function(){
      notification.show();
    }, '100'); // to prevent premature showing during fast refreshes
    setTimeout(function(){
      notification.cancel();
    }, '3000');
  } else {
    console.log('You have to click on "Set notification permissions for this page" ' +
                'first to be able to receive notifications.');
  }
};
