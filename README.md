<h1>The Gossip Project 💻</h1>

On crée une base de données pour The Gossip Project avec des utilisateurs qui écrivent des potins, qui peuvent les commenter, s'envoyer des messages...

* Ruby version 2.5.1
* Rails version 5.2.3
* `bundle install`
* `rails db:migrate`
* `rails db:seed`
* rendez-vous dans la console pour tester tout ça...

<h2>Tables</h2>

Les différentes tables : 
* `users` : tous nos utilisateurs
* `cities` : chaque utilisateur est lié à une ville
* `gossips` : chaque gossip est lié à un utilisateur
* `tags` : un gossip peut avoir plusieurs tags
* `gossip_tags` : table qui lie gossips et tags
* `private_messages` : contenu envoyé par un utilisateur à un (ou plusieurs) autre utilisateur

<h2>Relations</h2>

1-to-n :
* `cities` - `users`
* `users` - `gossips`

n-to-n :
* `gossips` - `tags` (liés par `gossip_tags`)
* `users` - `users` (liés par `private_messages`)

--------

Fait par [Ladislas](https://github.com/ladislasfontaine) 🤙 en utilisant les ressources de [The Hacking Project](https://www.thehackingproject.org)
