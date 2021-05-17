using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

#nullable disable

namespace AniDAAPI.Models
{
    public partial class PAAMRAdbContext : DbContext
    {
        

        public PAAMRAdbContext(DbContextOptions<PAAMRAdbContext> options)
            : base(options)
        {
        }

        public virtual DbSet<ArrivalInfo> ArrivalInfos { get; set; }
        public virtual DbSet<BunkerInfo> BunkerInfos { get; set; }
        public virtual DbSet<CallLocDesc> CallLocDescs { get; set; }
        public virtual DbSet<CrewChange> CrewChanges { get; set; }
        public virtual DbSet<Ctmtran> Ctmtrans { get; set; }
        public virtual DbSet<ListVoyFile> ListVoyFiles { get; set; }
        public virtual DbSet<Sofmaster> Sofmasters { get; set; }
        public virtual DbSet<Softran> Softrans { get; set; }
        public virtual DbSet<UserDetail> UserDetails { get; set; }
        public virtual DbSet<VoyFileLookUp> VoyFileLookUps { get; set; }
        public virtual DbSet<ListBillActTrans> ListBillActTrans { get; set; }
        public virtual DbSet<ListDAActType> ListDAActType { get; set; }
        public virtual DbSet<ListVendors> ListVendors { get; set; }
        public virtual DbSet<CustPerson> CustPerson { get; set; }
        public virtual DbSet<Customer> Customer { get; set; }
        public virtual DbSet<CustPerShipLU> CustPerShipLU { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("Relational:Collation", "Latin1_General_CI_AI");

            modelBuilder.Entity<ArrivalInfo>(entity =>
            {
                entity.HasKey(e => e.ArrInfoId);

                entity.ToTable("ArrivalInfo");

                entity.Property(e => e.ArrInfoId).HasColumnName("ArrInfoID");

                entity.Property(e => e.CustQuoteMasterId).HasColumnName("CustQuoteMasterID");

                entity.Property(e => e.Fwrob)
                    .HasColumnType("decimal(10, 2)")
                    .HasColumnName("FWROB");

                entity.Property(e => e.GasOilRob)
                    .HasColumnType("decimal(10, 2)")
                    .HasColumnName("GasOilROB");

                entity.Property(e => e.Hforob)
                    .HasColumnType("decimal(10, 2)")
                    .HasColumnName("HFOROB");

                entity.Property(e => e.LastUpdatedDt)
                    .HasColumnType("smalldatetime")
                    .HasColumnName("LastUpdatedDT");

                entity.Property(e => e.LubRob)
                    .HasColumnType("decimal(10, 2)")
                    .HasColumnName("LubROB");

                entity.Property(e => e.Mdorob)
                    .HasColumnType("decimal(10, 2)")
                    .HasColumnName("MDOROB");

                entity.Property(e => e.MsgSent).HasDefaultValueSql("((0))");

                entity.Property(e => e.VslCallCondtn)
                    .HasMaxLength(50)
                    .UseCollation("SQL_Latin1_General_CP1_CI_AS");
            });

            modelBuilder.Entity<BunkerInfo>(entity =>
            {
                entity.ToTable("BunkerInfo");

                entity.Property(e => e.BunkerInfoId).HasColumnName("BunkerInfoID");

                entity.Property(e => e.CustQuoteMasterId).HasColumnName("CustQuoteMasterID");

                entity.Property(e => e.Fwrecd)
                    .HasColumnType("decimal(10, 2)")
                    .HasColumnName("FWRecd");

                entity.Property(e => e.GasOilRecd).HasColumnType("decimal(10, 2)");

                entity.Property(e => e.Hforecd)
                    .HasColumnType("decimal(10, 2)")
                    .HasColumnName("HFORecd");

                entity.Property(e => e.LastUpdatedDt)
                    .HasColumnType("smalldatetime")
                    .HasColumnName("LastUpdatedDT");

                entity.Property(e => e.Mdorecd)
                    .HasColumnType("decimal(10, 2)")
                    .HasColumnName("MDORecd");

                entity.Property(e => e.MsgSent).HasDefaultValueSql("((0))");
            });

            modelBuilder.Entity<CallLocDesc>(entity =>
            {
                entity.HasKey(e => e.CallLocId);

                entity.ToTable("CallLocDesc");

                entity.Property(e => e.CallLocId).HasColumnName("CallLocID");

                entity.Property(e => e.CallLocDesc1)
                    .HasMaxLength(50)
                    .HasColumnName("CallLocDesc");

                entity.Property(e => e.IsActive).HasDefaultValueSql("((1))");
            });

            modelBuilder.Entity<CrewChange>(entity =>
            {
                entity.ToTable("CrewChange");

                entity.Property(e => e.CrewChangeId).HasColumnName("CrewChangeID");

                entity.Property(e => e.CustQuoteMasterId).HasColumnName("CustQuoteMasterID");

                entity.Property(e => e.LastUpdatedDt)
                    .HasColumnType("smalldatetime")
                    .HasColumnName("LastUpdatedDT");

                entity.Property(e => e.SignOn).HasColumnName("SignOn");

                entity.Property(e => e.SignOff).HasColumnName("SignOff");
                entity.Property(e => e.Remarks)
                    .HasMaxLength(2000)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Ctmtran>(entity =>
            {
                entity.HasKey(e => e.CtmtransId);

                entity.ToTable("CTMTrans");

                entity.Property(e => e.CtmtransId).HasColumnName("CTMTransID");

                entity.Property(e => e.CtmamtReq)
                    .HasColumnType("decimal(9, 2)")
                    .HasColumnName("CTMAmtReq");

                entity.Property(e => e.Ctmcurrency)
                    .HasMaxLength(10)
                    .HasColumnName("CTMCurrency");

                entity.Property(e => e.CtmdelAmt)
                    .HasColumnType("decimal(9, 2)")
                    .HasColumnName("CTMDelAmt");

                entity.Property(e => e.Ctmdelivered).HasColumnName("CTMDelivered");

                entity.Property(e => e.CtmdeliveryDate)
                    .HasColumnType("smalldatetime")
                    .HasColumnName("CTMDeliveryDate");

                entity.Property(e => e.CtminfOps).HasColumnName("CTMinfOps");

                entity.Property(e => e.CustQuoteMasterId).HasColumnName("CustQuoteMasterID");

                entity.Property(e => e.LastUpdatedDt)
                    .HasColumnType("smalldatetime")
                    .HasColumnName("LastUpdatedDT");
            });

            modelBuilder.Entity<ListVoyFile>(entity =>
            {
                entity.HasKey(e => e.CustQuoteMasterId)
                    .HasName("PK_ListVoyFile");

                entity.Property(e => e.CustQuoteMasterId)
                    .ValueGeneratedNever()
                    .HasColumnName("CustQuoteMasterID");

                entity.Property(e => e.AgencyTypeDesc).HasMaxLength(250);

                entity.Property(e => e.CallLocId).HasColumnName("CallLocID");

                entity.Property(e => e.CcemailAdd)
                    .HasMaxLength(2000)
                    .HasColumnName("CCEmailAdd")
                    .UseCollation("SQL_Latin1_General_CP1_CI_AS");

                entity.Property(e => e.ClosedVoyage).HasDefaultValueSql("((0))");

                entity.Property(e => e.CustShipFlag)
                    .HasMaxLength(50)
                    .UseCollation("SQL_Latin1_General_CP1_CI_AS");

                entity.Property(e => e.CustShipImo)
                    .HasMaxLength(50)
                    .HasColumnName("CustShipIMO")
                    .UseCollation("SQL_Latin1_General_CP1_CI_AS");

                entity.Property(e => e.CustShipName).HasMaxLength(250);

                entity.Property(e => e.CustVoyLastPort)
                    .HasMaxLength(250)
                    .UseCollation("SQL_Latin1_General_CP1_CI_AS");

                entity.Property(e => e.CustVoyNextPort)
                    .HasMaxLength(250)
                    .UseCollation("SQL_Latin1_General_CP1_CI_AS");

                entity.Property(e => e.CustomerId).HasColumnName("CustomerID");

                entity.Property(e => e.CustomerName).HasMaxLength(250);

                entity.Property(e => e.CustomerRef).HasMaxLength(250);

                entity.Property(e => e.Dareference)
                    .HasMaxLength(250)
                    .HasColumnName("DAReference")
                    .UseCollation("SQL_Latin1_General_CP1_CI_AS");

                entity.Property(e => e.EmailAdd)
                    .HasMaxLength(2000)
                    .UseCollation("SQL_Latin1_General_CP1_CI_AS");

                entity.Property(e => e.LastUpdatedDt)
                    .HasColumnType("smalldatetime")
                    .HasColumnName("LastUpdatedDT");

                entity.Property(e => e.PurposeCall)
                    .HasMaxLength(250)
                    .UseCollation("SQL_Latin1_General_CP1_CI_AS");

                entity.Property(e => e.UserSoff)
                    .HasColumnName("UserSOFF")
                    .HasDefaultValueSql("((0))");

                entity.Property(e => e.UserSon)
                    .HasColumnName("UserSON")
                    .HasDefaultValueSql("((0))");

                entity.Property(e => e.VesselId).HasColumnName("VesselID");

                entity.Property(e => e.VslEta)
                    .HasColumnType("smalldatetime")
                    .HasColumnName("VslETA")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.VslEtd)
                    .HasColumnType("smalldatetime")
                    .HasColumnName("VslETD")
                    .HasDefaultValueSql("(getdate())");
            });

            modelBuilder.Entity<Sofmaster>(entity =>
            {
                entity.ToTable("SOFMaster");

                entity.Property(e => e.SofmasterId).HasColumnName("SOFMasterID");

                entity.Property(e => e.Softype).HasColumnName("SOFType");
            });

            modelBuilder.Entity<Softran>(entity =>
            {
                entity.HasKey(e => e.SoftransId);

                entity.ToTable("SOFTrans");

                entity.Property(e => e.SoftransId).HasColumnName("SOFTransID");

                entity.Property(e => e.CustQuoteMasterId).HasColumnName("CustQuoteMasterID");

                entity.Property(e => e.LastUpdatedDt)
                    .HasColumnType("smalldatetime")
                    .HasColumnName("LastUpdatedDT");

                entity.Property(e => e.SofmasterId).HasColumnName("SOFMasterID");

                entity.Property(e => e.SoftransDate)
                    .HasColumnType("smalldatetime")
                    .HasColumnName("SOFTransDate");

                entity.Property(e => e.SoftransRemarks).HasColumnName("SOFTRansRemarks");

                entity.HasOne(d => d.Sofmaster)
                    .WithMany(p => p.Softrans)
                    .HasForeignKey(d => d.SofmasterId)
                    .HasConstraintName("FK_SOFTrans_SOFMaster");
            });

            modelBuilder.Entity<UserDetail>(entity =>
            {
                entity.HasKey(e => e.UserId)
                    .HasName("PK__UserDeta__1788CCAC2B61671D");

                entity.Property(e => e.UserId).HasColumnName("UserID");

                entity.Property(e => e.DeviceId)
                    .HasMaxLength(50)
                    .HasColumnName("DeviceID");

                entity.Property(e => e.EmailId)
                    .HasMaxLength(250)
                    .HasColumnName("EmailID");

                entity.Property(e => e.FullName)
                    .IsRequired()
                    .HasMaxLength(250);

                entity.Property(e => e.Imeino)
                    .HasMaxLength(50)
                    .HasColumnName("IMEINo");

                entity.Property(e => e.IsActive).HasDefaultValueSql("((0))");

                entity.Property(e => e.LogonName)
                    .IsRequired()
                    .HasMaxLength(250);

                entity.Property(e => e.MobileNumber).HasMaxLength(50);

                entity.Property(e => e.Password).HasMaxLength(250);

                entity.Property(e => e.UserShortName)
                    .IsRequired()
                    .HasMaxLength(50);
            });

            modelBuilder.Entity<VoyFileLookUp>(entity =>
            {
                entity.ToTable("VoyFileLookUp");

                //entity.HasKey(e => e.CustQuoteMasterId);
                entity.Property(e => e.VoyFileLookUpId).HasColumnName("VoyFileLookUpID");

                entity.Property(e => e.CustQuoteMasterId).HasColumnName("CustQuoteMasterID");

                entity.Property(e => e.UserId).HasColumnName("UserID");
            });





            modelBuilder.Entity<ListBillActTrans>(entity =>
            {
                entity.HasKey(e => e.CqmtransId);
                entity.ToTable("ListBillActTrans");

                entity.Property(e => e.CqmtransId).HasColumnName("CqmtransID");

                entity.Property(e => e.CqmtransTypeId).HasColumnName("CqmtransTypeID");

                entity.Property(e => e.CustQuoteMasterId).HasColumnName("CustQuoteMasterID");


                entity.Property(e => e.StatusId).HasColumnName("StatusID");

                entity.Property(e => e.CqmtransDate)
                    .HasColumnType("smalldatetime")
                    .HasColumnName("CqmtransDate");

                entity.Property(e => e.CqmtransTypeDesc).HasColumnName("CqmtransTypeDesc");


                entity.Property(e => e.Cqmpurpose).HasColumnName("Cqmpurpose");
                entity.Property(e => e.Qty).HasColumnName("Qty");
                entity.Property(e => e.UnitsDesc).HasColumnName("UnitsDesc");
                entity.Property(e => e.VendorId).HasColumnName("VendorID");
                entity.Property(e => e.VendorName).HasColumnName("VendorName");
                entity.Property(e => e.VendRef).HasColumnName("VendRef");
                entity.Property(e => e.TransStatus).HasColumnName("TransStatus");
                entity.HasOne(d => d.ListDAActType)
                    .WithMany(p => p.ListBillActTrans)
                    .HasForeignKey(d => d.CqmtransTypeId)
                    .HasConstraintName("FK_ListBillActTrans_ListDAActType");

            });


            modelBuilder.Entity<ListDAActType>(entity =>
            {
                entity.HasKey(e => e.CqmtransTypeId);
                entity.ToTable("ListDAActType");

                entity.Property(e => e.CqmtransTypeId).HasColumnName("CqmtransTypeID");

                entity.Property(e => e.CqmtransTypeDesc).HasColumnName("CqmtransTypeDesc");

                entity.Property(e => e.ZQuoteItemId).HasColumnName("zQuoteItemID");

                entity.Property(e => e.NUnitId).HasColumnName("nUnitID");

                entity.Property(e => e.UnitsDesc).HasColumnName("UnitsDesc");


            });


            modelBuilder.Entity<ListVendors>(entity =>
            {
                entity.HasKey(e => e.VendorId);
                entity.ToTable("ListVendors");

                entity.Property(e => e.VendorId).HasColumnName("VendorID");

                entity.Property(e => e.VendorName).HasColumnName("VendorName");

                entity.Property(e => e.VendRef).HasColumnName("VendRef");

                entity.Property(e => e.IsActive).HasColumnName("IsActive");

                entity.Property(e => e.VendTypeId).HasColumnName("VendTypeID");

                entity.Property(e => e.LastUpdatedBy).HasColumnName("LastUpdatedBy");

                entity.Property(e => e.LastUpdatedDT).HasColumnName("LastUpdatedDT");

            });

            modelBuilder.Entity<Customer>(entity =>
            {
                //entity.HasKey(e => e.CqmtransId);
                entity.ToTable("Customer");

                entity.Property(e => e.CustomerId).HasColumnName("CustomerID");

                entity.Property(e => e.CustomerName).HasColumnName("CustomerName");

                entity.Property(e => e.CustomerRef).HasColumnName("CustomerRef");

                entity.Property(e => e.isActive).HasDefaultValueSql("((1))");

                entity.Property(e => e.LastUpdatedBy).HasColumnName("LastUpdatedBy");

                entity.Property(e => e.LastUpdatedDt)
                     .HasColumnType("smalldatetime")
                     .HasColumnName("LastUpdatedDT");

            });

            modelBuilder.Entity<CustPerson>(entity =>
            {
                entity.HasKey(e => e.CustPersonId);
                entity.ToTable("CustPerson");

                entity.Property(e => e.CustPersonId).HasColumnName("CustPersonID");

                entity.Property(e => e.CustPersonFullName).HasColumnName("CustPersonFullName");

                entity.Property(e => e.CustPersonDesignation).HasColumnName("CustPersonDesignation");

                entity.Property(e => e.CustPersonTelMob).HasColumnName("CustPersonTelMob");

                entity.Property(e => e.CustPersonEmail).HasColumnName("CustPersonEmail");

                entity.Property(e => e.CustomerId).HasColumnName("CustomerID");

                entity.Property(e => e.CPerUName).HasColumnName("CPerUName");

                entity.Property(e => e.CPerPwd).HasColumnName("CPerPwd");

                entity.Property(e => e.isActive).HasDefaultValueSql("((1))");

                entity.Property(e => e.LastUpdatedBy).HasColumnName("LastUpdatedBy");

                entity.Property(e => e.LastUpdatedDt)
                     .HasColumnType("smalldatetime")
                     .HasColumnName("LastUpdatedDT");

            });

            modelBuilder.Entity<CustPerShipLU>(entity =>
            {
                entity.HasKey(e => e.CustPersonShipLUId);
                entity.ToTable("CustPerShipLU");

                entity.Property(e => e.CustPersonShipLUId).HasColumnName("CustPersonShipLUID");

                entity.Property(e => e.CustomerId).HasColumnName("CustomerID");

                entity.Property(e => e.CustPersonId).HasColumnName("CustPersonID");

                entity.Property(e => e.VesselId).HasColumnName("VesselID");

                entity.Property(e => e.LastUpdateBy).HasColumnName("LastUpdateBy");

                entity.Property(e => e.LastUpdatedDt).HasColumnName("LastUpdatedDT");

            });

            OnModelCreatingPartial(modelBuilder);
        }



        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
