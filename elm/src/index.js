import './main.css';
import './masonry.css';
import './loader.css';
import { Main } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

//Main.embed(document.getElementById('root'));
Main.fullscreen({});

registerServiceWorker();
