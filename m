Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8426E9666
	for <lists+linux-edac@lfdr.de>; Thu, 20 Apr 2023 15:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjDTN5M (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 20 Apr 2023 09:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjDTN5M (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 20 Apr 2023 09:57:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5244BCD;
        Thu, 20 Apr 2023 06:57:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2365649A3;
        Thu, 20 Apr 2023 13:57:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56297C433A0;
        Thu, 20 Apr 2023 13:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681999030;
        bh=0zCwOIJjuwPEopLOkv2gjEtdTnJPz6ssKDGCCwQhU8g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FkX4a8xw4SGooMCjJhrqAQ1XxCcmjghTkpnhr3ZV5Q+0YtQfewfGUd2FI60cvGJ7l
         JCz6IcjJuHVgfNZsWFaHYnDqTJvFwwt3y8lNkKk1Az/9gxQm0qtlL5lD3QAcZnGIWM
         kkeL63q0KLPR+Af3fFs8pbv2araD+LvPTfArllNYUer6IMJauywB1cKF29vOzoVSLC
         /sQVNPZ2cTjFO3jpRsi+Py7aSDtuCXi8ymhHXZtjBeE+6g2v9b90glyfvBiKxi7Cyu
         Lw1ixTcTbfHgjPXUXAMjZhzYb75B6ROATeg52RJbt2igYPg51PYVCoVxcD6Cj4BJlf
         PYKOQ7wO7LsgA==
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-552ae3e2cbeso41300677b3.13;
        Thu, 20 Apr 2023 06:57:10 -0700 (PDT)
X-Gm-Message-State: AAQBX9d3J1CfkxsWCjsa6F8dtYJZbrxf4AQCGBGcQxXEMlKhVnfxe9OV
        u45mCP/YC7geY/uXGydnwEYl8tbGReaLSGspgw==
X-Google-Smtp-Source: AKy350b0EqY4vhYLM3Yu6RfypWd2ClReF0KNDJmoDx8Ai5GbIHiIDuMWlydPYzKEm+zXXno3ro+KJWmUskeluYv56o4=
X-Received: by 2002:a0d:d886:0:b0:54f:b874:116f with SMTP id
 a128-20020a0dd886000000b0054fb874116fmr925830ywe.7.1681999029396; Thu, 20 Apr
 2023 06:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230319150141.67824-1-robh@kernel.org> <20230319150141.67824-2-robh@kernel.org>
 <20230418175000.GLZD7YSNkIKk8ltGIw@fat_crate.local> <20230419184547.GA4013083-robh@kernel.org>
 <20230419185535.GGZEA5J2ZVxsv5AlBM@fat_crate.local>
In-Reply-To: <20230419185535.GGZEA5J2ZVxsv5AlBM@fat_crate.local>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 20 Apr 2023 08:56:58 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+ruP1cCvcVgG+DLcxZEVAPn2orCtvOrZ9gmEmBqX8jtw@mail.gmail.com>
Message-ID: <CAL_Jsq+ruP1cCvcVgG+DLcxZEVAPn2orCtvOrZ9gmEmBqX8jtw@mail.gmail.com>
Subject: Re: [PATCH 2/2] edac: cpc925: Use of_get_cpu_hwid() to read CPU node 'reg'
To:     Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

+Arnd, Michael E

On Wed, Apr 19, 2023 at 1:55=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Wed, Apr 19, 2023 at 01:45:47PM -0500, Rob Herring wrote:
> > I'd rather not export of_get_cpu_hwid() which is otherwise only used in
> > arch code. I think I'll rewrite this in terms of for_each_possible_cpu(=
)
> > and topology_core_id(). Though that would make a UP build not enable
> > core 1, but that seems undesirable anyways.
>
> TBH I'm not sure this driver is even worth any effort besides simply
> deleting it. I see one commit which reads like someone was really using
> it:
>
> ce395088832b ("cpc925_edac: Support single-processor configurations")
>
> but that one is from 2011 and since then it has received only API
> modifications/cleanups.
>
> But if I delete it, someone might crawl out of the woodwork and say it
> is still used...

Yeah, I came to that conclusion as well. It's only used by "maple"
(aka PPC970FX Evaluation Board) as the kernel has to instantiate this
device (rather than DT). Seems like a 20 year old eval board is
unlikely to have any users, so perhaps the whole platform could be
removed.

Rob
