
## Build

xcodebuild -scheme moneyapp archive -archivePath $TMPDIR/test.xcarchive -workspace moneyapp.xcworkspace

xcodebuild -exportArchive -exportFormat ipa -archivePath $TMPDIR/test.xcarchive -exportPath $TMPDIR/test.ipa -exportProvisioningProfile "iOS Team Provisioning Profile: inviewads.testIA"


