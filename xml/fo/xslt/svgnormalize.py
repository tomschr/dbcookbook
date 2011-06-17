#!/usr/bin/python

import sys
from lxml import etree # as et
import numpy as np
import re


def translate(tx,ty=0):
   return np.matrix("1 0 %s; 0 1 %s; 0 0 1" % (tx, ty))

def scale(sx, sy=None):
   if not sy:
      sy=sx
   return np.matrix("%s 0 0; 0 %s 0; 0 0 1" % (sx, sy))

def rotate(deg, point=None):
   s=np.math.sin(np.deg2rad(deg))
   c=np.math.cos(np.deg2rad(deg))
   
   def rot(deg):
      return np.matrix("%s %s 0; %s %s 0; 0 0 1" % (c, -s, s, c))   
   
   if isinstance(point, (type, list)):
      cx,cy=point
      t1=translate(cx,cy)
      return t1*rot(deg)*t.I
   else:
      return rot(deg)
   
   
def skewX(deg):
   t = np.math.tan(np.deg2rad(deg))
   return np.matrix("1 %s 0; 0 1 0; 0 0 1" % (t))

def skewY(deg):
   t = np.math.tan(np.deg2rad(deg))
   return np.matrix("1 0 0; %s 1 0; 0 0 1" % (t))

def svgmatrix(a, b, c, d, e, f):
   return np.matrix("%s %s %s; %s %s %s; 0 0 1" % (a, c, e, b, d, f))

def svgpoint(x,y):
   return np.matrix("%s %s 1" % (x,y))

class unit(object):
   __units={
      'mm':1, 
      'px':0.2822222,  # px/mm
      'pc':4.2333330,  # pc/mm
      'pt':0.35277775, # pt/mm
      'cm':10,         # cm/mm
      'in':25.3999980  # in/mm
   }
   
   _v=None
   _u=None
   # Original values and units
   _ov=None
   _ou=None
   
   def __init__(self, *obj):
      print "__init__:", obj
      if len(obj)==1 and isinstance(obj[0], (str, unicode)):
         m=re.search(r"(?P<value>[+-]?\d+[.]?\d*)(?P<unit>mm|px|pt|cm|in)?", obj[0])
         if not m:
            raise ValueError("Expected string with value and optional unit")
         self._ov, self._ou = m.groups()
         self._ov = float(self._ov)
         if not self.allowedUnit(self._ou):
            raise ValueError("Not supported unit '%s'" % self._u )
         # 
         self._v = self.__units[self._ou]*self._ov
         self._u = 'mm'
      
      elif len(obj)==1 and isinstance(obj[0], unit):
         self._v, self._u = obj.value, obj.unit
      
      elif len(obj)==2 and isinstance(obj[0], (int, float, str, unicode)) \
                       and isinstance(obj[1], (str, unicode)):
         self._ov, self._ou = float(obj[0]), obj[1]
         self._v, self._u =  self.__units[self._ou]*self._ov, "mm"
      else:
         raise ValueError("Unexpected type: %s" % type(obj))
   
   @property
   def value(self):
      return self._v
      
   @property
   def unit(self):
      return self._u
   
   @property
   def mm(self):
      return self.__unit[self._u]*self._u
   
   @property
   def cm(self):
      return self._v/self.__units['cm']
      
   @property
   def inch(self):
      return self._v/self.__units['in']
   
   @property
   def pt(self):
      return self._v/self.__units['pt']
      
   @property
   def px(self):
      return self._v/self.__units['px']
      
   @property
   def pc(self):
      return self._v/self.__units['pc']
   
   def __str__(self):
      return "%s%s" % (self._ov, self._ou)
   
   def __repr__(self):
      return "<Class Unit %s at 0x%X>" % (str(self), id(self))
   
   def allowedUnit(self, u):
      return u in self.__units.keys()
      
   def __add__(self, other):
      
      return unit(self._v+other.value, "mm")
      
   def __sub__(self, other):
      return unit(self._v-other.value, "mm")
   
   

def parse():
   
   parser = etree.XMLParser(ns_clean=True, 
                           load_dtd=False, 
                           dtd_validation=False,
                           no_network=True)

   root = etree.parse(sys.argv[1], parser)
   context = etree.iterwalk(root, events=("start",) )
   for _, e  in context:
      print("%s: %s" % (e.tag, e.attrib))
      print("transform:", e.xpath("ancestor-or-self::*/@transform") )
      if e.attrib.has_key("style"):
         # First split up the style attribute into attr:value
         style=e.attrib["style"].strip().split(";")
         # Remove any tailing ";"
         if style[-1] == "":
            style.pop()
         # Second split the attr:value into a tuple
         style=[ tuple(i.split(":")) for i in style]
         
         # Set all attributes 
         for attr, value in style:
            v=value
            # Skip any attributes who starts with "-inkscape"
            if attr.startswith("-inkscape"):
               continue
            if attr in ('fill', 'stroke'):
               v=v.replace(" ", "").lower()
               if v in ("#ffffff", "#fff", "rgb(255,255,255)", "rgb(100%,100%,100%)"):
                  v = "white"
               elif v in ("#000000", "#000", "rgb(0,0,0)", "rgb(0%,0%,0%)"):
                  v = "black"
            e.attrib[attr]=v
         
         del e.attrib["style"]
      
   # Save result tree
   print(etree.tostring(root))
   
if __name__=="__main__":
   #t1=translate(50,90)
   #r=rotate(-45)
   #t2=translate(130,160)
   #t3=translate(-10,-10)
   #v1=svgpoint(0,0)
   #v2=svgpoint(10,10)
   #print t1
   #print r
   #print t2
   #ctm=t1*r*t2
   #print ctm
   #print ctm.I
   #print "v2=",v2
   #print "t3=", t3
   #print "v2*t3=", v2*t3
   
   u1 = unit(1, "cm")
   u2 = unit("1cm")
   print u1, u2
   print u1.value, u1.inch
   print u1+u2