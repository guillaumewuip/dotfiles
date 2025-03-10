local fmta = require("luasnip.extras.fmt").fmta

return {
  s(
    {
      name = "console.log({})",
      trig = "loga",
      priority = 200,
    },
    fmta("console.log({ <> })", {
      i(1),
    })
  ),

  s(
    {
      name = "console.log(",
      trig = "logb",
      priority = 100,
    },
    fmta("console.log(<>)", {
      i(1),
    })
  ),

  s(
    {
      trig = "describe",
    },
    fmta(
      [[
        describe('<>', () =>> {
          <>
        })
        <>
      ]],
      {
        i(1, "toto"),
        i(2),
        i(0),
      }
    )
  ),

  s(
    {
      name = "it",
      trig = "it",
    },
    fmta(
      [[
        it('<>', () =>> {
          <>
        })
        <>
      ]],
      {
        i(1, "toto"),
        i(2),
        i(0),
      }
    )
  ),

  s(
    {
      name = "it async",
      trig = "it",
    },
    fmta(
      [[
        it('<>', async () =>> {
          <>
        })
        <>
      ]],
      {
        i(1, "toto"),
        i(2),
        i(0),
      }
    )
  ),

  s(
    {
      name = "import",
      trig = "import",
    },
    fmta(
      [[
        import <> from '<>'
        <>
      ]],
      {
        i(1),
        i(2),
        i(0),
      }
    )
  ),

  s(
    {
      name = "import object",
      trig = "import",
    },
    fmta(
      [[
        import { <> } from '<>',
        <>
      ]],
      {
        i(2),
        i(1),
        i(0),
      }
    )
  ),
}
