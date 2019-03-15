import RealmSwift

/// Repository base model
@objcMembers
class Repository: Object, Decodable {

    // MARK: Coding

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name = "name"
        case isPrivate = "private"
        case url = "html_url"
    }

    // MARK: Properties

    dynamic var identifier: Int = 0
    dynamic var name: String = ""
    dynamic var isPrivate: Bool = false
    dynamic var url: String = ""

    // MARK: Initialization

    convenience required init(from coder: Decoder) throws {
        self.init()

        let values = try coder.container(keyedBy: CodingKeys.self)

        identifier = try values.decode(Int.self, forKey: .identifier)
        name = try values.decode(String.self, forKey: .name)
        isPrivate = try values.decode(Bool.self, forKey: .isPrivate)
        url = try values.decode(String.self, forKey: .url)
    }

    override static func primaryKey() -> String? {
        return "identifier"
    }

}
