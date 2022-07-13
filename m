Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7077573675
	for <lists+linux-edac@lfdr.de>; Wed, 13 Jul 2022 14:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiGMMg6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 13 Jul 2022 08:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiGMMg5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 13 Jul 2022 08:36:57 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02A5F5D54;
        Wed, 13 Jul 2022 05:36:55 -0700 (PDT)
Received: from mail-yw1-f178.google.com ([209.85.128.178]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MF418-1oMXpl415U-00FPBH; Wed, 13 Jul 2022 14:36:54 +0200
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-31c89653790so110655937b3.13;
        Wed, 13 Jul 2022 05:36:53 -0700 (PDT)
X-Gm-Message-State: AJIora8juM+Q6YDO4ZJStiPqrssrQjjnpw0L8X4PP7tauD0EjXW2AlLE
        4ySaG3sh57XSc0n9At27GoQadJkORPN+clMyaXk=
X-Google-Smtp-Source: AGRyM1sh6y2Q78V+7SEHOa4+tSkaz/9F3euOrnSe3woF61Ndiv4noQe+HMpJi5sccU+Otl07Nje5B04oP8knpINAaJ0=
X-Received: by 2002:a0d:df0f:0:b0:31b:e000:7942 with SMTP id
 i15-20020a0ddf0f000000b0031be0007942mr3819236ywe.320.1657715812648; Wed, 13
 Jul 2022 05:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220708185608.676474-1-thierry.reding@gmail.com>
 <20220708185608.676474-2-thierry.reding@gmail.com> <CAK8P3a1bKUr77t9xkNAX=-RqzRme6Hymr3V=36MSHT_sOFEW5A@mail.gmail.com>
 <Ys6lXD6BSxjH02mW@orome> <CAK8P3a0cSq47B=acZ854TVu=RckJNfyfKdqQUMzCX7SsV7Wt0g@mail.gmail.com>
 <d12fa14a-bf0d-4e98-acd8-69229315d660@nvidia.com>
In-Reply-To: <d12fa14a-bf0d-4e98-acd8-69229315d660@nvidia.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 Jul 2022 14:36:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1sDbtEUaT7Z5k_SfUcA7OBUxkny7kmKOMFaE96qaGeXg@mail.gmail.com>
Message-ID: <CAK8P3a1sDbtEUaT7Z5k_SfUcA7OBUxkny7kmKOMFaE96qaGeXg@mail.gmail.com>
Subject: Re: [GIT PULL 1/7] soc/tegra: Changes for v5.20-rc1
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        arm-soc <arm@kernel.org>, SoC Team <soc@kernel.org>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-edac@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:vU5+L2oxFriovnRyAO0MXbwcIyZzlwPFR4vSSs/PuHF2+Wfpu/q
 EQDyKfZ8dlkwImvR209+qkY71AWXF6PiqsE1JG1vfj7zK1d2UMVjbvis/29EqSPWsQQ/rur
 DCZM12sJUtUadXRIEvo7yhsbxffsciBQfYR32+9BvFf77nDoGwwlsCuKiK08wpCsyCK1g3O
 yxsX/AcyLLdCMyW4eFr0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gU5u+f4sApo=:Nj6WwAeNzoJE2YjSe0i/Wj
 OD9MhhC2GB45XGVdlKfP20CTVOs35RSruEDunGnnj0CRcnIPN7h7QrOyjHzAQZ22kBsKu7aFi
 ROleo4iEk/0KjbVtbbTYUPm3/7dWlvxjXez2JvHPmnZ7b7eVOBtXELN8xPTR9uyqhdkcqTsZ4
 il+hPkZL/ez+YJKN8jVwl2J8hJXhaFz8fVIdxfvH9BGiNRIMbjcNzS7yW/7k0WCAJGWokK/yo
 xFnGLogF6LobH7lsvo8rak0o+dBLSBG3fvS0UYQAnPeuhSLOfiI+gwieOY/tmjlkpL+w9cmgj
 AQsiVsdKoip1CQjs1tlhTCflK1WXiVLM64lZcQKm+8eoDzp4g1xMM0Hl/qpG0Ync0BZNqeGBU
 FoQlJLXdGW4vo6jOjAnFj9D5j6ZxzduMEE/7QJoo9nnA/NazAxUlTtLvzuOh+NfywjbCNgCYC
 yyzp80C4wKUhA2YO0HUx78n4wKDG0McV/7axtPHgVXC6BgiQ2bk7ZaF5Iv4wYTskqIl5vKyQA
 eqzL8ymVsdhOJvnojJzcxUJ3Ow29IbDf9Yj6ojqIhpT11DTAM1+yT8CfzWApiZYSBc0+D7npm
 T35llP0RDDusSrsmlGje4NWjAjyuqN5fHnAGOiubj7LOwaoUXA+YyvX4cunPZ9a4QUGyfBZZL
 gXTF9MDdPxikCrYaT9cKvfcz/h+nCCZxgIuOs71J5NoQ01PBLQtvBQhJI13lPDsNBXOozL6wL
 6ZkrEC9zuUlGHj8fgUHAUrLTY5nmiiH7DHPhefiktv0BQCbucuf8tVtMN/bgKzoekwZghlwFi
 tMFPistT2F+cWK67x5W5RN8weg12BQN/VIfnxll+V4bzagfzRrvfr5IfyGyk7Tn9u0fd4M2XS
 +kK9AMTxN3mHbUikP/c1Ro16FPAa+rVa7QvfAmjuA=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jul 13, 2022 at 2:19 PM Jon Hunter <jonathanh@nvidia.com> wrote:
> On 13/07/2022 13:14, Arnd Bergmann wrote:
> >>> For the other patches, I found two more problems:
> >>>
> >>>> Bitan Biswas (1):
> >>>>        soc/tegra: fuse: Expose Tegra production status
> >>>
> >>> Please don't just add random attributes in the soc device infrastructure.
> >>> This one has a completely generic name but a SoC specific
> >>> meaning, and it lacks a description in Documentation/ABI.
> >>> Not sure what the right ABI is here, but this is something that needs
> >>> to be discussed more broadly when you send a new version.
> >>
> >> I wasn't aware that the SoC device infrastructure was restricted to only
> >> standardized attributes. Looks like there are a few other outliers that
> >> add custom attributes: UX500, ARM Integrator and RealView, and OMAP2.
> >>
> >> Do we have some other place where this kind of thing can be exposed? Or
> >> do we just need to come up with some better way of namespacing these?
> >> Perhaps it would also be sufficient if all of these were better
> >> documented so that people know what to look for on their platform of
> >> interest.
> >
> > It's not a 100% strict rule, I've just tried to limit it as much as possible,
> > and sometimes missed drivers doing it anyway. My main goal here is
> > to make things consistent between SoC families, so if one piece of
> > information is provided by a number of them, I'd rather have a standard
> > attribute, or a common way of encoding this in the existing attributes
> > than to have too many custom attributes with similar names.
>
>
> Makes sense. Any recommendations for this specific attribute? I could
> imagine other vendors may have engineering devices and production
> versions. This is slightly different from the silicon version.

Not sure, I haven't seen this one referenced elsewhere so far.

What is the actual information this encodes in your case? Is this fused
down in a way that production devices lose access to certain features
that could be security critical but are useful for development?

         Arnd
