// Ficheiro de validar  os registo do formulario de cadastramentos
const express = require('express');

const app = express();

const { body, validationResult } = require('express-validator');


// palilar palavra-passe
var passwordAceites = {
    "minLength": 8,
    "minLowercase": 1,
    "minUppercase": 1,
    "minNumbers": 1,
    "minSymbols": 1
};

app.use(express.json());
app.set('view engine', 'ejs');
app.use(express.urlencoded({ extended: true }));


app.get('/', (req, res) => {

    res.render('./views/registrar.ejs')
})


app.post('/registrar', [
    body('nome', "escreva o nome")
    .exists()
    .isLength({ min: 8 }),
    body('email', "email mal digitado")
    .exists()
    .isEmail(),
    body('password', "palavra passe não segura!!")
    .exists()
    .isStrongPassword(passwordAceites),
    body('funcao', "tem q ser um numero")
    .exists()
    .isNumeric(),
    body('perfil', "tem q ser um numero")
    .exists()
    .isNumeric()

], (req, res) => {
    /*const erros = validationResult(req)
    if (!erros.isEmpty()) {
        res.status(400).json({ erros: erros.array() })
        console.log(erros);
    } else {

    }*/

    const erros = validationResult(req)

    if (!erros.isEmpty()) {
        console.log(req.body);
        const valores = req.body
        const validacoes = erros.array()
        res.render('index', { validacoes: validacoes, valores: valores })
    } else {
        res.send('validações existente!')
    }

})

app.listen(3000, () => {
    console.log('acessa http://localhost:3000');
});