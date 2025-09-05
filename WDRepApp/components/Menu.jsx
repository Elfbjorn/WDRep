import React from 'react';
import menuConfig from '../config/menu.json';
import { useNavigate } from 'react-router-dom';
import './Menu.css';

const Menu = () => {
  const navigate = useNavigate();

  const handleMenuClick = (item) => {
    if (item.immediateLink) {
      // Pass other links in router state
      navigate(`/${item.immediateLink}`, {
        state: {
          nextLink: item.nextLink,
          cancelLink: item.cancelLink,
          previousLink: item.previousLink,
        },
      });
    }
  };

  return (
    <nav className="main-menu">
      {menuConfig.menu.map((section, idx) => (
        <div key={section.section || idx}>
          <div className="menu-section-header">
            <strong>{section.section}</strong>
          </div>
          <ul className="menu-section-list">
            {section.items.map((item, itemIdx) => (
              <li
                key={item.text}
                style={item.text === "Options" ? { marginTop: '75px' } : {}}
                className={item.immediateLink ? "menu-link-li" : "menu-link-disabled-li"}
              >
                {item.immediateLink ? (
                  <button
                    className="menu-link"
                    onClick={() => handleMenuClick(item)}
                  >
                    {item.text}
                  </button>
                ) : (
                  <span className="menu-link-disabled">{item.text}</span>
                )}
              </li>
            ))}
          </ul>
        </div>
      ))}
    </nav>
  );
};

export default Menu;