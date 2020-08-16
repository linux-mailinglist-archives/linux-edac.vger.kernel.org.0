Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01802456B8
	for <lists+linux-edac@lfdr.de>; Sun, 16 Aug 2020 10:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgHPIm3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 16 Aug 2020 04:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgHPImU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 16 Aug 2020 04:42:20 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99245C061756
        for <linux-edac@vger.kernel.org>; Sun, 16 Aug 2020 01:42:20 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id kr4so6298205pjb.2
        for <linux-edac@vger.kernel.org>; Sun, 16 Aug 2020 01:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+ffQF0HI1gLp7PT0Q8NYPgtaN7HeDCX21KlzJjN+WPw=;
        b=PTWwhQfioyPzijM36MU9jM7ca3z3tUkKRrP66DH/FWebA6DHNIRrCDLQB6zTRRAafq
         qkJPRVUZ9cSN2ydyupfWqmbv2kSSZEUJyyfdv30Yinpkcp+pgDPerILKppHv/uRAW7Rq
         01iljslS0p65gjpork2HqvZfq/hG+51dhpiFgurfhgkh6VAbah8hmz9xhs8RDvGO7umh
         72W6HV2Ak2U/OySzl8d8YYh6zqcm41hFIouAO5daAdlaqeOyky7btyB7FPUfuG4mtW8l
         Dt6S25Iz960nuCoi6SKM0xo8eHcm3b09KUENInOeLtNfEJwY95KhoWNX/TpZDHUVrHi+
         XPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+ffQF0HI1gLp7PT0Q8NYPgtaN7HeDCX21KlzJjN+WPw=;
        b=qymKIzYAH30FK4Cg/04B/pfUm5ZGYmbY9k+sy5F9XMyDriIOKrxse0vG9InOIH/5k4
         caFY5TppDSPeoTgGdKO09W3XsKyBXVVrFq/53RoL8re7WKrP4uFuPRm+XLRpA7F8OcFm
         NIn4ynUj1re4YgCUr5nxkcZlkla48nYeFPvK0/vIikS27c45Cv0tNIuHftSuvV627o7w
         nN1GN3UYkmIOJuOFmiZrJpGo1JPDwdm4LWysGclcZwWH3dMscExIcFdQjWWsOkhLwOG3
         xpRSnI5nNDFPtWu8eu4GfyyKXSuKHsdiWuAI6gvV6azFtDjexri6eylqAdujhBJJf6qI
         PjBw==
X-Gm-Message-State: AOAM5305rhmcLlNDw5LtU8bzr3kFKJjiP31lXeHCZK8x968+mo6+nLhn
        0U1fdaumosZMR+CSxINeFg==
X-Google-Smtp-Source: ABdhPJwHmu/qi5cTWkTnwCuvaGfWf72wryCcuu2I7cc2ZbskfXnDmtJTZHlYsjhgwfemd2E2Zm653w==
X-Received: by 2002:a17:902:c1d1:: with SMTP id c17mr7155329plc.165.1597567340027;
        Sun, 16 Aug 2020 01:42:20 -0700 (PDT)
Received: from madhuparna-HP-Notebook ([2402:3a80:cea:b074:8100:367f:a3dd:e679])
        by smtp.gmail.com with ESMTPSA id d22sm14799579pfd.42.2020.08.16.01.42.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Aug 2020 01:42:19 -0700 (PDT)
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
X-Google-Original-From: Madhuparna Bhowmik <change_this_user_name@gmail.com>
Date:   Sun, 16 Aug 2020 14:12:13 +0530
To:     Borislav Petkov <bp@alien8.de>
Cc:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        andrianov <andrianov@ispras.ru>, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rrichter@marvell.com,
        linux-edac@vger.kernel.org
Subject: Re: Regarding bug in drivers/edac/x38_edac.c
Message-ID: <20200816084213.GA15146@madhuparna-HP-Notebook>
References: <CAD=jOEZ9t4ztYtPKL9B1KA9=f4mniu6-bF_1-JWoPKJTE0kiaw@mail.gmail.com>
 <20200816070621.GB21914@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200816070621.GB21914@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Aug 16, 2020 at 09:06:21AM +0200, Borislav Petkov wrote:
> On Sun, Aug 16, 2020 at 12:05:57PM +0530, Madhuparna Bhowmik wrote:
> > 2. Even if we ignore the 1st point above and probe is called after init
> > finishes,
> 
> AFAIR and if you don't have any async probing (which I don't believe for
> this driver or for any other EDAC driver), the ->probe() function gets
> called during pci_register_driver(). From the docs:
> 
> Documentation/PCI/pci.rst:
> 
> "pci_register_driver() call
> ==========================
> 
> ...
> 
> Once added, the driver probe routine will be invoked for any unclaimed
> PCI devices listed in its (newly updated) pci_ids list."
> 
> You could verify that by adding some debugging printks to a driver's
> probe function.
> 
> I believe it ends up somewhere in the driver core, looks like in
> 
> really_probe():
> 
>         if (dev->bus->probe) {
>                 ret = dev->bus->probe(dev);
> 
> in drivers/base/dd.c but I could be mistaken.
> 
> > In general, calling the probe function from init itself is a bit strange.
> 
> Yes, that is ugly - the init function tries what the probe function has
> already tried, again.
> 
> But I don't think either 1. or 2. of yours happens - it is actually
> clumsy but the mci_pdev is simply a check to verify whether the
> ->probe() succeeded and try it again.
>
Thanks a lot for clarifying this.

> Now, if you have that hardware, you could verify all that but I think
> the reality is, I don't think anyone uses that hardware anymore and we
> will remove them at some point in the future so you might wanna look at
> some other drivers which *actually* are still in use.
>
Alright, makes sense.

Regards,
Madhuparna

> :-)
> 
> HTH.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
