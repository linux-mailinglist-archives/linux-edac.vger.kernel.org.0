Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94B5571B31
	for <lists+linux-edac@lfdr.de>; Tue, 12 Jul 2022 15:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiGLN1i (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 12 Jul 2022 09:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiGLN1h (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 12 Jul 2022 09:27:37 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B86E904DB;
        Tue, 12 Jul 2022 06:27:36 -0700 (PDT)
Received: from mail-yb1-f181.google.com ([209.85.219.181]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MrhLw-1noEr434Ng-00nknX; Tue, 12 Jul 2022 15:27:34 +0200
Received: by mail-yb1-f181.google.com with SMTP id r3so13910841ybr.6;
        Tue, 12 Jul 2022 06:27:34 -0700 (PDT)
X-Gm-Message-State: AJIora9CcUmRu2M1BDIyxZd83P4Bm79DqF8WJDkmGUO8HuvVG3rQDewT
        //bXa3izZG7KWMh0wgZAau/wcyrtsYSEUF94qa0=
X-Google-Smtp-Source: AGRyM1uXh17pWsKX+Lt0fZNfqCjvNyiaSb6/cGIjflgREtQ0O3M/xH24ftkEVDT58/8HfALKjaLufIJ+KNAVd7QIuNI=
X-Received: by 2002:a25:73d1:0:b0:66e:aee4:feb3 with SMTP id
 o200-20020a2573d1000000b0066eaee4feb3mr23156338ybc.452.1657632453362; Tue, 12
 Jul 2022 06:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220708185608.676474-1-thierry.reding@gmail.com> <20220708185608.676474-2-thierry.reding@gmail.com>
In-Reply-To: <20220708185608.676474-2-thierry.reding@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 12 Jul 2022 15:27:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1bKUr77t9xkNAX=-RqzRme6Hymr3V=36MSHT_sOFEW5A@mail.gmail.com>
Message-ID: <CAK8P3a1bKUr77t9xkNAX=-RqzRme6Hymr3V=36MSHT_sOFEW5A@mail.gmail.com>
Subject: Re: [GIT PULL 1/7] soc/tegra: Changes for v5.20-rc1
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     arm-soc <arm@kernel.org>, SoC Team <soc@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-edac@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:3J6jvD+e/sh/3U6x938tka0X5PHAawbIwdS4d8FtNcYqtxAWqmd
 3rKIJaC6JsTTulyhyyIhEqaHkXy16Zc/orotK82DlR0mFTGu1eefPzuTQ3z7mgbyJwS8Yes
 ZyIPiArJZsEMupzz3Td2F2u4K56AWNAtVDJjVBGIvuXotxluBCTLFoBAkDZqDAHZ9JEoxcC
 4xuIyJIcCDlCPCm04zUwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HtTI3tP1abc=:tftDBu33VXuT2PXyITKu0N
 p+NXxNqygqWnnOSubgxTIJJucYGDnNKifm20iL8MhNWItqIPN2by/ZNTF6HpRUkzF3ZojVa4C
 YUKrBWIyQ8wF3xtwiW9dlWmZhIeWy1ci9vr5u5CN9t4DNCROHC3ogJlr5U72etiDYaepSvWkn
 sInAdctkGedbXMirda4RqpPtRXuQKz6XC4Au/x10PVQc0vAMq8XObejbf4Q8yhreT+kr1cNa7
 ue70jlArM//RwZeF5GWFDHZwiTEJcg8duDUH6CDow4mgJoaUrPO+ywR/KAJHC2UhFfONHLvPr
 iau1mxPPkhx8odO5fPvdmKkz+VnxX6JVKG6Jt/E2SHzYNP7XVXRkk1UC/dSi1IvNB9/taKtcY
 iKCA5whCotzI27fA+UiqZJSe+6pE0Rq2YyITbXQeR9PNT9Yi+ECf0zueXs+VCEi3NTMbfLvQQ
 l3xK295jCViICGmkvZ/P2WT7v3RvA//ilsjjyIzlB95xkQjxmdMJTXsq/mGtemJfAG/+4O3xJ
 5vDprpKis4eKi5p7VkZeSmx+IgN35JEpS3/dkcmO7irsJcRkKFZZDBvPrulORK8eit4c176Ul
 Yx+XevnzqEWUeZbCQPFZOcqalD7kf+7dDHo5EEGyhNz4zg57RV5IhfZZzF+k5Umds3p3hX9y0
 0WUTpkD9ZhLb+SZ85PhfoHqAY3r8V3C0afEDPxXhwVXI5X7/xY9kP+QpXPzyErCGRhUhBvyTQ
 XOZkAqJmvzrl5Sr5WfycvGj4i/mn8BWsQIS3zX66XeolSY2z9k9l4Ug+FautkSgmihFZKDGrr
 tWVKTDWcuEMc6RdNo1nrzSopcpSTBZ3f8MoZ4dEHPy+ZMIZSpVsXAYDsb2QEDr+rSX/kbWpxZ
 Ju+6KSNA7ZLU3A0V2pIA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jul 8, 2022 at 8:56 PM Thierry Reding <thierry.reding@gmail.com> wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-5.20-soc
...
> ----------------------------------------------------------------
> soc/tegra: Changes for v5.20-rc1
>
> The bulk of these changes is the new CBB driver which is used to provide
> (a lot of) information about SErrors when things go wrong, instead of
> the kernel just crashing or hanging.
>
> In addition more SoC information is exposed to sysfs and various minor
> issues are fixed.
>

Hi Thierry,

I fear I'm going to skip this for the current merge window. It looks like
the CBB driver you add here would fit into the existing drivers/edac/
subsystem, or at the minimum should have been reviewed by the
corresponding maintainers (added to Cc)  to decide whether it goes
there or not.

I had not previously seen this driver, but I'll let them have a look first.

For the other patches, I found two more problems:

> Bitan Biswas (1):
>       soc/tegra: fuse: Expose Tegra production status

Please don't just add random attributes in the soc device infrastructure.
This one has a completely generic name but a SoC specific
meaning, and it lacks a description in Documentation/ABI.
Not sure what the right ABI is here, but this is something that needs
to be discussed more broadly when you send a new version.

I see there are already some custom attributes in the same device,
we should probably not have added those either, but I suppose
we are stuck with those, so please add the missing documentation.

> YueHaibing (1):
>      soc/tegra: fuse: Add missing DMADEVICES dependency

This one fixes the warning the wrong way: we don't 'select' random
drivers from other subsystems, and selecting the entire
subsystem makes it worse. Just drop the 'select' here and
enable the drivers in the defconfig.

         Arnd
