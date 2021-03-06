@ui-cart
Feature: Apply correct shipping fee with product taxes on order
    In order to pay proper amount for shipping and product taxes
    As a Customer
    I want to have correct shipping fees and all taxes applied to my order

    Background:
        Given the store is operating on a single channel
        And the store ships to "Australia" and "France"
        And there is "EU" zone containing all members of European Union
        And there is rest of the world zone containing all other countries
        And default currency is "EUR"
        And default tax zone is "EU"
        And there is user "john@example.com" identified by "password123"
        And the store has "EU VAT" tax rate of 23% for "Clothes" within "EU" zone
        And the store has "Low tax" tax rate of 10% for "Clothes" for the rest of the world
        And the store has "EU Shipping VAT" tax rate of 23% for "Shipping Services" within "EU" zone
        And the store has "Low Shipping VAT" tax rate of 10% for "Shipping Services" for the rest of the world
        And the store has a product "PHP T-Shirt" priced at "€100.00"
        And product "PHP T-Shirt" belongs to "Clothes" tax category
        And the store has "DHL" shipping method with "€10.00" fee within "EU" zone
        And the store has "DHL-World" shipping method with "€10.00" fee for the rest of the world
        And shipping method "DHL" belongs to "Shipping Services" tax category
        And shipping method "DHL-World" belongs to "Shipping Services" tax category
        And the store allows paying offline
        And I am logged in as "john@example.com"

    Scenario: Proper shipping fee, tax and product tax
        Given I am logged in as "john@example.com"
        And I add product "PHP T-Shirt" to the cart
        When I proceed selecting "DHL" shipping method
        Then my cart total should be "€135.30"
        And my cart taxes should be "€25.30"
        And my cart shipping fee should be "€12.30"

    Scenario: Proper shipping fee, tax and products' taxes after addressing
        Given I am logged in as "john@example.com"
        And I add 3 products "PHP T-Shirt" to the cart
        And I proceed selecting "Australia" as shipping country with "DHL" method
        Then my cart total should be "€341.00"
        And my cart taxes should be "€31.00"
        And my cart shipping fee should be "€11.00"
