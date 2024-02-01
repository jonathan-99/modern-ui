import { Button } from '@mui/material';
import React from "react";

interface ButtonProperties {
    border: string;
    color: string;
    children?: React.ReactNode;
    height: string;
    onClick: () => void;
    radius: string;
    width: string;
}

const ActionButton: React.FC<ButtonProperties> = ({
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

export default ActionButton;
