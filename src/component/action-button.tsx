import CheckCircle from '@mui/icons-material/CheckCircle';
import { Button } from '@mui/material';
import * as React from "react";
import * as ReactDOM from "react-dom";

interface ButtonProperties {
    border: string;
    color: string;
    children?: React.ReactNode;
    height: string;
    onClick: () => void;
    radius: string;
    width: string;
}

const aButton: React.FC<ButtonProperties> = ({
        border,
        color,
        children,
        height,
        onClick,
        radius,
        width
    }) => {
  return (
    <Button
      onClick={onClick}
      style={{
        backgroundColor: color,
        border,
        borderRadius: radius,
        height,
        width
    }}
    >
    {children}
    </Button>
  );
};

export default aButton;