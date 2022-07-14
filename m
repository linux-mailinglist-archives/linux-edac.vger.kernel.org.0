Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4DB575109
	for <lists+linux-edac@lfdr.de>; Thu, 14 Jul 2022 16:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239216AbiGNOp7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 14 Jul 2022 10:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiGNOp6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 14 Jul 2022 10:45:58 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AF73ED66;
        Thu, 14 Jul 2022 07:45:56 -0700 (PDT)
Received: from mail-yw1-f179.google.com ([209.85.128.179]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MoOty-1njVyE37qS-00oqNG; Thu, 14 Jul 2022 16:45:54 +0200
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-31c8bb90d09so19259437b3.8;
        Thu, 14 Jul 2022 07:45:54 -0700 (PDT)
X-Gm-Message-State: AJIora/f+YRa7w/6Hm4rJOSR4mmCT+n6f3Q903QsAoTO1nOBOdBdROc/
        0azreUvSe1TPAAcDPBQ5QxKVanASbdfIVb1g374=
X-Google-Smtp-Source: AGRyM1sAiofyZ4eEN27XJwa3Mt9SWNENKQxEfVUFkxvE89dWciOhpZF91QPduWhp/J38s+Ac736VF37oa7KLX1u7GaM=
X-Received: by 2002:a81:1e4d:0:b0:31c:86f1:95b1 with SMTP id
 e74-20020a811e4d000000b0031c86f195b1mr10012474ywe.42.1657809953406; Thu, 14
 Jul 2022 07:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220708185608.676474-1-thierry.reding@gmail.com>
 <20220708185608.676474-2-thierry.reding@gmail.com> <CAK8P3a1bKUr77t9xkNAX=-RqzRme6Hymr3V=36MSHT_sOFEW5A@mail.gmail.com>
 <Ys6lXD6BSxjH02mW@orome> <CAK8P3a0cSq47B=acZ854TVu=RckJNfyfKdqQUMzCX7SsV7Wt0g@mail.gmail.com>
 <Ys8phjCTfQTD41g+@orome>
In-Reply-To: <Ys8phjCTfQTD41g+@orome>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 Jul 2022 16:45:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2NzWh7vtedeb6JXtWjQb1zaiPHQpgReie8a7ahwMzL3w@mail.gmail.com>
Message-ID: <CAK8P3a2NzWh7vtedeb6JXtWjQb1zaiPHQpgReie8a7ahwMzL3w@mail.gmail.com>
Subject: Re: [GIT PULL 1/7] soc/tegra: Changes for v5.20-rc1
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm-soc <arm@kernel.org>,
        SoC Team <soc@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-edac@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:skPpJQW8Zgz3ukUXOMhEi7P5zWMXgy2zVSpfSrDCe6DJOitk8Ll
 s6p+aJ1pT3WflU/JCMfw6MS4/CjIW+Zv+jVculi+0ir0epyjYQBQn4h+cn6sEM76LTnZhtS
 Ueuxo64fiVJXrqF35MTmG+jEL9bvynw2SS4FXx2GIeteSNeLgYWzmFvI/VVGrTImbt6eK85
 26xVwHhYFgqKYrmgY5YRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jYyl7EarRJw=:YPs5v/cNPpQcEQwf4N42Qo
 /lRC1k73WmTcFaTz9+hsPs2I/1yzyvKu23/19rnZxuObqA7EUd9cuV2senF+KRR9fY6F024I6
 6yM3z6pd9o16/quDoFAqD0Wb8J1j7Si2av7uAO9CiznlAP4U5Liuq9/8rS7FKMDcBMoErjavB
 ccR+rJjiUcKanReooxUCyWchdsWsGJRhkIxnlKCxgM8PPvek/nXxZujYjjedFT0N9lvl9jjVY
 u/f6joBeVB162h+oIlGHDWnz/X7XkOdf8unUKrkYc+zogcqhKYon3W8TQDAfgZGt4jdqY6+PA
 4658i/1T8R+FYkM82/oUU2qf4WtDwhhQSfdV8/mBR3Sz2IZQEkdczG0pij4WsAxUgwX6ypxfj
 O7VbLZuRdJucR+wy/NgHvJbfZNLrAYRny8nHsC2l6dBnb8N3dUJe0GXMOKLfqnew5o/PBeaf8
 85k+16ljhLTRKdQwOIgkBX78kPTW+IhDOrhEwHn6vUcmXbCdlH6FABou2WP8/3YKUFvRO8svA
 36nkYH7r9mzERU1ztmSzsTSUfbQAaVRSx5Nxgem4ZIFrrg+BzpnJste6K+OrJHOFk2d4XbIa5
 AOqewMWVo5bxQ+MxWkdB9vdFJZBP7ujKN79GqCwvGdphzTVH9BVtifOmkDtXtmSZr9S4etsKD
 uOdLfjH1vXAwzvlLn+Lf7aZwhPHlXf5jomU/Y4aXgb4wJq8Wh7WNUhXYPXGowWvpLgwEbMQ0m
 wtrm696i/1dGZW72iBJA4peldBg5IKGRLbyQ2ufjyavXFfT5/QXcyZ4Nb0pFDYvWoO6JnEcdO
 s+AjABQui9addrY0M3pZfhOaScJPECP2OrzP4pEwrEJJy7DvDFEsp4HMCsotP/FRjD1Wthh3x
 8pj476swfq//dHC+elWw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jul 13, 2022 at 10:22 PM Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Wed, Jul 13, 2022 at 02:14:27PM +0200, Arnd Bergmann wrote:
> >
> > It's not a 100% strict rule, I've just tried to limit it as much as possible,
> > and sometimes missed drivers doing it anyway. My main goal here is
> > to make things consistent between SoC families, so if one piece of
> > information is provided by a number of them, I'd rather have a standard
> > attribute, or a common way of encoding this in the existing attributes
> > than to have too many custom attributes with similar names.
>
> The major/minor attributes that we have on Tegra SoCs should be easy to
> standardize. It seems like those could be fairly common.

I think these can just be folded into one of the other attributes, probably
either revision or soc_id dependending on what they actually refer to.

These properties are intentionally free-text fields that you can match
using wildcards with the soc_device_match() function. If I read this
part right, the information is already available in the soc_id field,
so we don't even need to change anything here.

> The other one
> that we have is the "platform" one, which I suppose is not as easy to
> standardize. I don't recall the exact details, but I think we're mostly
> interested in whether or not the platform is simulation or silicon. The
> exact simulation value is not something that userspace scripts will look
> at, as far as I recall.

This also looks like it's part of the chip_id.

> > > > > YueHaibing (1):
> > > > >      soc/tegra: fuse: Add missing DMADEVICES dependency
> > > >
> > > > This one fixes the warning the wrong way: we don't 'select' random
> > > > drivers from other subsystems, and selecting the entire
> > > > subsystem makes it worse. Just drop the 'select' here and
> > > > enable the drivers in the defconfig.
> > >
> > > This doesn't actually select the DMADEVICES property. It adds a
> > > dependency on DMADEVICES and if that is met it will select
> > > TEGRA20_APB_DMA.
> >
> > My mistake. However, I still think it's wrong to select
> > TEGRA20_APB_DMA here, unless there is a build-time
> > dependency that prevents it from being compiled otherwise.
> >
> > The dmaengine subsystem is meant to abstract the relation
> > between the drivers using DMA and those providing the feature,
> > the same way we abstract all the other subsystems. The
> > fuse driver may only be used on machines that use
> > TEGRA20_APB_DMA, but neither the driver code nor
> > Kconfig should care about that.
>
> This dependency has existed for quite a while and my recollection is
> that we wanted to make this very explicit because the lack of the
> TEGRA20_APB_DMA driver makes the FUSE driver completely useless on
> Tegra20 and that in turn has a very negative impact on the rest of the
> system, so we deemed a default configuration change insufficient.
>
> Perhaps a better way to solve this would be to make TEGRA20_APB_DMA
> default to "y" if ARCH_TEGRA_2x_SOC. And then perhaps make the FUSE
> driver depend on DMADEVICES. That still wouldn't ensure that we get
> SOC_TEGRA_FUSE enabled automatically all the time, but perhaps it'd
> document the dependency a bit more explicitly.

Ok, this sounds good to me.

          Arnd
