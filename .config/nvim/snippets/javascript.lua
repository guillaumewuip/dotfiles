local fmta = require("luasnip.extras.fmt").fmta

return {
  s(
    {
      name = 'console {}',
      trig = 'console',
      priority = 20,
    },
    fmta(
      'console.<>({ <> })',
      {
        c(2, {
          t('log'),
          t('error'),
          t('warn'),
          t('info'),
          i(nil, 'something'),
        }),
        i(1),
      }
    )
  ),

  s(
    {
      name = 'console',
      trig = 'console',
      priority = 10,
    },
    fmta(
      'console.<>(<>)',
      {
        c(2, {
          t('log'),
          t('error'),
          t('warn'),
          t('info'),
          i(nil, 'something'),
        }),
        i(1),
      }
    )
  ),

  s(
    {
      trig = 'describe',
    },
    fmta(
      [[
        describe('<>', () =>> {
          <>
        })
        <>
      ]],
      {
        i(1, 'toto'),
        i(2),
        i(0),
      }
    )
  ),

  s(
    {
      name = 'it',
      trig = 'it',
    },
    fmta(
      [[
        it('<>', () =>> {
          <>
        })
        <>
      ]],
      {
        i(1, 'toto'),
        i(2),
        i(0),
      }
    )
  ),

  s(
    {
      name = 'it async',
      trig = 'it',
    },
    fmta(
      [[
        it('<>', async () =>> {
          <>
        })
        <>
      ]],
      {
        i(1, 'toto'),
        i(2),
        i(0),
      }
    )
  ),

  s(
    {
      name = 'import',
      trig = 'import',
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
      name = 'import object',
      trig = 'import',
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

  s(
    {
      trig = 'pipe',
    },
    fmta(
      [[
        import { pipe } from 'fp-ts/function'
        <>
      ]],
      {
        i(0),
      }
    )
  ),

  s(
    {
      trig = 'fpts',
    },
    fmta(
      [[
        import * as <> from 'fp-ts/<>'
        <>
      ]],
      {
        i(1),
        f(
          function(args, snip, user_arg)
            return args[1][1]
          end,
          {1},
          {}
        ),
        i(0)
      }
    )
  ),
}
