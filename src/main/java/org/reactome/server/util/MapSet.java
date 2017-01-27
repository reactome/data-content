package org.reactome.server.util;

import java.io.Serializable;
import java.util.*;

/**
 * This mapset is implementing TreeSet
 *
 * @author Antonio Fabregat <fabregat@ebi.ac.uk>
 */
@SuppressWarnings("UnusedDeclaration")
public class MapSet<S,T> implements Serializable {

    protected Map<S, Set<T>> map = new TreeMap<>();

    public void add(S identifier, T elem){
        Set<T> aux = getOrCreate(identifier);
        aux.add(elem);
    }

    public void add(S identifier, Set<T> set){
        Set<T> aux = getOrCreate(identifier);
        aux.addAll(set);
    }

    public void add(S identifier, List<T> list){
        Set<T> aux = getOrCreate(identifier);
        aux.addAll(list);
    }

    public void addAll(org.reactome.server.interactors.util.MapSet<S,T> map){
        for (S s : map.keySet()) {
            this.add(s, map.getElements(s));
        }
    }

    public void clear(){
        map.clear();
    }

    public Set<T> getElements(S identifier){
        return map.get(identifier);
    }

    private Set<T> getOrCreate(S identifier){
        Set<T> set = map.get(identifier);
        if(set==null){
            set = new TreeSet<>();
            map.put(identifier, set);
        }
        return set;
    }

    public boolean isEmpty(){
        return map.isEmpty();
    }

    public Set<S> keySet(){
        return map.keySet();
    }

    public Set<T> remove(S key){
        return this.map.remove(key);
    }

    public boolean remove(S key, T elem) {
        return map.containsKey(key) && map.get(key).remove(elem);
    }

    public Set<T> values(){
        /**
         * The Original implementation implements HashSet.
         * Please keep this as a TreeSet.
         */
        Set<T> rtn = new TreeSet<>();
        for (S s : map.keySet()) {
            rtn.addAll(map.get(s));
        }
        return rtn;
    }
}