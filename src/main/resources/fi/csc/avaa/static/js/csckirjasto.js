const kv = '/';

function aikaparametritulostus(ennen, nyt) {
    return "?from=" + ennen.format().substr(0, 19).replace('T', '%20') + "&to=" + nyt.format().substr(0, 19).replace('T', '%20');
}

function tarkista(nyt) {
    if (nyt.second() > moment().second()) {
        return moment();
    }
    return nyt;
}

function taulu(table) {
    let asemataulu = table.split("_", 2);
    let asema = asemataulu[0];
    if (asemataulu[1] === undefined) {
        console.log(table + "Cann't handled");
        return table + "Cann't handled";
    }
    if ('HYY' == asema) {
        return 'hyytiälä' + taulu2(asemataulu[1]);
    } else if ('KUM' == asema) {
        return 'kumpula' + taulu2(asemataulu[1]);
    } else if ('VAR' == asema) {
        return 'värriö' + taulu2(asemataulu[1]);
    } else if ('PUI' == asema) {
        return 'puijo/' + asemataulu[1] +kv;
    } else if ('KVJ' == asema) {
        return 'kuivajärvi' + taulu2(asemataulu[1]);
    } else if ('SII1' == asema) {
        return 'siikaneva/1' + taulu2(asemataulu[1]);
    } else if ('SII2' == asema) {
        return 'siikaneva/2' + taulu2(asemataulu[1]);
    } else if ('TOR' == asema) {
        return 'torni' + taulu2(asemataulu[1]);
    } else if ('ERO' == asema) {
        return 'erottaja' + taulu2(asemataulu[1]);
    } else if ('DOME' == asema) {
        return 'dome' + taulu2(asemataulu[1]);
    } else {
        return "Asemaluettelo ei ole täydellinen"
    }
}

function taulu2(mittalaite) {
    if ('META' == mittalaite) {
        return kv + 'meta' + kv;
    } else if ('EDDY' == mittalaite) {
        return kv + 'eddy' + kv;
    } else if ('DMPS' == mittalaite) {
        return kv + 'dmps' + kv;
    } else if ('DMPST' == mittalaite) {
        return kv + 'dmps' + kv;
    } else if (mittalaite.startsWith('EDDY')) {
        return kv + 'eddy' + kv + mittalaite.substring(5) + kv;
    } else if ('AERO' == mittalaite) {
        return kv + 'aero' + kv;
    } else if ('APS' == mittalaite) {
        return kv + 'aps' + kv;
    } else if ('AUG_REA' == mittalaite) {
        return kv + 'augrea' + kv;
    } else if ('SLOW' == mittalaite) {
        return kv + 'slow' + kv;
    } else if ('TREE' == mittalaite) {
        return kv + 'tree' + kv;
    } else if ('HOURLY' == mittalaite) {
        return kv + 'hourly' + kv;
    } else if (mittalaite.startsWith('TREEFLOW')) {
        return kv + 'FLOW' + kv;
    } else return mittalaite;
}

function hauska(obj, string) {
    return obj[string];
}