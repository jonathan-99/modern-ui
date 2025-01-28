const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin");

module.exports = {
  entry: "./index.tsx", // Entry point for your application
  output: {
    path: path.resolve(__dirname, "dist"), // Output directory
    filename: "bundle.js", // Output file name
    clean: true, // Clean the output directory before building
  },
  resolve: {
    extensions: [".tsx", ".ts", ".js"], // Resolve these extensions
  },
  module: {
    rules: [
      {
        test: /\.(ts|tsx)$/, // Use ts-loader for TypeScript/TSX files
        use: "ts-loader",
        exclude: /node_modules/,
      },
      {
        test: /\.css$/, // Handle CSS imports
        use: ["style-loader", "css-loader"],
      },
    ],
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: "./index.html", // Use your index.html as the template
    }),
  ],
  devServer: {
    static: {
      directory: path.join(__dirname, "dist"),
    },
    port: 3000, // Dev server port
    open: true, // Automatically open browser
    hot: true, // Enable hot module replacement
  },
  mode: "development", // Set the mode to development
};
