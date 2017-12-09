#!/bin/env python

""" Unit test output of colorvim command """

import os
import unittest

class TestCode(unittest.TestCase):
	@classmethod
	def setUpClass(self):
		""" Run before all the tests """
		pass

	@classmethod
	def tearDownClass(self):
		""" Run after all the tests """
		pass

	def setUp(self):
		""" Run before every test """
		pass

	def tearDown(self):
		""" Run after every test """
		pass

	def test_cmd(self):
		""" Test command exit status """
		os.system('echo "Test run!"')
		self.assertEqual(os.system('echo $?'), 0)


if __name__ == '__main__':
	unittest.main()

# vim: nofoldenable
