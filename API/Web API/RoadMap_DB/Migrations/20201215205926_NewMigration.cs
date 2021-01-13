using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace RoadMap_DB.Migrations
{
    public partial class NewMigration : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "department",
                columns: table => new
                {
                    dept_id = table.Column<int>(nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    dept_name = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_department", x => x.dept_id);
                });

            migrationBuilder.CreateTable(
                name: "location",
                columns: table => new
                {
                    location_id = table.Column<int>(nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    location_name = table.Column<string>(nullable: true),
                    lat_value = table.Column<double>(nullable: false),
                    lng_value = table.Column<double>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_location", x => x.location_id);
                });

            migrationBuilder.CreateTable(
                name: "user",
                columns: table => new
                {
                    id = table.Column<int>(nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    name = table.Column<string>(nullable: false),
                    email = table.Column<string>(nullable: true),
                    type = table.Column<string>(nullable: true),
                    faculty = table.Column<string>(nullable: true),
                    pwd = table.Column<string>(maxLength: 30, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_user", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "entrance",
                columns: table => new
                {
                    entrance_id = table.Column<int>(nullable: false),
                    e_location_id = table.Column<int>(nullable: false),
                    e_dept_id = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_entrance", x => new { x.entrance_id, x.e_location_id });
                    table.ForeignKey(
                        name: "FK_entrance_department_e_dept_id",
                        column: x => x.e_dept_id,
                        principalTable: "department",
                        principalColumn: "dept_id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_entrance_location_e_location_id",
                        column: x => x.e_location_id,
                        principalTable: "location",
                        principalColumn: "location_id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "floor",
                columns: table => new
                {
                    id = table.Column<int>(nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    floor_id = table.Column<int>(nullable: false),
                    f_location_id = table.Column<int>(nullable: false),
                    f_dept_id = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_floor", x => x.id);
                    table.ForeignKey(
                        name: "FK_floor_department_f_dept_id",
                        column: x => x.f_dept_id,
                        principalTable: "department",
                        principalColumn: "dept_id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_floor_location_f_location_id",
                        column: x => x.f_location_id,
                        principalTable: "location",
                        principalColumn: "location_id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "foot_route",
                columns: table => new
                {
                    f_route_id = table.Column<int>(nullable: false),
                    f_location_id = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_foot_route", x => new { x.f_route_id, x.f_location_id });
                    table.ForeignKey(
                        name: "FK_foot_route_location_f_location_id",
                        column: x => x.f_location_id,
                        principalTable: "location",
                        principalColumn: "location_id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "inner_route",
                columns: table => new
                {
                    in_route_id = table.Column<int>(nullable: false),
                    i_location_id = table.Column<int>(nullable: false),
                    i_dept_id = table.Column<int>(nullable: false),
                    i_floor_id = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_inner_route", x => new { x.in_route_id, x.i_location_id });
                    table.ForeignKey(
                        name: "FK_inner_route_department_i_dept_id",
                        column: x => x.i_dept_id,
                        principalTable: "department",
                        principalColumn: "dept_id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_inner_route_location_i_location_id",
                        column: x => x.i_location_id,
                        principalTable: "location",
                        principalColumn: "location_id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "place",
                columns: table => new
                {
                    place_id = table.Column<int>(nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    p_location_id = table.Column<int>(nullable: false),
                    p_dept_id = table.Column<int>(nullable: false),
                    p_floor_id = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_place", x => x.place_id);
                    table.ForeignKey(
                        name: "FK_place_department_p_dept_id",
                        column: x => x.p_dept_id,
                        principalTable: "department",
                        principalColumn: "dept_id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_place_location_p_location_id",
                        column: x => x.p_location_id,
                        principalTable: "location",
                        principalColumn: "location_id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "vehicle_route",
                columns: table => new
                {
                    v_route_id = table.Column<int>(nullable: false),
                    v_location_id = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_vehicle_route", x => new { x.v_route_id, x.v_location_id });
                    table.ForeignKey(
                        name: "FK_vehicle_route_location_v_location_id",
                        column: x => x.v_location_id,
                        principalTable: "location",
                        principalColumn: "location_id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "vertext_location",
                columns: table => new
                {
                    id = table.Column<int>(nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    graph_No = table.Column<int>(nullable: false),
                    vertex_No = table.Column<int>(nullable: false),
                    location_id = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_vertext_location", x => x.id);
                    table.ForeignKey(
                        name: "FK_vertext_location_location_location_id",
                        column: x => x.location_id,
                        principalTable: "location",
                        principalColumn: "location_id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "user_privilage",
                columns: table => new
                {
                    id = table.Column<int>(nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    user1_id = table.Column<int>(nullable: false),
                    user2_id = table.Column<int>(nullable: false),
                    status = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_user_privilage", x => x.id);
                    table.ForeignKey(
                        name: "FK_user_privilage_user_user1_id",
                        column: x => x.user1_id,
                        principalTable: "user",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_user_privilage_user_user2_id",
                        column: x => x.user2_id,
                        principalTable: "user",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_entrance_e_dept_id",
                table: "entrance",
                column: "e_dept_id");

            migrationBuilder.CreateIndex(
                name: "IX_entrance_e_location_id",
                table: "entrance",
                column: "e_location_id");

            migrationBuilder.CreateIndex(
                name: "IX_floor_f_dept_id",
                table: "floor",
                column: "f_dept_id");

            migrationBuilder.CreateIndex(
                name: "IX_floor_f_location_id",
                table: "floor",
                column: "f_location_id");

            migrationBuilder.CreateIndex(
                name: "IX_foot_route_f_location_id",
                table: "foot_route",
                column: "f_location_id");

            migrationBuilder.CreateIndex(
                name: "IX_inner_route_i_dept_id",
                table: "inner_route",
                column: "i_dept_id");

            migrationBuilder.CreateIndex(
                name: "IX_inner_route_i_location_id",
                table: "inner_route",
                column: "i_location_id");

            migrationBuilder.CreateIndex(
                name: "IX_place_p_dept_id",
                table: "place",
                column: "p_dept_id");

            migrationBuilder.CreateIndex(
                name: "IX_place_p_location_id",
                table: "place",
                column: "p_location_id");

            migrationBuilder.CreateIndex(
                name: "IX_user_privilage_user1_id",
                table: "user_privilage",
                column: "user1_id");

            migrationBuilder.CreateIndex(
                name: "IX_user_privilage_user2_id",
                table: "user_privilage",
                column: "user2_id");

            migrationBuilder.CreateIndex(
                name: "IX_vehicle_route_v_location_id",
                table: "vehicle_route",
                column: "v_location_id");

            migrationBuilder.CreateIndex(
                name: "IX_vertext_location_location_id",
                table: "vertext_location",
                column: "location_id");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "entrance");

            migrationBuilder.DropTable(
                name: "floor");

            migrationBuilder.DropTable(
                name: "foot_route");

            migrationBuilder.DropTable(
                name: "inner_route");

            migrationBuilder.DropTable(
                name: "place");

            migrationBuilder.DropTable(
                name: "user_privilage");

            migrationBuilder.DropTable(
                name: "vehicle_route");

            migrationBuilder.DropTable(
                name: "vertext_location");

            migrationBuilder.DropTable(
                name: "department");

            migrationBuilder.DropTable(
                name: "user");

            migrationBuilder.DropTable(
                name: "location");
        }
    }
}
