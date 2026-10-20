program GamePetualangan;
uses crt;

var
  pilihanMenu, pilihanUlang : char;
  pilihanClass, pilihanAksi : integer;
  namaClass, namaMusuh       : string;
  
  // Stat Karakter & Musuh 
  playerHP, maxHP, playerDmg, potion : integer;
  musuhHP, musuhDmg                 : integer;
  
  // Kontrol Alur Game 
  wave, chance                      : integer;
  isBoss, kabur, gameOver           : boolean;
  
  // sistem level up dan chance crit dmg boss
  playerLevel, playerXP, maxXP, xpDidapat : integer;
  chanceHit, multiplier, playerTotalDmg   : integer;
  bossChance, bossTotalDmg                : integer;
  hitType                                 : string;

begin
  Randomize; 

  repeat
    clrscr;
    writeln('==================================================');
    writeln('       SURVIVAL QUEST: TERRAMOK    ');
    writeln('==================================================');
    writeln(' [P] Play Game');
    writeln(' [E] Exit');
    write(' Pilihan Anda (P/E): ');
    readln(pilihanMenu);

    if (pilihanMenu = 'p') or (pilihanMenu = 'P') then
    begin
      // SELEKSI CLASS KARAKTER 
      clrscr;
      writeln('=== PILIH CLASS KARAKTER ANDA ===');
      writeln('1. Ranger    (DMG Awal: 35 | HP: 450)');
      writeln('2. Mage      (DMG Awal: 50 | HP: 350)');
      writeln('3. Swordsman (DMG Awal: 25 | HP: 600)');
      writeln('4. Assassin  (DMG Awal: 60 | HP: 300)');
      write('Pilihan Class (1-4): ');
      readln(pilihanClass);

      case pilihanClass of
        1: begin
             namaClass := 'Ranger';
             maxHP := 450;
             playerDmg := 35;
           end;
        2: begin
             namaClass := 'Mage';
             maxHP := 350;
             playerDmg := 50;
           end;
        3: begin
             namaClass := 'Swordsman';
             maxHP := 600;
             playerDmg := 25;
           end;
        4: begin
             namaClass := 'Assassin';
             maxHP := 300;
             playerDmg := 60;
           end;
      else
        begin
          namaClass := 'Novice';
          maxHP := 400;
          playerDmg := 20;
        end;
      end;

      playerHP := maxHP;
      potion := 3;
      gameOver := false;
      playerLevel := 1;
      playerXP := 0;
      maxXP := 100;

      writeln;
      writeln('Anda memilih class: ', namaClass);
      writeln('Petualangan dimulai! Tekan Enter...');
      readln;

      // 3. GELOMBANG PERTANDINGAN 
      for wave := 1 to 3 do
      begin
        if gameOver then break; 

        repeat
          kabur := false;
          clrscr;
          
          { Penentuan Stat Musuh Biasa }
          namaMusuh := 'Demon ' + chr(48 + wave);
          musuhHP := 250 + (wave * 100); 
          musuhDmg := 15 + (wave * 10);

          writeln('--------------------------------------------------');
          writeln('GELOMBANG ', wave, ': ', namaMusuh, ' Muncul!');
          writeln('HP Musuh: ', musuhHP, ' | DMG Musuh: ', musuhDmg);
          writeln('--------------------------------------------------');
          readln;

          //4. SISTEM PERTARUNGAN 
          while (playerHP > 0) and (musuhHP > 0) do
          begin
            clrscr;
            writeln('==================================================');
            writeln(' Lv: ', playerLevel, ' | CLASS: ', namaClass, ' | HP: ', playerHP, '/', maxHP, ' | DMG: ', playerDmg);
            writeln(' XP: ', playerXP, '/', maxXP, ' | POTION: ', potion, ' buah');
            writeln(' MUSUH   : ', namaMusuh, ' | HP: ', musuhHP);
            writeln('==================================================');
            writeln('1. Attack (Serang)');
            writeln('2. Item   (Gunakan Potion +150 HP)');
            writeln('3. Run    (Melarikan Diri & Ulang Gelombang)');
            write('Pilih Aksi (1-3): ');
            readln(pilihanAksi);

            case pilihanAksi of
              1: begin
                   { Aksi Attack }
                   writeln;
                   writeln('>> Anda menyerang ', namaMusuh, ' sebesar ', playerDmg, ' DMG!');
                   musuhHP := musuhHP - playerDmg;
                   
                   { Damage pemain naik setiap kali menyerang }
                   playerDmg := playerDmg + 10;

                   if musuhHP > 0 then
                   begin
                     writeln('>> ', namaMusuh, ' menyerang balik sebesar ', musuhDmg, ' DMG!');
                     playerHP := playerHP - musuhDmg;
                   end;
                 end;

              2: begin
                   { Aksi Item }
                   writeln;
                   if potion <= 0 then
                   begin
                     writeln('>> Potion Anda sudah habis!');
                     readln;
                     continue; 
                   end
                   else
                   begin
                     dec(potion);
                     playerHP := playerHP + 150;
                     if playerHP > maxHP then playerHP := maxHP;
                     writeln('>> Anda meminum Potion. HP dipulihkan menjadi ', playerHP, '!');
                   end;
                 end;

              3: begin
                   { Aksi Run }
                   writeln;
                   writeln('>> Anda melarikan diri! Kembali ke awal gelombang...');
                   kabur := true;
                   readln;
                   break; 
                 end;
            else
              begin
                writeln('>> Pilihan tidak valid!');
                readln;
                continue; 
              end;
            end;

            readln;
          end; 

          // Cek Kondisi Kekalahan 
          if playerHP <= 0 then
          begin
            clrscr;
            writeln('GAME OVER! Anda telah gugur di Gelombang ', wave, '.');
            gameOver := true;
            readln;
            break;
          end;
          if (musuhHP <= 0) and (not kabur) then
          begin
            xpDidapat := 50 + (wave * 20);
            playerXP := playerXP + xpDidapat;
            writeln;
            writeln('>> ', namaMusuh, ' KALAH! Anda mendapat ', xpDidapat, ' XP.');

            if playerXP >= maxXP then
            begin
              playerLevel := playerLevel + 1;
              playerXP := playerXP - maxXP; { Sisa XP dibawa ke level berikutnya }
              
              maxXP := maxXP + 50;        { Kebutuhan XP naik }
              maxHP := maxHP + 150;       { Max HP naik }
              playerHP := maxHP;          { Isi darah penuh }
              playerDmg := playerDmg + 20;{ Base DMG naik }

              writeln('>> *** LEVEL UP! *** Anda sekarang Level ', playerLevel, '!');
              writeln('>> HP Dipulihkan Penuh! Max HP: ', maxHP, ' | Base DMG: ', playerDmg);
            end;
            readln;
          end;
        until (not kabur) or gameOver; 
        if gameOver then break;

        // PERHITUNGAN SPANW CHANCE BOSS 
        chance := Random(100) + 1; 
        isBoss := false;

        //Chance 20% pada Wave 1 & 2, dan 100% pada Wave 3 
        if (wave = 3) then
          isBoss := true
        else if (chance <= 20) then
          isBoss := true;

        if isBoss then
        begin
          clrscr;
          writeln('**************************************************');
          writeln('          WARNING! CHANCE BOSS MUNCUL ');
          writeln('       RAJA IBLIS (BOSS) TELAH BANGKIT!          ');
          writeln('**************************************************');
          
          namaMusuh := 'Raja Iblis (BOSS)';
          musuhHP := 12000; 
          musuhDmg := 60;
          readln;

          while (playerHP > 0) and (musuhHP > 0) do
          begin
            clrscr;
            writeln('==================================================');
            writeln(' BOSS BATTLE | Lv: ', playerLevel, ' | HP: ', playerHP, '/', maxHP, ' | Base DMG: ', playerDmg);
            writeln(' BOSS HP    : ', musuhHP, ' / 12000');
            writeln('==================================================');
            writeln('1. Attack (Serang)'); 
            writeln('2. Item   (Gunakan Potion +200 HP)');
            writeln('3. Run    (Mundur dari Boss)');
            write('Pilih Aksi (1-3): ');
            readln(pilihanAksi);

            if pilihanAksi = 1 then
            begin
              { 1. RNG Pemain }
              chanceHit := Random(100) + 1;
              
              if chanceHit <= 50 then
              begin
                multiplier := 1 + Random(2); { 1x - 2x }
                playerTotalDmg := playerDmg * multiplier;
                writeln('>> Anda memberikan ', playerTotalDmg, ' DMG!'); 
              end
              else if chanceHit <= 80 then
              begin
                multiplier := 3 + Random(3); { 3x - 5x }
                playerTotalDmg := playerDmg * multiplier;
                writeln('>> [STRONG HIT] Anda memberikan ', playerTotalDmg, ' DMG!');
              end
              else
              begin
                multiplier := 6 + Random(5); { 6x - 10x (kisaran 8x) }
                
                playerTotalDmg := playerDmg * multiplier;

                writeln('>> [*** CRITICAL HIT! ***] Anda memberikan ', playerTotalDmg, ' DMG!');
              end;

              musuhHP := musuhHP - playerTotalDmg;
              playerDmg := playerDmg + 25;

              { 2. RNG Boss }
              if musuhHP > 0 then
              begin
                bossChance := Random(100) + 1;
                if bossChance <= 30 then
                begin
                  bossTotalDmg := musuhDmg * 2;
                  writeln('>> WARNING! BOSS menggunakan RAGE STRIKE! Memberikan ', bossTotalDmg, ' DMG!');
                end
                else
                begin
                  bossTotalDmg := musuhDmg;
                  writeln('>> BOSS menyerang balik sebesar ', bossTotalDmg, ' DMG!');
                end;
                playerHP := playerHP - bossTotalDmg;
              end;
            end
            else if pilihanAksi = 2 then
            begin
              if potion > 0 then
              begin
                dec(potion);
                playerHP := playerHP + 200;
                if playerHP > maxHP then playerHP := maxHP;
                writeln('>> HP dipulihkan! Sisa Potion: ', potion);
              end
              else
                writeln('>> Potion habis!');
            end
           else if pilihanAksi = 3 then
            begin
              if wave = 3 then
              begin 
                writeln(' Anda membalikkan badan untuk lari dari Raja Iblis...');
                writeln(' DASAR PENGECUT! Raja Iblis akhirnya menghancurkan Anda dari belakang...');
                writeln(' Terima kasih Pahlawan pengecut! berkatmu kota ini hancur ditangan mereka...');
                playerHP := 1; 
                gameOver := true; 
                readln;
                break;
              end   
              else
              begin
                writeln('>> Anda berhasil kabur dari kejaran Boss!');
                writeln('>> Melanjutkan perjalanan ke gelombang berikutnya...');
                readln;
                break;
              end;  
            end
            else     
            begin
              writeln('>> Pilihan tidak valid!');
            end;
            readln;
          end;

          if musuhHP <= 0 then
          begin
            clrscr;
            if wave = 3 then
            begin
              writeln('AMAZING! Anda berhasil mengalahkan BOSS!');
              writeln('Selamat, Anda telah menamatkan game ini!');
              readln;
              break;
            end
            else
            begin
              writeln('Boss berhasil dikalahkan! Perjalanan berlanjut...');
              readln;
            end;
          end
          else if playerHP <= 0 then
          begin
            writeln;
            writeln('Game Over...');
            writeln('Perjuanganmu tidak sia-sia. kerusakan kota hanya mencapai 90%...');
            gameOver := true;
            readln;
            break;
          end;
        end;

      end; 

    end;

  until (pilihanMenu = 'e') or (pilihanMenu = 'E');
end.
