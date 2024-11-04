import mysql from 'mysql2/promise';

export const db = await mysql.createPool({
    host: 'localhost',
    user: 'pperso', 
    password: 'Swann!', // Remplace par ton mot de passe MySQL
    database: 'projetperso' // Remplace par le nom de ta base de données
});

export const secret = 'projetpersosecret';

//List des exports
export default { db, secret};
