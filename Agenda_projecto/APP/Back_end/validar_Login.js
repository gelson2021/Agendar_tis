const express = require('express')
    // const session = require('express-session')

var path = require('path');
const app = express();

app.engine('html', require('ejs').renderFile);
app.set('view engine', 'ejs');
app.use('/public', express.static(path.join(__dirname)));
app.use(express.json());
// app.use('/public', express.static(path.join(__dirname)));
// app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, '../views'));
// app.use(express.urlencoded({ extended: true }));

app.post('/', (req, res) => {

})

app.get('/', (req, res) => {
    // res.sendFile('view.login.ejs')
    res.render('login')
})

app.listen(3000, () => {
    console.log('servidor http://localhost:3000');
})