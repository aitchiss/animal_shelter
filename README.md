# animal_shelter

This web application was my first project undertaken at CodeClan, after four weeks of learning basic Ruby programming, SQL and Sinatra. The project was to be completed within 6 days.

The brief for the project was as follows:
```
The Scottish Animal Shelter accepts orphaned or stray animals and takes care of them until they can 
be adopted by a new owner. The shelter has a list of potential new owners for the animals. 
Animals may take a while to be trained up and made healthy before being available for adoption.

They are looking for a management system to keep track of their animals and owners.

MVP:

- A list of all their animals and their admission date
- Mark an animal as being adoptable/not adoptable
- Assign an animal to a new owner
- List all the owners and their adopted animals
```

### Contraints

The finished product was to be completed using only Ruby, Sinatra, PostgreSQL and basic HTML/CSS. Some features (e.g. filtered index list based on animal type/status) may have been easier to develop using other tools, but workarounds were found.

### My approach

I started this project by constructing a [Use Case Diagram](documentation/animal_shelter_use_case.jpg), clearly defining the system's users and their requirements. This included the uses in the MVP, but also some extensions:
- full CRUD actions for owners and animals
- easily filtered views for adoptable/not adoptable animals
- search for animals by breed/type
- live tracking of progress for employees on the homepage
- view matches between animals and owners, dependent on each animal's individual needs, and the owner's home environment



The last point seemed essential for any good animal shelter!

After constructing the Use Case Diagram, I created a Class Diagram and Entity Relationship Diagram, before starting to code the project.

Similarly, prior to styling the application with CSS, wireframes were drawn up to guide the process.

### The final product

The application was fully completed within the 6 day timeframe, and meets all the requirement specifications, as well as the further use cases identified in the planning stage.

The look of the finished application was achieved using a responsive Flexbox design.

Screenshots:

- [Homepage](documentation/home_page.png)

- [Animals Index](documentation/animals_index.png)

- [Owner Profile](documentation/owner_profile.png)

- [Matches Page](documentation/matches_page.png)

- [New Owner Form](documentation/add_new_owner_form.png)


