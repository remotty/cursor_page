# CursorPage

Cursor based pagination gem.

무한 스크롤 UI에서 흔히 사용하는 커서 기반의 페이징 플러그인입니다.

이 Gem은 [루비 대림절 달력](https://ruby-korea.github.io/advent-calendar/)을 위해 제작하였습니다. 구현 내용을 설명하는 글을 작성하려고 했지만, 소스가 너무 간단한 관계로 작성할 내용이 없어져버렸습니다;;;

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cursor_page'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cursor_page

## Usage

### The `cursor_page` Scope

To fetch the posts that ID value less then 2.

```ruby
Post.cursor_page(before: 2)
```

To fetch the 10 posts that ID value greater then 10.

```ruby
Post.cursor_page(after: 10).limit(10)
```

To fetch the posts that ts value greater then 1482495565.

```ruby
Post.cursor_page(key: 'ts', after: 1482495565)
```

### The `cursor` Value

Get current cursor value

```ruby
@posts = Post.cursor_page(before: 2)
@posts.cursor # {:key=>"id", :before=>2, :after=>nil}
```

### `to_cursor_param` method

Get cursor parameters for response json

```ruby
@posts = Post.cursor_page(before: 3)
@posts.to_cursor_param # {:before=>"MQ==", :after=>"Mg=="}
```

## Todo

- [ ] Add test code

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/remotty/cursor_page.
