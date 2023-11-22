import CheckCircle from '@mui/icons-material/CheckCircle';
import { Button, ButtonProps } from '@mui/material';
import React from "react";

interface Props {
    border: string;
    color: string;
    children?: React.ReactNode;
    height: string;
    onClick: () => void;
    radius: string;
    width: string;
}

const Action-Button: React.FC<Props> = ({
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

export default Action-Button;