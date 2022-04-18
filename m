Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEB8505F65
	for <lists+linux-edac@lfdr.de>; Mon, 18 Apr 2022 23:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiDRVhi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 18 Apr 2022 17:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiDRVhh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 18 Apr 2022 17:37:37 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72FB5655C;
        Mon, 18 Apr 2022 14:34:57 -0700 (PDT)
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 482EB2034C72;
        Mon, 18 Apr 2022 14:34:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 482EB2034C72
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1650317697;
        bh=vj0lnOdsk0bHFr5EZlPrXDBc40yXZt3qOC1HHQtuVGE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NyyLuiJ0VoRVuAIRC2aoUJ2gtQHHauWDD/gmDJcRNyEvsAl3rD5zEPKVCKdznx+WP
         /PFgtpmyoDfsnCWG6x5WkBIe8W06JLcSj4O/w0ByAxZf2DcEBEG/WAdyPyLKU5A+do
         3py4Q2MusGAI33EDBQQbXFSlU4RdqHHUBRR8xX78=
Date:   Mon, 18 Apr 2022 16:34:53 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Lei Wang <lewan@microsoft.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        Shiping Ji <shiping.linux@gmail.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/dmc520: Don't print an error for each unconfigured
 interrupt line
Message-ID: <20220418213453.GB31854@sequoia>
References: <20220118152816.GA89184@sequoia>
 <Yeb4sK+ZmSHjWPWL@zn.tnic>
 <20220118195401.GB89184@sequoia>
 <YecrXidqecoYI/xg@zn.tnic>
 <YefXQHXNlsxk8yUc@kroah.com>
 <Yefb7zO9p1iPF3Jm@zn.tnic>
 <YefnuCPwMq5V2lgl@kroah.com>
 <20220404215640.GA626436@sequoia>
 <20220418204029.GA31854@sequoia>
 <Yl3UgPtVV3t4pzVe@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl3UgPtVV3t4pzVe@zn.tnic>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 2022-04-18 23:13:36, Borislav Petkov wrote:
> On Mon, Apr 18, 2022 at 03:40:29PM -0500, Tyler Hicks wrote:
> > > The API argument seems to have fizzled out in v2:
> > > 
> > >  https://lore.kernel.org/lkml/20220212201631.12648-1-s.shtylyov@omp.ru/
> 
> I don't see those two upstream yet, on a quick glance. Perhaps in Greg's tree?
> 
> Greg, what's the latest with that platform_get_*_optional() fun?
> 
> Also, the second of those two patches above has:
> 
> + * Return: non-zero IRQ number on success, 0 if IRQ wasn't found, negative error
> + * number on failure.
>   */
>  int platform_get_irq_byname_optional(struct platform_device *dev,
> 
> and your patch does:
> 
> +		irq = platform_get_irq_byname_optional(pdev, dmc520_irq_configs[idx].name);
>  		irqs[idx] = irq;
> 
> so on failure, it would still write the negative error value in
> irqs[idx].
> 
> How can that be right?

The patches to modify the API have become stale. There have been no
new comments or revisions since Feb. What I'm proposing is to proceed
with merging this simple fix and let the folks discussing the API
changes adjust the use in the dmc250 driver if/when they decide to
revive the API changes.

Tyler

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 
