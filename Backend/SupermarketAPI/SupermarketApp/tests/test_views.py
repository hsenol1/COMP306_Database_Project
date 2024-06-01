from django.test import TestCase, Client
from django.urls import reverse
import json

class ProductTests(TestCase):

    def setUp(self):
        self.client = Client()
        # You can set up initial data here if necessary
        # For example, create some product instances if you have a Product model

    def test_get_products(self):
        response = self.client.get(reverse('get-products'))
        self.assertEqual(response.status_code, 200)
        products = json.loads(response.content)
        print(f"Products from test: {products}")  # Debug print statement
        self.assertTrue(len(products) > 0)  # Adjust this based on your expected data
