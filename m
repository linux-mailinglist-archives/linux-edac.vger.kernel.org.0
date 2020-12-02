Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02102CB57C
	for <lists+linux-edac@lfdr.de>; Wed,  2 Dec 2020 08:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387600AbgLBHDc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 2 Dec 2020 02:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387511AbgLBHDb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 2 Dec 2020 02:03:31 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC64C0613CF;
        Tue,  1 Dec 2020 23:02:51 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id v11so357336qtq.12;
        Tue, 01 Dec 2020 23:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K/LW+Nm7CzY8OBZABUof+7+4pClm6pGGCifwBOr9FSo=;
        b=nml25srvIDgKr6LK5pmS34VajNkmFjkz00YZSGgbSDcrSP95OpRfV4p43e7K12yNQ8
         K0tG/d4v6e6xYCWAWdcu504tuMzyM9sOXQ7dicvJwlJkVAcUjz80FdAAMxnDNcn3YhNj
         M+JDjHRebHX5h/mHmSEt97z54+MDB4ZlKFIh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K/LW+Nm7CzY8OBZABUof+7+4pClm6pGGCifwBOr9FSo=;
        b=Cgy6DWxfRYmHQW0nhZUKM/iM/wvLoi1ADAZ23I/sm4w/ppBrvDOSW+bMjtFpP47TtW
         zUBthH+7yoOvpLQoDr1I0rSLnn2RhLhrrrFpQflt/s9uIoEU06MjPgwdD29g6PfRK7Bs
         FnH0+6BM5VWR8vC0yotsdnPAeOBb0OzbL0aKO/d0004hhj5vawfEO6OPby3t2tM/HpRq
         jvIxiLPUIUZMDVnX6LFg0HjCkkOcFG2urG4/dJ8czKLjhzA6u+J6J7I94Dbs9eb+9MQg
         +8mEoHson6uCfVBEtp3jNvaDi5xeplA/FFgXH7sh++WgMc6oyCLc+nFyvOaASpl86Ean
         Py3g==
X-Gm-Message-State: AOAM533zR6Ptg6tldPa0EmAQ1JHKq+GObSewqOcAxy5VZdLViFpJCnAr
        jQjsBNvLolki0i63zu0kuKV4N9bHoI/ILyVz2/0=
X-Google-Smtp-Source: ABdhPJzO8P9uYlPvdQcAIvJtcX07Y7BQWFF26rgVDS0nYTsEGEzjj1FFaVdSjTQ44wpFZcDyzJ5EkJjcaZ2Mh3e8Pxc=
X-Received: by 2002:aed:38c8:: with SMTP id k66mr1234725qte.385.1606892570752;
 Tue, 01 Dec 2020 23:02:50 -0800 (PST)
MIME-Version: 1.0
References: <20201202063612.21241-1-troy_lee@aspeedtech.com> <20201202063612.21241-2-troy_lee@aspeedtech.com>
In-Reply-To: <20201202063612.21241-2-troy_lee@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 2 Dec 2020 07:02:38 +0000
Message-ID: <CACPK8XeMdz70aH59zR1GjD6+r+68Y46qhreTw0AG7bzctCtxCg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ARM: dts: aspeed: Add AST2600 edac into common devicetree
To:     Troy Lee <troy_lee@aspeedtech.com>
Cc:     Stefan Schaeckeler <sschaeck@cisco.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>,
        leetroy@gmail.com, Ryan Chen <ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, 2 Dec 2020 at 06:37, Troy Lee <troy_lee@aspeedtech.com> wrote:
>
> Adding Aspeed AST2600 edac node into common devicetree.
>
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  arch/arm/boot/dts/aspeed-g6.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> index 97ca743363d7..fb144515f397 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -69,6 +69,12 @@
>                 always-on;
>         };
>
> +       edac: sdram@1e6e0000 {
> +               compatible = "aspeed,ast2600-sdram-edac", "syscon";
> +               reg = <0x1e6e0000 0x174>;
> +               interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> +       };
> +
>         ahb {
>                 compatible = "simple-bus";
>                 #address-cells = <1>;
> --
> 2.17.1
>
