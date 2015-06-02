require 'notifier'

describe Notifier do
  it "checks if a notification is triggered" do
    send_notification = instance_double("WatchedText", notify: true)
    expect(Notifier.should_send?(send_notification)).to be true

    no_notification= instance_double("WatchedText", notify: false)
    expect(Notifier.should_send?(no_notification)).to be false
  end

  it "checks if a user has a slack username" do
    has_slack = instance_double("User", slack_username: 'adampash')
    expect(Notifier.has_slack?(has_slack)).to be true

    no_slack = instance_double("User", slack_username: nil)
    expect(Notifier.has_slack?(no_slack)).to be false
  end

end
