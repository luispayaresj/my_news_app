import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; // Para manejar la selección y el formato de la fecha
import 'package:my_news_app/blocs/news_bloc.dart';
import 'package:my_news_app/blocs/news_event.dart';
import 'package:my_news_app/models/category.dart';
import 'package:my_news_app/models/news.dart';
import 'package:my_news_app/repositories/news_repository.dart';


class NewsForm extends StatefulWidget {
  

  NewsForm({super.key,  this.news});

  final News? news;
  
  @override
  _NewsFormState createState() => _NewsFormState();
}

class _NewsFormState extends State<NewsForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  Category _selectedCategory = Category(id: "tecnology", name: "Tecnology");

  // Lista de categorías (puedes ajustarla a tus necesidades)
  final List<Category> categories = NewsRepository().getCategories();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newNews = News(
        title: _titleController.text,
        description: _descriptionController.text,
        date: _selectedDate,
        imageUrl: _imageUrlController.text,
        categoryId: _selectedCategory.id,
      );
      
      widget.news != null ? BlocProvider.of<NewsBloc>(context).add(UpdateNews(widget.news!,newNews)) : BlocProvider.of<NewsBloc>(context).add(AddNews(newNews));
      Navigator.of(context).pop();
    }
  }

  void _presentDatePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  void initState() {
    if(widget.news != null){

      _titleController.text = widget.news!.title;
      _descriptionController.text =  widget.news!.description;
      _imageUrlController.text =  widget.news!.imageUrl;
      _selectedCategory = categories.firstWhere((element)=> element.id == widget.news?.categoryId);
      _selectedDate = widget.news!.date;

    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     News? news = widget.news;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _imageUrlController,
              decoration: InputDecoration(labelText: 'Image URL'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an image URL';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Date: ${DateFormat.yMd().format(_selectedDate)}',
                  ),
                ),
                TextButton(
                  onPressed: _presentDatePicker,
                  child: Text('Select Date'),
                ),
              ],
            ),

            news != null ? 

            DropdownButtonFormField<Category>(
              value: _selectedCategory ,
              decoration: InputDecoration(labelText: 'Category'),
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
            )
            :

          DropdownButtonFormField<Category>(
              
              decoration: InputDecoration(labelText: 'Category'),
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }
}
