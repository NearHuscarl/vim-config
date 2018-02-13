#!/bin/env python

""" Unittest python code """

import unittest

class TestCode(unittest.TestCase):
	""" Test template """

	@classmethod
	def setUpClass(cls):
		""" Run before all the tests """
		pass

	@classmethod
	def tearDownClass(cls):
		""" Run after all the tests """
		pass

	def setUp(self):
		""" Run before every test """
		pass

	def tearDown(self):
		""" Run after every test """
		pass

	def test_cmd(self):
		""" test methods must start with 'test_' """

		self.assertEqual(1 + 1, 2)
		self.assertNotEqual(2, '2')
		self.assertTrue('The earth is round' is not True)
		self.assertFalse('The earth is round' is True)
		self.assertIs(object, object)
		self.assertIsNot(int, float)
		self.assertIsNone(None)
		self.assertIsNotNone(not None)
		self.assertIn('a', ['a', 'b', 'c'])
		self.assertNotIn('A', ['a', 'b', 'c'])
		self.assertIsInstance(1, int)
		self.assertNotIsInstance(1.0, int)


if __name__ == '__main__':
	unittest.main()

# vim: nofoldenable
