using Microsoft.EntityFrameworkCore;
using RoadMap_DB.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Threading.Tasks;

namespace RoadMap_DB.Data
{
    public class ApplicationDBContext:DbContext
    {

        public ApplicationDBContext(DbContextOptions<ApplicationDBContext> options):base(options)
        {

        }

        protected override void OnModelCreating (ModelBuilder modelBuilder)
        {

            #region ENTRANCE 

            //Create FK for Entrance table => reference Location Table
            modelBuilder.Entity<Entrance>()
                .HasOne(l => l.Location)
                .WithMany(m => m.lentrance)
                .HasForeignKey(l => new { l.e_location_id });

            //Create FK Entrance Table => reference Department Table
            modelBuilder.Entity<Entrance>()
                .HasOne(d => d.department)
                .WithMany(m => m.dentrance)
                .HasForeignKey(d => d.e_dept_id);


            modelBuilder.Entity<Entrance>()
                .HasKey(e => new { e.entrance_id, e.e_location_id }); //Crete com: PK for entrance

            #endregion

            #region PLACE 

            //Create FK for Place Table => reference  location Table
            modelBuilder.Entity<Place>()
                .HasOne(l => l.location)
                .WithMany(m => m.lplaces)
                .HasForeignKey(l => l.p_location_id);

            //Create  FK for Place Table => referece Department Table
            modelBuilder.Entity<Place>()
                .HasOne(d => d.department)
                .WithMany(m => m.dplace)
                .HasForeignKey(d => d.p_dept_id);

            //  //Create Fk for Plce Table => reference Floor Table
            //modelBuilder.Entity<Place>()
            //    .HasOne(f => f.floor)
            //    .WithMany(m => m.fplace)
            //    .HasForeignKey(f => f.p_floor_id);

            modelBuilder.Entity<Place>()
                .HasKey(p => p.place_id);

            #endregion

            #region FLOOR 

            //Create FK Floor Table =>reference Location Table
            modelBuilder.Entity<Floor>()
                .HasOne(f => f.location)
                .WithMany(m => m.lfloors)
                .HasForeignKey(f=>f.f_location_id);

            //Create FK Floor Table =>reference department Table
            modelBuilder.Entity<Floor>()
                .HasOne(d=>d.department)
                .WithMany(m => m.dfloor)
                .HasForeignKey(d => d.f_dept_id);


            modelBuilder.Entity<Floor>()
                .HasKey(f => new {f.id }); //Create  PK  for Floor

            #endregion

            #region INNER ROUTE

            //Create FK for Inner route Table =>reference Location Table
            modelBuilder.Entity<Inner_route>()
                .HasOne(l => l.location)
                .WithMany(m => m.linner_Routes)
                .HasForeignKey(l => l.i_location_id);

            //Create FK for  Inner_route Table =>reference Department Table
            modelBuilder.Entity<Inner_route>()
                .HasOne(d => d.department)
                .WithMany(m => m.dinner_routes)
                .HasForeignKey(d => d.i_dept_id);

            //Create FK for Inner_route =>reference Floor Table
            //modelBuilder.Entity<Inner_route>()
            //    .HasOne(f => f.floor)
            //    .WithMany(m => m.finner_Routes)
            //    .HasForeignKey(f => f.i_floor_id);

            modelBuilder.Entity<Inner_route>()
                .HasKey(i => new { i.in_route_id, i.i_location_id }); //Create composite PK for Inner Route


            #endregion

            #region FOOT ROUTE

            //Create FK for Foot_Route Table =>reference Location Table
            modelBuilder.Entity<foot_route>()
                .HasOne(l => l.location)
                .WithMany(m => m.lf_route)
                .HasForeignKey(l => l.f_location_id);

            modelBuilder.Entity<foot_route>()
               .HasKey(fo => new { fo.f_route_id, fo.f_location_id }); //create com: PK for foot Route


            #endregion

            #region VEHICLE ROUTE

            modelBuilder.Entity<vehicle_route>()
                .HasOne(l => l.location)
                .WithMany(m => m.lv_route)
                .HasForeignKey(l => l.v_location_id);

            modelBuilder.Entity<vehicle_route>()
               .HasKey(v => new { v.v_route_id, v.v_location_id }); //create com :PK for vehicle routes


            #endregion

            #region VERTEX LOCATION

            modelBuilder.Entity<Vertext_Location>()
                .HasOne(l => l.location)
                .WithMany(m => m.lvertext_Locations)
                .HasForeignKey(l => l.location_id);
             
            #endregion

        }

        #region DB SET

        public DbSet<foot_route> foot_route { get; set; }
        public DbSet<vehicle_route> vehicle_route { get; set; }
        public DbSet<Inner_route> inner_route { get; set; }
        public DbSet<Vertext_Location> vertext_location { get; set; }
        public DbSet<Place> place { get; set; }
        public DbSet<Location> location { get; set; }
        public DbSet<Entrance> entrance { get; set; }
        public DbSet<User> user { get; set; }
        public DbSet<Floor> floor { get; set; }      
        public DbSet<User_privilage> user_privilage { get; set; }
        public DbSet<Department> department { get; set; }

        #endregion
    }
}
