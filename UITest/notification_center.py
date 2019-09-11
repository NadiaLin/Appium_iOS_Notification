import os
import logging
from time import sleep
import unittest
from appium import webdriver
from appium.webdriver.common.touch_action import TouchAction
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from .base import Base

open = True
close = False

notificationCenter = EC.presence_of_element_located((By.ID, "SBSwitcherWindow"))

class Point:
    def __init__(self, x_init, y_init):
        self.x = x_init
        self.y = y_init

class NotificationCenter(Base):

    def __init__(self, app):
        self.driver = app.driver
        print("** Notification Center Open")

    def open_notification_center(self):
        self.manage_notification_center(open)
        Base.wait_for(self, notificationCenter)

    def close_notification_center(self):
        self.manage_notification_center(close)
        sleep(1)

    def manage_notification_center(self, show):
        yMargin = 5
        xMid = self.driver.get_window_size()['width'] / 2

        print(xMid)

        top = Point(xMid, yMargin)
        bottom = Point(xMid, self.driver.get_window_size()['height'] - yMargin)

        action = TouchAction(self.driver)

        if show:
            action.press(None, top.x, top.y)
        else:
            action.press(None, bottom.x, bottom.y)

        action.wait(1000)

        if show:
            action.move_to(None, bottom.x, bottom.y)
        else:
            action.move_to(None, top.x, bottom.y)

        action.perform()

    def clear_notification(self, element):
        self.driver.execute_script("mobile: swipe", {"direction": "left", "element": element})
