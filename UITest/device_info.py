from appium import webdriver

#///////////////////////// Shiv's iPhone 7 ///////////////////////////
iPhone_7 = {
    "platformName": "iOS",
    "deviceName": "iPhone 7 real",
    "automationName": "XCUITest",
    "bundleId": "  ",
    "xcodeOrgId": " ",
    "xcodeSigningId": " ",
    "udid": " "
}
caps_iphone_7 = webdriver.Remote('http://localhost:4723/wd/hub', iPhone_7)

