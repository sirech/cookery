# -*- coding: utf-8 -*-

if Rails.env.development?

  def i(name)
    Ingredient.where(name: name).first
  end

  def categories(*categories)
    Category.where(name: categories)
  end

  %w(aceite ajo sal pimienta agua soja jengibre chili cebolla pimiento zanahoria patata pollo costilla carne salmón avecrem tomate harina azúcar alcachofa arroz guisante chorizo pimentón).each do |ingredient|
    Ingredient.create name: ingredient
  end

  %w(horno wok español pasta arroz dip).each do |category|
    Category.create name: category
  end

  Recipe.create name: 'paella',
                difficulty: 'medium',

                categories: categories('español', 'arroz'),

                pictures: (['pan.png'] * 3).map { |n| Picture.create(caption: 'pic', photo: Rails.root.join('spec', 'fixtures', n).open) },

                videos: ['https://www.youtube.com/embed/T-eDbjeTA3E'],

                steps: [
    Step.create(name: 'dorar', duration: 10.minutes,
      notes: 'No tiene que hacerse, solo coger color',
      quantities: [
        Quantity.create(unit: 'tablespoon', amount: 1, ingredient: i('aceite')),
        Quantity.create(unit: 'piece', amount: 3, ingredient: i('pollo')),
        Quantity.create(unit: 'piece', amount: 2, ingredient: i('costilla'))
      ]
    ),
    Step.create(name: 'carne', duration: 1.hour,
      notes: 'No hace falta sal',
      quantities: [
        Quantity.create(unit: 'ml', amount: 1000, ingredient: i('agua')),
        Quantity.create(unit: 'piece', amount: 3, ingredient: i('pollo')),
        Quantity.create(unit: 'piece', amount: 2, ingredient: i('costilla')),
        Quantity.create(unit: 'piece', amount: 1, ingredient: i('avecrem')),
        Quantity.create(unit: 'pinch', amount: 1, ingredient: i('sal'))
      ]
    ),
    Step.create(name: 'arroz', duration: 25.minutes,
      notes: "Antes de poner el arroz se sofríe con ajo, después se echa el tomate. El doble de agua que de arroz más un poco\nAl principio el fuego fuerte, a los 5 minutos se baja. Cuando apenas queda agua se cubre la sartén",
      quantities: [
        Quantity.create(unit: 'teaspoon', amount: 1, ingredient: i('aceite')),
        Quantity.create(unit: 'piece', amount: 2, ingredient: i('ajo')),
        Quantity.create(unit: 'cup', amount: 2, ingredient: i('arroz')),
        Quantity.create(unit: 'cup', amount: 5, ingredient: i('agua')),
        Quantity.create(unit: 'ml', amount: 100, ingredient: i('tomate')),
        Quantity.create(unit: 'piece', amount: 8, ingredient: i('pimiento')),
        Quantity.create(unit: 'piece', amount: 4, ingredient: i('alcachofa')),
        Quantity.create(unit: 'piece', amount: 3, ingredient: i('pollo')),
        Quantity.create(unit: 'piece', amount: 2, ingredient: i('costilla')),
      ]
    )
  ]

  Recipe.create name: 'patatas a la riojana',
                difficulty: 'easy',

                categories: categories('español'),

                videos: ['https://www.youtube.com/embed/pXXMaVzINt4'],

                steps: [
    Step.create(name: 'cocer', duration: 25.minutes,
      notes: 'Antes de poner el agua se sofríe todo con un poco de aceite en la cazuela',
      quantities: [
        Quantity.create(unit: 'tablespoon', amount: 1, ingredient: i('aceite')),
        Quantity.create(unit: 'piece', amount: 1, ingredient: i('ajo')),
        Quantity.create(unit: 'piece', amount: 1, ingredient: i('cebolla')),
        Quantity.create(unit: 'pinch', amount: 1, ingredient: i('sal')),
        Quantity.create(unit: 'ml', amount: 1000, ingredient: i('agua')),
        Quantity.create(unit: 'piece', amount: 1, ingredient: i('chorizo')),
        Quantity.create(unit: 'piece', amount: 1, ingredient: i('pimiento')),
        Quantity.create(unit: 'piece', amount: 6, ingredient: i('patata')),
      ]
    )

  ]

end
