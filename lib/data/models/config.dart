import 'dart:convert';

Config configFromJson(dynamic str) => Config.fromJson(str["data"]);

String configToJson(Config data) => json.encode(data.toJson());

class Config {
  About about;
  About footer;
  Home home;
  List<Project> projects;
  List<Experience> experiences;
  Home resume;
  About skills;
  Social social;

  Config({
    required this.about,
    required this.footer,
    required this.home,
    required this.projects,
    required this.experiences,
    required this.resume,
    required this.skills,
    required this.social,
  });

  factory Config.fromJson(Map<String, dynamic> json) => Config(
        about: About.fromJson(json["about"]),
        footer: About.fromJson(json["footer"]),
        home: Home.fromJson(json["home"]),
        projects: List<Project>.from(
            json["projects"].map((x) => Project.fromJson(x))),
        experiences: List<Experience>.from(
            json["experiences"].map((x) => Experience.fromJson(x))),
        resume: Home.fromJson(json["resume"]),
        skills: About.fromJson(json["skills"]),
        social: Social.fromJson(json["social"]),
      );

  Map<String, dynamic> toJson() => {
        "about": about.toJson(),
        "footer": footer.toJson(),
        "home": home.toJson(),
        "projects": List<dynamic>.from(projects.map((x) => x.toJson())),
        "experiences": List<dynamic>.from(experiences.map((x) => x.toJson())),
        "resume": resume.toJson(),
        "skills": skills.toJson(),
        "social": social.toJson(),
      };
}

class About {
  List<String> items;
  String title;

  About({
    required this.items,
    required this.title,
  });

  factory About.fromJson(Map<String, dynamic> json) => About(
        items: List<String>.from(json["items"].map((x) => x)),
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x)),
        "title": title,
      };
}

class Home {
  String content;
  String title;

  Home({
    required this.content,
    required this.title,
  });

  factory Home.fromJson(Map<String, dynamic> json) => Home(
        content: json["content"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "title": title,
      };
}

class Experience {
  String title;
  String company;
  String duration;
  String location;
  List<String> responsibilities;

  Experience({
    required this.title,
    required this.company,
    required this.duration,
    required this.location,
    required this.responsibilities,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        title: json["title"],
        company: json["company"],
        duration: json["duration"],
        location: json["location"],
        responsibilities:
            List<String>.from(json["responsibilities"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "company": company,
        "duration": duration,
        "location": location,
        "responsibilities": List<dynamic>.from(responsibilities.map((x) => x)),
      };
}

class Project {
  List<String> contents;
  String? githubLink;
  List<dynamic>? images;
  String? liveLink;
  List<String> technologies;
  String title;

  Project({
    required this.contents,
    this.githubLink,
    this.images,
    this.liveLink,
    required this.technologies,
    required this.title,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        contents: List<String>.from(json["contents"].map((x) => x)),
        githubLink: json["githubLink"],
        images: List<dynamic>.from(json["images"].map((x) => x)),
        liveLink: json["liveLink"],
        technologies: List<String>.from(json["technologies"].map((x) => x)),
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "contents": List<dynamic>.from(contents.map((x) => x)),
        "githubLink": githubLink,
        "images":
            images != null ? List<dynamic>.from(images!.map((x) => x)) : [],
        "liveLink": liveLink,
        "technologies": List<dynamic>.from(technologies.map((x) => x)),
        "title": title,
      };
}

class Social {
  List<Item> items;
  String title;

  Social({
    required this.items,
    required this.title,
  });

  factory Social.fromJson(Map<String, dynamic> json) => Social(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "title": title,
      };
}

class Item {
  String name;
  String url;

  Item({
    required this.name,
    required this.url,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
