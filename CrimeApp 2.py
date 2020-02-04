import textwrap
import tkinter.messagebox as MessageBox
from datetime import datetime
from tkinter import *
from tkinter import ttk
from tkinter.ttk import Treeview
import pymysql


def wrap(string, lenght):
    return '\n'.join(textwrap.wrap(string, lenght))


def validatedate(date_text):
    try:
        d = datetime.strptime(date_text, '%Y-%m-%d')
        return False
    except ValueError:
        return True


def validatetime(time_text):
    try:
        t = datetime.strptime(time_text, '%H:%M:%S')
        return False
    except ValueError:
        return True


class App(Frame):
    cnx = ""

    def __init__(self, parent):
        Frame.__init__(self, parent)
        self.variable = ""
        self.searchby = Button()
        self.login(parent)
        self.tree = ""
        self.b_login = Button()
        self.searchbylist = ["All", "Date", "Crime Type", "Reporter", "Building Name"]  # Select

    # default value

    def login(self, parent):
        username = Label(parent, text="Username: ")
        username.pack()

        e_username = Entry()
        e_username.pack()

        password = Label(parent, text="Password: ")
        password.pack()

        e_password = Entry()
        e_password.pack()

        def cconnectwrap():
            user = e_username.get()
            passwrd = e_password.get()
            try:
                print(user)
                print(passwrd)
                App.cnx = pymysql.connect(host='localhost', user=user, password=passwrd,
                                          db='crime', charset='utf8mb4',
                                          cursorclass=pymysql.cursors.DictCursor)
                App.cnx.cursor()
                print(App.cnx)
                parent.destroy()
                self.homescreen()
            except pymysql.err.OperationalError:
                MessageBox.showinfo("Invalid", "Invalid Username or Password. Try Again")
                e_password.delete(0, 'end')
                e_username.delete(0, 'end')

        self.b_login = Button(parent, text="login", command=cconnectwrap)
        self.b_login.pack()

    def searchswitch(self, parent):
        self.searchby = self.variable.get()
        crimetypelist = []  # Select
        cur = App.cnx.cursor()
        cur.execute("SELECT type from crime_type")
        for row in cur.fetchall():
            crimetypelist.append(row)
        variable1 = StringVar(parent)
        variable1.set(crimetypelist[0])  # default value
        cur.close()

    def homescreen(self):
        parent = Tk()
        parent.geometry("600x300")
        title = Label(parent, text="Search By:")
        title.pack()
        self.variable = StringVar(parent)
        self.variable.set(self.searchbylist[0])

        d_searchBy = OptionMenu(parent, self.variable, *self.searchbylist)
        d_searchBy.pack()

        self.e_searchbyx = Entry(parent)
        self.e_searchbyx.pack()

        b_search = Button(parent, text="search", command=(lambda: self.view(parent)))
        b_search.pack()

        b_create = Button(parent, text="Report a New Crime", command=self.create)
        b_create.pack()

    entrydate = ""
    entrytime = ""
    entryreporter = ""
    entrybuildingname = ""
    entrystreet = ""
    entrycity = ""
    entryzipcode = ""
    entrystate = ""
    entrysuspect = ""
    entrycrimetype = ""
    entryresolution = ""
    entrynotes = ""

    def create(self):
        root3 = Tk()

        def createindbwrapper():
            print("empty")
            if len(e_state.get()) == 0 or len(e_street.get()) == 0 or len(
                    e_suspect.get()) == 0 or len(
                    e_time.get()) == 0 or len(e_notes.get()) == 0 \
                    or len(e_resolution.get()) == 0 or len(e_date.get()) == 0 or len(
                e_reporter.get()) == 0 or len(e_crimetype.get()) == 0 \
                    or len(e_buildingname.get()) == 0 or len(e_zipcode.get()) == 0 or len(
                e_city.get()) == 0:
                print("empty")
                MessageBox.showinfo("Invalid", "Must Fill All Fields")
            elif validatedate(e_date.get()):
                MessageBox.showinfo("Invalid", "Must enter a valid date")
            elif validatetime(e_time.get()):
                MessageBox.showinfo("Invalid", "Must enter a valid time")
            elif len(e_zipcode.get()) >= 5:
                MessageBox.showinfo("Invalid",
                                    "Must enter a valid zipcode")  # TODO:CHECK ZIP AND STATE ABREV
            else:
                createindb()

        def createindb():
            cursor = App.cnx.cursor()
            sql = """INSERT INTO report (location_id, crime_type, reporter_id, date, resolution, 
            notes, time, suspect_id) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"""

            query = "SELECT getAddressID(%s, %s, %s, %s)"
            cursor.execute(query, (e_state.get(), e_city.get(), e_street.get(), e_zipcode.get()))
            pk1 = cursor.fetchone()
            pk2 = list(pk1.values())
            address = pk2[0]
            App.cnx.commit()
            print(address)

            query = "SELECT getLocationID(%s, %s)"
            cursor.execute(query, (e_buildingname.get(), address))
            pk1 = cursor.fetchone()
            pk2 = list(pk1.values())
            buildingname = pk2[0]
            App.cnx.commit()

            query = "SELECT getCrimeTypeID(%s)"
            cursor.execute(query, e_crimetype.get())
            pk1 = cursor.fetchone()
            pk2 = list(pk1.values())
            crimetype = pk2[0]
            App.cnx.commit()

            query = "SELECT getReporterID(%s)"
            cursor.execute(query, e_reporter.get())
            pk1 = cursor.fetchone()
            pk2 = list(pk1.values())
            reporter = pk2[0]
            App.cnx.commit()

            date = e_date.get()

            resolution = e_resolution.get()

            notes = e_notes.get()

            time = e_time.get()

            query = "SELECT getSuspectID(%s)"
            cursor.execute(query, e_suspect.get())
            pk1 = cursor.fetchone()
            pk2 = list(pk1.values())
            suspect = pk2[0]
            App.cnx.commit()

            vals = ({buildingname}, {crimetype}, {reporter}, {date}, {resolution}, {notes},
                    {time}, {suspect})

            cursor.execute(sql, vals)
            App.cnx.commit()
            cursor.close()
            root3.destroy()

        l_date = Label(root3, text="Date (YYYY-MM-DD)")
        l_date.pack()
        e_date = Entry(root3)
        e_date.pack()
        e_date.insert(0, self.entrydate)

        l_time = Label(root3, text="Time (HH:MM:SS)")
        l_time.pack()
        e_time = Entry(root3)
        e_time.pack()
        e_time.insert(0, self.entrytime)

        l_reporter = Label(root3, text="Reporter")
        l_reporter.pack()
        e_reporter = Entry(root3)
        e_reporter.pack()
        e_reporter.insert(0, self.entryreporter)

        l_buildingname = Label(root3, text="Building Name")
        l_buildingname.pack()
        e_buildingname = Entry(root3)
        e_buildingname.pack()
        e_buildingname.insert(0, self.entrybuildingname)

        l_street = Label(root3, text="Street")
        l_street.pack()
        e_street = Entry(root3)
        e_street.pack()
        e_street.insert(0, self.entrystreet)

        l_city = Label(root3, text="City")
        l_city.pack()
        e_city = Entry(root3)
        e_city.pack()
        e_city.insert(0, self.entrycity)

        l_zipcode = Label(root3, text="Zipcode")
        l_zipcode.pack()
        e_zipcode = Entry(root3)
        e_zipcode.pack()
        e_zipcode.insert(0, self.entryzipcode)

        l_state = Label(root3, text="State Abbrev.")
        l_state.pack()
        e_state = Entry(root3)
        e_state.pack()
        e_state.insert(0, self.entrystate)

        l_suspect = Label(root3, text="Suspect")
        l_suspect.pack()
        e_suspect = Entry(root3)
        e_suspect.pack()
        e_suspect.insert(0, self.entrysuspect)

        l_crimetype = Label(root3, text="Crime Type")
        l_crimetype.pack()
        e_crimetype = Entry(root3)
        e_crimetype.pack()
        e_crimetype.insert(0, self.entrycrimetype)

        l_resolution = Label(root3, text="Resolution")
        l_resolution.pack()
        e_resolution = Entry(root3)
        e_resolution.pack()
        e_resolution.insert(0, self.entryresolution)

        l_notes = Label(root3, text="Notes")
        l_notes.pack()
        e_notes = Entry(root3)
        e_notes.pack()
        e_notes.insert(0, self.entrynotes)

        b_submit = Button(root3, text="Submit", command=createindbwrapper)
        b_submit.pack()

    def view(self, root5):

        self.searchswitch(root5)

        searchcategory = self.searchby
        searchtext = self.e_searchbyx.get()
        cursor = App.cnx.cursor()
        print(searchcategory)

        if searchcategory == "All":
            query = "SELECT * FROM report"
            cursor.execute(query)
        elif searchtext == "":
            MessageBox.showinfo("Invalid", "Enter a Search")
        elif validatedate(searchtext) and searchcategory == "Date":
            MessageBox.showinfo("Invalid", "Enter a Valid Date")
        elif searchcategory == "Crime Type":
            query = "SELECT getCrimeTypeID(%s)"
            cursor.execute(query, searchtext)
            pk1 = cursor.fetchone()
            pk2 = list(pk1.values())
            pk = pk2[0]
            print(pk)
            query = "SELECT * FROM report WHERE crime_type = %s"
            cursor.execute(query, pk)
        elif searchcategory == "Building Name":
            query = "SELECT location_id FROM location WHERE building_name = %s"
            cursor.execute(query, searchtext)
            pk1 = cursor.fetchone()
            pk2 = list(pk1.values())
            pk = pk2[0]
            query = "SELECT * FROM report WHERE location_id = %s"
            cursor.execute(query, pk)
        elif searchcategory == "Date":
            query = "SELECT * FROM report WHERE date = %s"
            cursor.execute(query, searchtext)
        elif searchcategory == "Reporter":
            query = "SELECT getReporterID(%s)"
            cursor.execute(query, searchtext)
            pk1 = cursor.fetchone()
            pk2 = list(pk1.values())
            pk = pk2[0]
            print(pk)
            query = "SELECT * FROM report WHERE reporter_id = %s"
            cursor.execute(query, pk)

        def create_window(root2):

            def update():

                curItem = self.tree.focus()
                selected_item = self.tree.selection()[0]  ## get selected item
                curAddy = ""
                curAddy2 = ""
                for child in self.tree.get_children(curItem):
                    curAddy = child
                for child in self.tree.get_children(selected_item):
                    curAddy2 = child
                prik = (self.tree.item(curItem).get("values")[0])
                self.entrydate = (self.tree.item(curItem).get("values")[1])
                self.entrytime = (self.tree.item(curItem).get("values")[2])
                self.entryreporter = (self.tree.item(curItem).get("values")[3])
                self.entrybuildingname = (self.tree.item(curItem).get("values")[4])
                self.entrycrimetype = (self.tree.item(curItem).get("values")[5])
                self.entrysuspect = (self.tree.item(curItem).get("values")[6])
                self.entryresolution = (self.tree.item(curItem).get("values")[7])
                self.entrynotes = (self.tree.item(curItem).get("values")[8])
                self.entrystreet = (self.tree.item(child)).get("values")[3]
                self.entrycity = (self.tree.item(child)).get("values")[4]
                self.entrystate = (self.tree.item(child)).get("values")[5]
                self.entryzipcode = (self.tree.item(child)).get("values")[6]

                self.tree.item(selected_item,
                               values=(prik, self.entrydate, self.entrytime, self.entryreporter,
                                       self.entrybuildingname, self.entrycrimetype,
                                       self.entrysuspect, self.entryresolution, self.entrynotes))
                self.tree.item(curAddy2,
                               values=(" ", " ", "Address: ", self.entrystreet, self.entrycity,
                                       self.entrystate, self.entryzipcode))
                self.create()

                self.entrydate = ""
                self.entrytime = ""
                self.entryreporter = ""
                self.entrybuildingname = ""
                self.entrystreet = ""
                self.entrycity = ""
                self.entryzipcode = ""
                self.entrystate = ""
                self.entrysuspect = ""
                self.entrycrimetype = ""
                self.entryresolution = ""
                self.entrynotes = ""

                query = "CALL crime.delete_report(%s);"
                cursor.execute(query, prik)
                self.cnx.commit()

            def delete():
                try:
                    curItem = self.tree.focus()
                    prik = (self.tree.item(curItem).get("values")[0])
                    selected_item = self.tree.selection()[0]  ## get selected item
                    self.tree.delete(selected_item)
                    if prik in lreportid:
                        query4 = "CALL crime.delete_report(%s);"
                        cursor.execute(query4, prik)
                        self.cnx.commit()
                except IndexError:
                    print("uu")

            b_delete = Button(root2, text="Delete", command=delete)
            b_delete.pack()

            b_update = Button(root2, text="Update", command=update)
            b_update.pack()

            bikesstolen = "SELECT MAX(stolen_so_far) FROM bikes_stolen"
            cursor.execute(bikesstolen)
            disp = cursor.fetchone()
            display = str(disp.get("MAX(stolen_so_far)"))
            t = "Bikes Stolen So Far: " + display
            l_bikes = Label(root2, text=t)
            l_bikes.pack()

            self.tree = Treeview(root2)
            style = ttk.Style(root2)
            style.configure('Treeview', rowheight=130)
            self.tree['show'] = 'headings'
            self.tree["columns"] = ("1", "2", "3", "4", "5", "6",
                                    "7", "8", "9")
            self.tree.column("1", width=30)
            self.tree.column("2", width=100)
            self.tree.column("3", width=70)
            self.tree.column("4", width=150)
            self.tree.column("5", width=150)
            self.tree.column("6", width=100)
            self.tree.column("7", width=150)
            self.tree.column("8", width=250)
            self.tree.column("9", width=300)

            self.tree.heading("1", text="Report ID")
            self.tree.heading("2", text="Date")
            self.tree.heading("3", text="Time")
            self.tree.heading("4", text="Reporter")
            self.tree.heading("5", text="Building Name")
            self.tree.heading("6", text="Crime Type")
            self.tree.heading("7", text="Suspect")
            self.tree.heading("8", text="Resolution")
            self.tree.heading("9", text="Notes")

            i = 0
            while i < numrows:
                a = self.tree.insert("", lreportid[i],
                                     values=(lreportid[i], ldate[i], ltime[i], lreporter[i],
                                             lbuildingname[i], lcrimetype[i],
                                             lsuspect[i], lresolution[i], wrap(lnotes[i], 40)))

                valuedat = lstreet[i] + " " + lcity[i] + ", " + lstate[i] + " " + lzipcode[i]
                self.tree.insert(a, lreportid[i], values=(
                " ", " ", "Address: ", lstreet[i], lcity[i], lstate[i], lzipcode[i]))
                i += 1
            self.tree.pack()

        if (searchtext != "" or searchcategory == "All") or (searchcategory == "Date" and
                                                             validatedate(searchtext)):  # TODO:wlkj
            data = cursor.fetchall()
            numrows = 0
            lreportid = []
            query1 = "SELECT building_name FROM location WHERE location_id = %s"
            lbuildingname = []
            query2 = "SELECT type FROM crime_type WHERE crime_type_id = %s"
            lcrimetype = []
            ldate = []
            ltime = []
            lresolution = []
            lnotes = []
            query3 = "SELECT suspect_desc FROM suspect WHERE suspect_id = %s"
            lsuspect = []
            query4 = "SELECT reporter_description FROM reporter WHERE reporter_id = %s"
            lreporter = []

            query5 = "SELECT state FROM address JOIN location ON location.address = " \
                     "address.address_id WHERE location_id = %s"
            lstate = []

            query6 = "SELECT city FROM address JOIN location ON location.address = " \
                     "address.address_id WHERE location_id = %s"
            lcity = []

            query7 = "SELECT street FROM address JOIN location ON location.address = " \
                     "address.address_id WHERE location_id = %s"
            lstreet = []

            query8 = "SELECT zipcode FROM address JOIN location ON location.address = " \
                     "address.address_id WHERE location_id = %s"
            lzipcode = []

            for row in data:
                print(row)
                lreportid.insert(numrows, row.get('report_id'))

                print(row.get('location_id'))
                cursor.execute(query1, row.get('location_id'))
                buildingname = cursor.fetchone()
                print(buildingname)
                lbuildingname.insert(numrows, buildingname.get("building_name"))

                cursor.execute(query2, row.get('crime_type'))
                crimetype = cursor.fetchone()

                lcrimetype.insert(numrows, crimetype.get("type"))

                ldate.insert(numrows, row.get('date'))

                ltime.insert(numrows, row.get('time'))

                lresolution.insert(numrows, row.get('resolution'))

                lnotes.insert(numrows, row.get('notes'))

                cursor.execute(query3, row.get('suspect_id'))
                suspect = cursor.fetchone()
                lsuspect.insert(numrows, suspect.get("suspect_desc"))

                cursor.execute(query4, row.get('reporter_id'))
                reporter = cursor.fetchone()
                lreporter.insert(numrows, reporter.get("reporter_description"))

                cursor.execute(query5, row.get('location_id'))
                state = cursor.fetchone()
                lstate.insert(numrows, state.get("state"))

                cursor.execute(query6, row.get('location_id'))
                city = cursor.fetchone()
                lcity.insert(numrows, city.get("city"))

                cursor.execute(query7, row.get('location_id'))
                street = cursor.fetchone()
                lstreet.insert(numrows, street.get("street"))

                cursor.execute(query8, row.get('location_id'))
                zipcode = cursor.fetchone()
                lzipcode.insert(numrows, zipcode.get("zipcode"))
                numrows += 1

            root2 = Tk()
            root2.geometry("1500x1000")

            create_window(root2)


def main():
    root = Tk()
    root.geometry("600x300")
    root.title("Home Screen")
    App(root)
    root.mainloop()


if __name__ == "__main__":
    main()
