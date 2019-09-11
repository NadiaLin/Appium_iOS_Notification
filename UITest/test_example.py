import os
import logging
from time import sleep
import unittest
from appium import webdriver
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.by import By
import device_info
import base
from UITest.notification_center import NotificationCenter

class SimpleiOSTests(unittest.TestCase):
    def setUp(self):
        # get mobile driver
        self.driver = device_info.caps_iphone_7

        # set app init action
        self.app = base.Base(self.driver)

        print("*** app launch ***")

    def tearDown(self):
        # end the session
        notification = self.driver.find_element_by_accessibility_id('NotificationCell')
        NotificationCenter(self.app).clear_notification(notification)
        # self.driver.quit()

    def test_find_elements(self):
        NotificationCenter(self.app).open_notification_center()
        notificationCell = self.driver.find_element_by_accessibility_id('NotificationCell')
        assert notificationCell.text.find("Message") != -1 

    

if __name__ == '__main__':
    suite = unittest.TestLoader().loadTestsFromTestCase(SimpleiOSTests)
    unittest.TextTestRunner(verbosity=2).run(suite)
