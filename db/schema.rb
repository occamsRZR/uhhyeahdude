# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150222091325) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "episode_timestamps", force: :cascade do |t|
    t.integer  "timestamp"
    t.text     "description"
    t.integer  "episode_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "episode_timestamps", ["episode_id"], name: "index_episode_timestamps_on_episode_id", using: :btree

  create_table "episodes", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "public_url"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "number"
    t.string   "file_name"
    t.text     "wecks_entry"
    t.string   "slug"
    t.string   "media_type",               default: "audio"
    t.integer  "cached_votes_total",       default: 0
    t.integer  "cached_votes_score",       default: 0
    t.integer  "cached_votes_up",          default: 0
    t.integer  "cached_votes_down",        default: 0
    t.integer  "cached_weighted_score",    default: 0
    t.integer  "cached_weighted_total",    default: 0
    t.float    "cached_weighted_average",  default: 0.0
    t.string   "audio_track_file_name"
    t.string   "audio_track_content_type"
    t.integer  "audio_track_file_size"
    t.datetime "audio_track_updated_at"
    t.string   "video_file_name"
    t.string   "video_content_type"
    t.integer  "video_file_size"
    t.datetime "video_updated_at"
  end

  add_index "episodes", ["cached_votes_down"], name: "index_episodes_on_cached_votes_down", using: :btree
  add_index "episodes", ["cached_votes_score"], name: "index_episodes_on_cached_votes_score", using: :btree
  add_index "episodes", ["cached_votes_total"], name: "index_episodes_on_cached_votes_total", using: :btree
  add_index "episodes", ["cached_votes_up"], name: "index_episodes_on_cached_votes_up", using: :btree
  add_index "episodes", ["cached_weighted_average"], name: "index_episodes_on_cached_weighted_average", using: :btree
  add_index "episodes", ["cached_weighted_score"], name: "index_episodes_on_cached_weighted_score", using: :btree
  add_index "episodes", ["cached_weighted_total"], name: "index_episodes_on_cached_weighted_total", using: :btree
  add_index "episodes", ["slug"], name: "index_episodes_on_slug", unique: true, using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "pg_search_documents", force: :cascade do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "punches", force: :cascade do |t|
    t.integer  "punchable_id",                          null: false
    t.string   "punchable_type", limit: 20,             null: false
    t.datetime "starts_at",                             null: false
    t.datetime "ends_at",                               null: false
    t.datetime "average_time",                          null: false
    t.integer  "hits",                      default: 1, null: false
  end

  add_index "punches", ["average_time"], name: "index_punches_on_average_time", using: :btree
  add_index "punches", ["punchable_type", "punchable_id"], name: "punchable_index", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role"
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

end
