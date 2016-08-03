
package com.kendoui.taglib.gantt;


import com.kendoui.taglib.BaseTag;



import com.kendoui.taglib.GanttTag;




import javax.servlet.jsp.JspException;

@SuppressWarnings("serial")
public class RangeTag extends  BaseTag  /* interfaces */ /* interfaces */ {
    
    @Override
    public int doEndTag() throws JspException {
//>> doEndTag


        GanttTag parent = (GanttTag)findParentWithClass(GanttTag.class);


        parent.setRange(this);

//<< doEndTag

        return super.doEndTag();
    }

    @Override
    public void initialize() {
//>> initialize
//<< initialize

        super.initialize();
    }

    @Override
    public void destroy() {
//>> destroy
//<< destroy

        super.destroy();
    }

//>> Attributes

    public static String tagName() {
        return "gantt-range";
    }

    public java.util.Date getEnd() {
        return (java.util.Date)getProperty("end");
    }

    public void setEnd(java.util.Date value) {
        setProperty("end", value);
    }

    public java.util.Date getStart() {
        return (java.util.Date)getProperty("start");
    }

    public void setStart(java.util.Date value) {
        setProperty("start", value);
    }

//<< Attributes

}