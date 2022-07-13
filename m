Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A6C573626
	for <lists+linux-edac@lfdr.de>; Wed, 13 Jul 2022 14:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbiGMMOv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 13 Jul 2022 08:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiGMMOu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 13 Jul 2022 08:14:50 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDED883F1D;
        Wed, 13 Jul 2022 05:14:48 -0700 (PDT)
Received: from mail-yb1-f176.google.com ([209.85.219.176]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N3sye-1nTV5S0R1s-00znLT; Wed, 13 Jul 2022 14:14:46 +0200
Received: by mail-yb1-f176.google.com with SMTP id y195so18984192yby.0;
        Wed, 13 Jul 2022 05:14:45 -0700 (PDT)
X-Gm-Message-State: AJIora+9WQbWdQHZnzz10ub9DLl+CNcoCop1PsCCfyHrRnpqrCyCa3fM
        EimS/gJzzFZgehSUsYEmslCvdnzd+11EY7DbHUI=
X-Google-Smtp-Source: AGRyM1uoJQYulkknNKp9p4xlIYwtcLtDUZEWeRILKUzUp7kQEEEiWDmE/Cnxs1q4j3RSu9fsSg5xhlVIAG6cbAi0V/c=
X-Received: by 2002:a05:6902:120f:b0:668:2228:9627 with SMTP id
 s15-20020a056902120f00b0066822289627mr3559363ybu.134.1657714484730; Wed, 13
 Jul 2022 05:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220708185608.676474-1-thierry.reding@gmail.com>
 <20220708185608.676474-2-thierry.reding@gmail.com> <CAK8P3a1bKUr77t9xkNAX=-RqzRme6Hymr3V=36MSHT_sOFEW5A@mail.gmail.com>
 <Ys6lXD6BSxjH02mW@orome>
In-Reply-To: <Ys6lXD6BSxjH02mW@orome>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 Jul 2022 14:14:27 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0cSq47B=acZ854TVu=RckJNfyfKdqQUMzCX7SsV7Wt0g@mail.gmail.com>
Message-ID: <CAK8P3a0cSq47B=acZ854TVu=RckJNfyfKdqQUMzCX7SsV7Wt0g@mail.gmail.com>
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
X-Provags-ID: V03:K1:FO//SfLLnIrs+l5EwPKVhLszgKWbhu9vU19KLj1dWtLwVL1Mw9N
 eaBdnzA/hgAxhieVCBXgQDs/PNnnp//lCq+EMoj8vb0gwySgcnNwqEQIyzXj9XQmQo5uD3S
 dw+5oIhXTS9FoSadonsEJzTuaogVnllWoswMOWk+V9/By/z6eIAU4wPknYXDFgrkoRFIa/o
 JZ2M6CZPk7NbtI14iFEBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RjDLUeS+w9E=:g8e/c1BUzXCxrYiEwgIfSd
 iBojgG5urSL9/z/V/ziKCypA4XxbeId7gPoH6TyS7Fl1oV8WqmpsOrclR9G6lIIbXfHTpcHZl
 zFMhYGUhGkZmjdsiHgFJ+jTRnYMAw0K97uQFo9MrjrhL76/ADSutvcfJvvZ8IGvRgMaprJDsr
 LZdFl0s89xHSPjVs2fUHHz9xcBMMz9zjaD8JCM6+X9Ow0hwk0Y7tl69AtxsShiU08XXnw6afE
 y9HJOiZZUgMME+69XWjDiXVLMMgFvy8uCD7igLMXbmP2NrwZZ2ENbjnVRKBl2exwWQ8SF1ltd
 4l5WxbqFPDDAj0FlH91bwEIJ5ITTESP+PjIx5KANUF0mkjSEOLAs29QYNXqcVIdB2pBRvzj7+
 AMp/f6yE+imq9zCC/45RG8ro8hAYLbBAGRNuoldXlZu3a6pDWtu0j2i1+EPNPR+y9hZfpo+nl
 6h2/H13UAncBM99Wl5aJ8FkdC4iaY4l1jpVfBOCAxH2MCFZLhAzcj2etM84fvJtqz3ISId1RM
 +4TmL0zM/s+kNvc+FmmdPblSow6Pi8gUxSGS5m1TudRHxyCbrbbmjS1FpdIhSXZqPFbSYxnzZ
 S3XogUBFYvssliRN0V7CVt4PGMd22NKtOfjZ3+JZFoV10CZAEK3lDzcecJ3+lDvaDBg5gKyOU
 /UOxV/bSm8dw2LQOozcfRRbWyVQd/0ofkBZKRGZe8FT3w+6lzgjR8uVfDwo3usyeT7MWi+hvF
 rIWwIjWyAJCvbBkDSGGP/gtYSPgwiqzTYnvGRkzxvSbxlvxwhHQM076n0rdlzVNEPM941WgPa
 93JudUIHj74XdJHa/ct6rSCo1gDv4soVKeUzvUsnseCbUpyuplAXRyBHnRWMfVqWWYhUi+0Tr
 IGyx2CZWyRQRtsIGtaXQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jul 13, 2022 at 12:58 PM Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Tue, Jul 12, 2022 at 03:27:16PM +0200, Arnd Bergmann wrote:
> > On Fri, Jul 8, 2022 at 8:56 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> >
> > I fear I'm going to skip this for the current merge window. It looks like
> > the CBB driver you add here would fit into the existing drivers/edac/
> > subsystem, or at the minimum should have been reviewed by the
> > corresponding maintainers (added to Cc)  to decide whether it goes
> > there or not.
> >
> > I had not previously seen this driver, but I'll let them have a look first.
>
> EDAC looks like it's used primarily for memory controllers, which this
> is not. But then I also see explicit references to non-memory-controller
> references in the infrastructure, so perhaps this does fit in there. The
> CBB driver is primarily a means to provide additional information about
> runtime errors, so it's not directly a means of discovering the errors
> (they would be detected anyway and cause a crash) and I don't think we
> have a means of correcting any of these errors.

I think this is just a reflection of what other hardware can do:
most machines only detect memory errors, but the EDAC subsystem
can work with any type in principle. There are also a lot of
conditions elsewhere that can be detected but not corrected.

> I'll ask Sumit to work with the EDAC maintainers on this.

Thanks

> > For the other patches, I found two more problems:
> >
> > > Bitan Biswas (1):
> > >       soc/tegra: fuse: Expose Tegra production status
> >
> > Please don't just add random attributes in the soc device infrastructure.
> > This one has a completely generic name but a SoC specific
> > meaning, and it lacks a description in Documentation/ABI.
> > Not sure what the right ABI is here, but this is something that needs
> > to be discussed more broadly when you send a new version.
>
> I wasn't aware that the SoC device infrastructure was restricted to only
> standardized attributes. Looks like there are a few other outliers that
> add custom attributes: UX500, ARM Integrator and RealView, and OMAP2.
>
> Do we have some other place where this kind of thing can be exposed? Or
> do we just need to come up with some better way of namespacing these?
> Perhaps it would also be sufficient if all of these were better
> documented so that people know what to look for on their platform of
> interest.

It's not a 100% strict rule, I've just tried to limit it as much as possible,
and sometimes missed drivers doing it anyway. My main goal here is
to make things consistent between SoC families, so if one piece of
information is provided by a number of them, I'd rather have a standard
attribute, or a common way of encoding this in the existing attributes
than to have too many custom attributes with similar names.

> > > YueHaibing (1):
> > >      soc/tegra: fuse: Add missing DMADEVICES dependency
> >
> > This one fixes the warning the wrong way: we don't 'select' random
> > drivers from other subsystems, and selecting the entire
> > subsystem makes it worse. Just drop the 'select' here and
> > enable the drivers in the defconfig.
>
> This doesn't actually select the DMADEVICES property. It adds a
> dependency on DMADEVICES and if that is met it will select
> TEGRA20_APB_DMA.

My mistake. However, I still think it's wrong to select
TEGRA20_APB_DMA here, unless there is a build-time
dependency that prevents it from being compiled otherwise.

The dmaengine subsystem is meant to abstract the relation
between the drivers using DMA and those providing the feature,
the same way we abstract all the other subsystems. The
fuse driver may only be used on machines that use
TEGRA20_APB_DMA, but neither the driver code nor
Kconfig should care about that.

        Arnd
