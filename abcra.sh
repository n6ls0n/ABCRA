cd ..

echo Please enter a name for a project.
read -p 'Project Name: ' foldername

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
    "presets": ["@babel/preset-env","@babel/preset-react"]
}" >> .babelrc

echo "
Add these two lines under the scripts tag in package.json. The syntax is simliar to JSON so there should be a comma  after every line except the last.
\"start\": \"webpack-dev-server .\",
\"build\": \"webpack .\"
" 
