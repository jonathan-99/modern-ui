import { createTheme as createThemeInstance } from '@material-ui/core/styles';



import { createTheme } from '@mui/material';

const commonTheme = {
  typography: {
    h1: {
      fontSize: '2rem',
    },
    h2: {
      fontSize: '1.5rem',
    },
    h3: {
      fontSize: '1.3rem',
    },
    h4: {
      fontSize: '1.1rem',
    },
  },
  palette: {
    primary: {
      main: '#523174',
      light: '#cfa1fd',
      dark: '#42275d',
    },
    secondary: {
      main: '#4a21ad',
      light: '#d8cfdf',
    },
  },
};

const theme = createTheme({
  ...commonTheme,
  components: {
    MuiTableRow: {
      styleOverrides: {
        root: {
          '&:nth-of-type(even)': {
            backgroundColor: 'rgba(0, 0, 0, 0.04)',
          },
        },
      },
    },
    MuiTableCell: {
      styleOverrides: {
        root: {
          paddingTop: '.2rem',
          paddingBottom: '.2rem',
        },
      },
    },
  },
});

export const themeInstance = createThemeInstance(commonTheme);

export default theme;