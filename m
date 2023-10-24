Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E15B7D4C20
	for <lists+linux-edac@lfdr.de>; Tue, 24 Oct 2023 11:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbjJXJ1Y (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 24 Oct 2023 05:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234192AbjJXJ1N (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 24 Oct 2023 05:27:13 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950231FC0
        for <linux-edac@vger.kernel.org>; Tue, 24 Oct 2023 02:26:15 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 579EC40E0187;
        Tue, 24 Oct 2023 09:26:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kik5hvMGOi02; Tue, 24 Oct 2023 09:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1698139564; bh=E4hYJogHHGbEOQLtiBuOG6cokxYAHPSvKDp3Qz0OQNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TvkB9+szKfwLhuwKGlIxV8fJMnZyA9UsReK4AacoQA76gR1l6jJ3mWMDdPRSGWfto
         dFhckXjxqp3npNBkxSY1HR475ON8yVylIfARBBcz1XBLyCb7TlFocTR3T4fymp4hT2
         y/QxDBrR3AcVUmnboA6tfNaNHUcg5z2bJIAWSP3XBBTIygMXkWKdH+6HB1zEDPhJyW
         3X7erb9XOjqtRxJ3LSz/ygVXXs9Jn9Cgn+h+Cmxnfeu2ticNYMxhOI4gT2I0Bd8ncE
         PfJRFmDL+FjTRmv5bTvsXHCugaLueGdmh1I3OkMY4zw9W1fwL6WI123H46ZeU80GXn
         5wVv5kQSuXxEG6amsZ5WvSHeIEfEyUeIFUz6pZi4kt3HUy9/FlMZF8YkwhvOIO/8Zl
         dLXDZvFYDmk/5i1d+dgFb8wzYy+7hEE0bxUnxQgbCArrOmTS/hhMogeWqs/dX20XF0
         5P1TjRCiXuRbpd2HfNOgNIqqobqhl8ZexYBRo0UPN/IbULnIkNU2f7HY8qtqwIe9CQ
         8DDr3k6y0MhYAHyJfWRR5Md0A3w3yJkW2SZZqBoZQxS8URpyzFlr5JTU5vC1HY9b42
         31MIkhbmxUhFIZlqv59K7e5OdnxEbvy2HMEHzUZWG4pJzP2LCkFveW0eAvj/VF10zZ
         9qKe0L3aLeep+SXKYcXW6D2k=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EF73640E0196;
        Tue, 24 Oct 2023 09:26:00 +0000 (UTC)
Date:   Tue, 24 Oct 2023 11:25:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [bug report] EDAC/versal: Add a Xilinx Versal memory controller
 driver
Message-ID: <20231024092554.GAZTeNoqT7HQQzb08U@fat_crate.local>
References: <a4db6f93-8e5f-4d55-a7b8-b5a987d48a58@moroto.mountain>
 <20231020154142.GFZTKftpt4HTM4tpkH@fat_crate.local>
 <BY5PR12MB490268A93CEC6B074DA6196281DFA@BY5PR12MB4902.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BY5PR12MB490268A93CEC6B074DA6196281DFA@BY5PR12MB4902.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Oct 24, 2023 at 05:43:59AM +0000, Datta, Shubhrajyoti wrote:
> Thanks sent the patch.

This is not how this works: you either agree with the diff and reply
with an Acked-by or you don't agree and you say why.

What you don't do is take someone else's diff and slap your name on it
without asking for permission first.

Take some time to read about the development process in
Documentation/process/ to get acquainted with how Linux development
works.

> > I guess something like this ontop:
> >
> > diff --git a/drivers/edac/versal_edac.c b/drivers/edac/versal_edac.c index
> > 08f630185913..87e730dfefa0 100644
> > --- a/drivers/edac/versal_edac.c
> > +++ b/drivers/edac/versal_edac.c
> > @@ -962,10 +962,8 @@ static int mc_probe(struct platform_device *pdev)
> >         if (!get_ecc_state(ddrmc_baseaddr))
> >                 return -ENXIO;
> >
> > -       /* Allocate ID number for our EMIF controller */
> > +       /* Allocate ID number for the EMIF controller */
> >         edac_mc_id = emif_get_id(pdev->dev.of_node);
> > -       if (edac_mc_id < 0)
> > -               return -EINVAL;
> >
> >         regval = readl(ddrmc_baseaddr + XDDR_REG_CONFIG0_OFFSET);
> >         num_chans = FIELD_PREP(XDDR_REG_CONFIG0_NUM_CHANS_MASK,
> > regval);

As to this - I already merged it with the driver patch as it was the
topmost one on the branch.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
