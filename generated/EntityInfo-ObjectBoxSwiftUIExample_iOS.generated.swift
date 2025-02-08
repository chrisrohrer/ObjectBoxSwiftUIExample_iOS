// Generated using the ObjectBox Swift Generator — https://objectbox.io
// DO NOT EDIT

// swiftlint:disable all
import ObjectBox
import Foundation

// MARK: - Entity metadata

extension Author: ObjectBox.Entity {}
extension Book: ObjectBox.Entity {}

extension Author: ObjectBox.__EntityRelatable {
    internal typealias EntityType = Author

    internal var _id: EntityId<Author> {
        return EntityId<Author>(self.id.value)
    }
}

extension Author: ObjectBox.EntityInspectable {
    internal typealias EntityBindingType = AuthorBinding

    /// Generated metadata used by ObjectBox to persist the entity.
    internal static var entityInfo = ObjectBox.EntityInfo(name: "Author", id: 1)

    internal static var entityBinding = EntityBindingType()

    fileprivate static func buildEntity(modelBuilder: ObjectBox.ModelBuilder) throws {
        let entityBuilder = try modelBuilder.entityBuilder(for: Author.self, id: 1, uid: 7771776810938251776)
        try entityBuilder.addProperty(name: "id", type: PropertyType.long, flags: [.id], id: 1, uid: 9115015145734164736)
        try entityBuilder.addProperty(name: "name", type: PropertyType.string, id: 2, uid: 574753341433828352)
        try entityBuilder.addProperty(name: "birthyear", type: PropertyType.long, id: 3, uid: 651261010468108800)

        try entityBuilder.lastProperty(id: 3, uid: 651261010468108800)
    }
}

extension Author {
    /// Generated entity property information.
    ///
    /// You may want to use this in queries to specify fetch conditions, for example:
    ///
    ///     box.query { Author.id == myId }
    internal static var id: Property<Author, Id, Id> { return Property<Author, Id, Id>(propertyId: 1, isPrimaryKey: true) }
    /// Generated entity property information.
    ///
    /// You may want to use this in queries to specify fetch conditions, for example:
    ///
    ///     box.query { Author.name.startsWith("X") }
    internal static var name: Property<Author, String, Void> { return Property<Author, String, Void>(propertyId: 2, isPrimaryKey: false) }
    /// Generated entity property information.
    ///
    /// You may want to use this in queries to specify fetch conditions, for example:
    ///
    ///     box.query { Author.birthyear > 1234 }
    internal static var birthyear: Property<Author, Int, Void> { return Property<Author, Int, Void>(propertyId: 3, isPrimaryKey: false) }
    /// Use `Author.books` to refer to this ToMany relation property in queries,
    /// like when using `QueryBuilder.and(property:, conditions:)`.

    internal static var books: ToManyProperty<Book> { return ToManyProperty(.valuePropertyId(4)) }


    fileprivate func __setId(identifier: ObjectBox.Id) {
        self.id = Id(identifier)
    }
}

extension ObjectBox.Property where E == Author {
    /// Generated entity property information.
    ///
    /// You may want to use this in queries to specify fetch conditions, for example:
    ///
    ///     box.query { .id == myId }

    internal static var id: Property<Author, Id, Id> { return Property<Author, Id, Id>(propertyId: 1, isPrimaryKey: true) }

    /// Generated entity property information.
    ///
    /// You may want to use this in queries to specify fetch conditions, for example:
    ///
    ///     box.query { .name.startsWith("X") }

    internal static var name: Property<Author, String, Void> { return Property<Author, String, Void>(propertyId: 2, isPrimaryKey: false) }

    /// Generated entity property information.
    ///
    /// You may want to use this in queries to specify fetch conditions, for example:
    ///
    ///     box.query { .birthyear > 1234 }

    internal static var birthyear: Property<Author, Int, Void> { return Property<Author, Int, Void>(propertyId: 3, isPrimaryKey: false) }

    /// Use `.books` to refer to this ToMany relation property in queries, like when using
    /// `QueryBuilder.and(property:, conditions:)`.

    internal static var books: ToManyProperty<Book> { return ToManyProperty(.valuePropertyId(4)) }

}


/// Generated service type to handle persisting and reading entity data. Exposed through `Author.EntityBindingType`.
internal class AuthorBinding: ObjectBox.EntityBinding {
    internal typealias EntityType = Author
    internal typealias IdType = Id

    internal required init() {}

    internal func generatorBindingVersion() -> Int { 1 }

    internal func setEntityIdUnlessStruct(of entity: EntityType, to entityId: ObjectBox.Id) {
        entity.__setId(identifier: entityId)
    }

    internal func entityId(of entity: EntityType) -> ObjectBox.Id {
        return entity.id.value
    }

    internal func collect(fromEntity entity: EntityType, id: ObjectBox.Id,
                                  propertyCollector: ObjectBox.FlatBufferBuilder, store: ObjectBox.Store) throws {
        let propertyOffset_name = propertyCollector.prepare(string: entity.name)

        propertyCollector.collect(id, at: 2 + 2 * 1)
        propertyCollector.collect(entity.birthyear, at: 2 + 2 * 3)
        propertyCollector.collect(dataOffset: propertyOffset_name, at: 2 + 2 * 2)
    }

    internal func postPut(fromEntity entity: EntityType, id: ObjectBox.Id, store: ObjectBox.Store) throws {
        if entityId(of: entity) == 0 {  // New object was put? Attach relations now that we have an ID.
            let books = ToMany<Book>.backlink(
                sourceBox: store.box(for: ToMany<Book>.ReferencedType.self),
                sourceProperty: ToMany<Book>.ReferencedType.author,
                targetId: EntityId<Author>(id.value))
            if !entity.books.isEmpty {
                books.replace(entity.books)
            }
            entity.books = books
            try entity.books.applyToDb()
        }
    }
    internal func createEntity(entityReader: ObjectBox.FlatBufferReader, store: ObjectBox.Store) -> EntityType {
        let entity = Author()

        entity.id = entityReader.read(at: 2 + 2 * 1)
        entity.name = entityReader.read(at: 2 + 2 * 2)
        entity.birthyear = entityReader.read(at: 2 + 2 * 3)

        entity.books = ToMany<Book>.backlink(
            sourceBox: store.box(for: ToMany<Book>.ReferencedType.self),
            sourceProperty: ToMany<Book>.ReferencedType.author,
            targetId: EntityId<Author>(entity.id.value))
        return entity
    }
}



extension Book: ObjectBox.__EntityRelatable {
    internal typealias EntityType = Book

    internal var _id: EntityId<Book> {
        return EntityId<Book>(self.id.value)
    }
}

extension Book: ObjectBox.EntityInspectable {
    internal typealias EntityBindingType = BookBinding

    /// Generated metadata used by ObjectBox to persist the entity.
    internal static var entityInfo = ObjectBox.EntityInfo(name: "Book", id: 2)

    internal static var entityBinding = EntityBindingType()

    fileprivate static func buildEntity(modelBuilder: ObjectBox.ModelBuilder) throws {
        let entityBuilder = try modelBuilder.entityBuilder(for: Book.self, id: 2, uid: 2463130310576128256)
        try entityBuilder.addProperty(name: "id", type: PropertyType.long, flags: [.id], id: 1, uid: 8877933408472149504)
        try entityBuilder.addProperty(name: "title", type: PropertyType.string, id: 2, uid: 4910967368332728576)
        try entityBuilder.addProperty(name: "pages", type: PropertyType.long, id: 3, uid: 2191607194936706048)
        try entityBuilder.addProperty(name: "notes", type: PropertyType.string, id: 5, uid: 3972041113281408000)
        try entityBuilder.addToOneRelation(name: "author", targetEntityInfo: ToOne<Author>.Target.entityInfo, flags: [.indexed, .indexPartialSkipZero], id: 4, uid: 9103113556602629632, indexId: 1, indexUid: 8756300908021427968)

        try entityBuilder.lastProperty(id: 5, uid: 3972041113281408000)
    }
}

extension Book {
    /// Generated entity property information.
    ///
    /// You may want to use this in queries to specify fetch conditions, for example:
    ///
    ///     box.query { Book.id == myId }
    internal static var id: Property<Book, Id, Id> { return Property<Book, Id, Id>(propertyId: 1, isPrimaryKey: true) }
    /// Generated entity property information.
    ///
    /// You may want to use this in queries to specify fetch conditions, for example:
    ///
    ///     box.query { Book.title.startsWith("X") }
    internal static var title: Property<Book, String, Void> { return Property<Book, String, Void>(propertyId: 2, isPrimaryKey: false) }
    /// Generated entity property information.
    ///
    /// You may want to use this in queries to specify fetch conditions, for example:
    ///
    ///     box.query { Book.pages > 1234 }
    internal static var pages: Property<Book, Int, Void> { return Property<Book, Int, Void>(propertyId: 3, isPrimaryKey: false) }
    /// Generated entity property information.
    ///
    /// You may want to use this in queries to specify fetch conditions, for example:
    ///
    ///     box.query { Book.notes.startsWith("X") }
    internal static var notes: Property<Book, String, Void> { return Property<Book, String, Void>(propertyId: 5, isPrimaryKey: false) }
    internal static var author: Property<Book, EntityId<ToOne<Author>.Target>, ToOne<Author>.Target> { return Property(propertyId: 4) }


    fileprivate func __setId(identifier: ObjectBox.Id) {
        self.id = Id(identifier)
    }
}

extension ObjectBox.Property where E == Book {
    /// Generated entity property information.
    ///
    /// You may want to use this in queries to specify fetch conditions, for example:
    ///
    ///     box.query { .id == myId }

    internal static var id: Property<Book, Id, Id> { return Property<Book, Id, Id>(propertyId: 1, isPrimaryKey: true) }

    /// Generated entity property information.
    ///
    /// You may want to use this in queries to specify fetch conditions, for example:
    ///
    ///     box.query { .title.startsWith("X") }

    internal static var title: Property<Book, String, Void> { return Property<Book, String, Void>(propertyId: 2, isPrimaryKey: false) }

    /// Generated entity property information.
    ///
    /// You may want to use this in queries to specify fetch conditions, for example:
    ///
    ///     box.query { .pages > 1234 }

    internal static var pages: Property<Book, Int, Void> { return Property<Book, Int, Void>(propertyId: 3, isPrimaryKey: false) }

    /// Generated entity property information.
    ///
    /// You may want to use this in queries to specify fetch conditions, for example:
    ///
    ///     box.query { .notes.startsWith("X") }

    internal static var notes: Property<Book, String, Void> { return Property<Book, String, Void>(propertyId: 5, isPrimaryKey: false) }

    internal static var author: Property<Book, ToOne<Author>.Target.EntityBindingType.IdType, ToOne<Author>.Target> { return Property<Book, ToOne<Author>.Target.EntityBindingType.IdType, ToOne<Author>.Target>(propertyId: 4) }

}


/// Generated service type to handle persisting and reading entity data. Exposed through `Book.EntityBindingType`.
internal class BookBinding: ObjectBox.EntityBinding {
    internal typealias EntityType = Book
    internal typealias IdType = Id

    internal required init() {}

    internal func generatorBindingVersion() -> Int { 1 }

    internal func setEntityIdUnlessStruct(of entity: EntityType, to entityId: ObjectBox.Id) {
        entity.__setId(identifier: entityId)
    }

    internal func entityId(of entity: EntityType) -> ObjectBox.Id {
        return entity.id.value
    }

    internal func collect(fromEntity entity: EntityType, id: ObjectBox.Id,
                                  propertyCollector: ObjectBox.FlatBufferBuilder, store: ObjectBox.Store) throws {
        let propertyOffset_title = propertyCollector.prepare(string: entity.title)
        let propertyOffset_notes = propertyCollector.prepare(string: entity.notes)

        propertyCollector.collect(id, at: 2 + 2 * 1)
        propertyCollector.collect(entity.pages, at: 2 + 2 * 3)
        try propertyCollector.collect(entity.author, at: 2 + 2 * 4, store: store)
        propertyCollector.collect(dataOffset: propertyOffset_title, at: 2 + 2 * 2)
        propertyCollector.collect(dataOffset: propertyOffset_notes, at: 2 + 2 * 5)
    }

    internal func postPut(fromEntity entity: EntityType, id: ObjectBox.Id, store: ObjectBox.Store) throws {
        if entityId(of: entity) == 0 {  // New object was put? Attach relations now that we have an ID.
            entity.author.attach(to: store.box(for: Author.self))
        }
    }
    internal func setToOneRelation(_ propertyId: obx_schema_id, of entity: EntityType, to entityId: ObjectBox.Id?) {
        switch propertyId {
            case 4:
                entity.author.targetId = (entityId != nil) ? EntityId<Author>(entityId!) : nil
            default:
                fatalError("Attempt to change nonexistent ToOne relation with ID \(propertyId)")
        }
    }
    internal func createEntity(entityReader: ObjectBox.FlatBufferReader, store: ObjectBox.Store) -> EntityType {
        let entity = Book()

        entity.id = entityReader.read(at: 2 + 2 * 1)
        entity.title = entityReader.read(at: 2 + 2 * 2)
        entity.pages = entityReader.read(at: 2 + 2 * 3)
        entity.notes = entityReader.read(at: 2 + 2 * 5)

        entity.author = entityReader.read(at: 2 + 2 * 4, store: store)
        return entity
    }
}


/// Helper function that allows calling Enum(rawValue: value) with a nil value, which will return nil.
fileprivate func optConstruct<T: RawRepresentable>(_ type: T.Type, rawValue: T.RawValue?) -> T? {
    guard let rawValue = rawValue else { return nil }
    return T(rawValue: rawValue)
}

// MARK: - Store setup

fileprivate func cModel() throws -> OpaquePointer {
    let modelBuilder = try ObjectBox.ModelBuilder()
    try Author.buildEntity(modelBuilder: modelBuilder)
    try Book.buildEntity(modelBuilder: modelBuilder)
    modelBuilder.lastEntity(id: 2, uid: 2463130310576128256)
    modelBuilder.lastIndex(id: 1, uid: 8756300908021427968)
    return modelBuilder.finish()
}

extension ObjectBox.Store {
    /// A store with a fully configured model. Created by the code generator with your model's metadata in place.
    ///
    /// # In-memory database
    /// To use a file-less in-memory database, instead of a directory path pass `memory:` 
    /// together with an identifier string:
    /// ```swift
    /// let inMemoryStore = try Store(directoryPath: "memory:test-db")
    /// ```
    ///
    /// - Parameters:
    ///   - directoryPath: The directory path in which ObjectBox places its database files for this store,
    ///     or to use an in-memory database `memory:<identifier>`.
    ///   - maxDbSizeInKByte: Limit of on-disk space for the database files. Default is `1024 * 1024` (1 GiB).
    ///   - fileMode: UNIX-style bit mask used for the database files; default is `0o644`.
    ///     Note: directories become searchable if the "read" or "write" permission is set (e.g. 0640 becomes 0750).
    ///   - maxReaders: The maximum number of readers.
    ///     "Readers" are a finite resource for which we need to define a maximum number upfront.
    ///     The default value is enough for most apps and usually you can ignore it completely.
    ///     However, if you get the maxReadersExceeded error, you should verify your
    ///     threading. For each thread, ObjectBox uses multiple readers. Their number (per thread) depends
    ///     on number of types, relations, and usage patterns. Thus, if you are working with many threads
    ///     (e.g. in a server-like scenario), it can make sense to increase the maximum number of readers.
    ///     Note: The internal default is currently around 120. So when hitting this limit, try values around 200-500.
    ///   - readOnly: Opens the database in read-only mode, i.e. not allowing write transactions.
    ///
    /// - important: This initializer is created by the code generator. If you only see the internal `init(model:...)`
    ///              initializer, trigger code generation by building your project.
    internal convenience init(directoryPath: String, maxDbSizeInKByte: UInt64 = 1024 * 1024,
                            fileMode: UInt32 = 0o644, maxReaders: UInt32 = 0, readOnly: Bool = false) throws {
        try self.init(
            model: try cModel(),
            directory: directoryPath,
            maxDbSizeInKByte: maxDbSizeInKByte,
            fileMode: fileMode,
            maxReaders: maxReaders,
            readOnly: readOnly)
    }
}

// swiftlint:enable all
