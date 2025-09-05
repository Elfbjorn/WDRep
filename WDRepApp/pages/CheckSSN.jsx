import React from 'react';
import { useLocation } from 'react-router-dom';

const CheckSSN = () => {
    const { state } = useLocation();
    const { nextLink, cancelLink, previousLink } = state;

    const handleYesClick = () => {
        // Navigation to the next link
        if (nextLink) {
            window.location.href = nextLink;
        }
    };

    const handleCancelClick = () => {
        // Navigation to the cancel link
        if (cancelLink) {
            window.location.href = cancelLink;
        }
    };

    const handlePreviousClick = () => {
        // Navigation to the previous link
        if (previousLink) {
            window.location.href = previousLink;
        }
    };

    return (
        <div>
            <h1>Check SSN</h1>
            {/* Your existing UI code */}
            <button onClick={handleYesClick}>Yes</button>
            <button onClick={handleCancelClick}>Cancel</button>
            <button onClick={handlePreviousClick}>Previous</button>
        </div>
    );
};

export default CheckSSN;