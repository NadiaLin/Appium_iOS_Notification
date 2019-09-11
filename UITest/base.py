import os
import logging
import unittest
from appium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.by import By
from selenium.common.exceptions import TimeoutException
from selenium.common.exceptions import NoSuchElementException



class Base(object):
    def __init__(self, driver):
        self.driver = driver

    def wait_for(self, element_locator, time=10):
        try:
            print("Waiting", element_locator.locator)
            element = WebDriverWait(self.driver, time).until(element_locator)
            print(element_locator.locator, "is present!")
        except NoSuchElementException:
            print("Element not found", element_locator.locator)


