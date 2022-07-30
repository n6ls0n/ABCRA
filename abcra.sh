echo Please enter a name for a project.
read -p "Project Name[test]: " foldername
foldername=${foldername:-test}
echo Please enter the project save  location.
read -p 'Project Save Location[cwd]: ' folderloc
folderloc=${folderloc:-${PWD}}

cd $folderloc
mkdir $foldername
cd $foldername

npm init -y
npm install --save-dev @babel/core babel-loader @babel/cli @babel/preset-env @babel/preset-react
npm install --save-dev webpack webpack-cli webpack-dev-server
npm install --save-dev html-webpack-plugin
npm install react react-dom

mkdir public
touch public/index.html

mkdir src
touch src/App.js

touch index.js
touch .babelrc
touch webpack.config.js

echo "
const HtmlWebpackPlugin = require('html-webpack-plugin');
const path = require('path');

module.exports = {
  entry: './index.js',
  mode: 'development',
  output: {
    path: path.resolve(__dirname, './dist'),
    filename: 'index_bundle.js',
  },
  target: 'web',
  devServer: {
    port: '5000',
    static: {
      directory: path.join(__dirname, 'public')
},
    open: true,
    hot: true,
    liveReload: true,
  },
  resolve: {
    extensions: ['.js', '.jsx', '.json'],
  },
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/, 
        exclude: /node_modules/, 
        use: 'babel-loader', 
      },
    ],
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: path.join(__dirname, 'public', 'index.html')
    })
  ]
};
" >> webpack.config.js

echo "
{
   \"presets\": [\"@babel/preset-env\",\"@babel/preset-react\"]
}" >> .babelrc


echo "
<!DOCTYPE html>
<html lang=\"en\">
<head>
    <meta charset=\"UTF-8\">
    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
    <title>React App</title>
</head>
<body>
    <div id=\"root\"></div>
</body>
</html>
" >> public/index.html

echo "
import React from \"react\";

const App = () =>{
    return (
        <h1>
            Hello world! I am using React
        </h1>
    )
}

export default App" >> src/App.js

echo "
import React from 'react'
import  { createRoot }  from 'react-dom/client';
import App from './src/App.js'

const container = document.getElementById('root');
const root = createRoot(container);
root.render(<App/>);" >> index.js


echo "
*********************************************************************************************
Add these two lines under the scripts tag in package.json. The syntax is simliar to JSON so there should be a comma  after every line except the last.
\"start\": \"webpack-dev-server .\",
\"build\": \"webpack .\"
*********************************************************************************************
" 
