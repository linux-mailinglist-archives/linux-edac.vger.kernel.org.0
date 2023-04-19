Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADD76E8165
	for <lists+linux-edac@lfdr.de>; Wed, 19 Apr 2023 20:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjDSSpw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 19 Apr 2023 14:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjDSSpu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 19 Apr 2023 14:45:50 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980015B94;
        Wed, 19 Apr 2023 11:45:49 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-546dad86345so24126eaf.0;
        Wed, 19 Apr 2023 11:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681929949; x=1684521949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1u6wDxEFqR3nc6mJ3LnzSqMuNsw7ywTC5vr5ltaIYE=;
        b=EnBHRGivCscuuUaZmAPe+RUmmO/9vv1gBwh4vQyhZ6JIwSG+7ZJNsGZRhBqm2jpFD0
         xypN5PLW9bm69fnBmT43nYLzGUfaX7nqq1+WOuEiBKXGyx+VqwK5h0I9kxw4vo/jlzKB
         9l19bQvfBbkoPI1vK5oKdF9UJAB/NrgyodOueDZZVs+ezr4+7V8Gk0Zl9hiO8nA6pPtN
         H8CK2DUUgZszgPL85p5aznR8ZPqxAUaoXozBp67AFB27JyTHIgEXoY1/7Lb9FVGzibdk
         HzFgYmjfV5yE/mdyK8e6YTApi9KHiHR9RWJYxgvYMsHvuRBhM2vNiayFjK+6qTUAZW7p
         T0rA==
X-Gm-Message-State: AAQBX9cYPAR9mPRSrRaWkig3mKnrneIzUBB2rM/R1UigvW/98CquPDwn
        /yubfLv/8O5afkn1pSDBPg==
X-Google-Smtp-Source: AKy350axA4KSuP1rGO4qpDY6pI13A7IRsrcc2RYlSrdOQlat0tH+KBoNonedj/aMdVHHSE2OXUdVHA==
X-Received: by 2002:a05:6808:1382:b0:387:1a46:8317 with SMTP id c2-20020a056808138200b003871a468317mr4028314oiw.13.1681929948854;
        Wed, 19 Apr 2023 11:45:48 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z9-20020a4a9849000000b005413682e16dsm7390043ooi.3.2023.04.19.11.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 11:45:48 -0700 (PDT)
Received: (nullmailer pid 513861 invoked by uid 1000);
        Wed, 19 Apr 2023 18:45:47 -0000
Date:   Wed, 19 Apr 2023 13:45:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] edac: cpc925: Use of_get_cpu_hwid() to read CPU node
 'reg'
Message-ID: <20230419184547.GA4013083-robh@kernel.org>
References: <20230319150141.67824-1-robh@kernel.org>
 <20230319150141.67824-2-robh@kernel.org>
 <20230418175000.GLZD7YSNkIKk8ltGIw@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418175000.GLZD7YSNkIKk8ltGIw@fat_crate.local>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Apr 18, 2023 at 07:50:00PM +0200, Borislav Petkov wrote:
> On Sun, Mar 19, 2023 at 10:01:41AM -0500, Rob Herring wrote:
> > Replace open coded reading of CPU nodes' "reg" properties with
> > of_get_cpu_hwid() dedicated for this purpose.
> > 
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/edac/cpc925_edac.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/edac/cpc925_edac.c b/drivers/edac/cpc925_edac.c
> > index ee193aae8e14..0182436c1b5a 100644
> > --- a/drivers/edac/cpc925_edac.c
> > +++ b/drivers/edac/cpc925_edac.c
> > @@ -557,13 +557,13 @@ static u32 cpc925_cpu_mask_disabled(void)
> >  	mask = APIMASK_ADI0 | APIMASK_ADI1;
> >  
> >  	for_each_of_cpu_node(cpunode) {
> > -		const u32 *reg = of_get_property(cpunode, "reg", NULL);
> > -		if (reg == NULL || *reg > 2) {
> > +		int hwid = of_get_cpu_hwid(cpunode, 0);
> > +		if ((hwid < 0) || (hwid > 2)) {
> >  			cpc925_printk(KERN_ERR, "Bad reg value at %pOF\n", cpunode);
> >  			continue;
> >  		}
> >  
> > -		mask &= ~APIMASK_ADI(*reg);
> > +		mask &= ~APIMASK_ADI(hwid);
> >  	}
> >  
> >  	if (mask != (APIMASK_ADI0 | APIMASK_ADI1)) {
> > -- 
> 
> $ grep CPC925 .config
> CONFIG_EDAC_CPC925=m
> 
> $ make ARCH=powerpc CROSS_COMPILE=/home/boris/src/crosstool/gcc-11.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-
> ...
> ERROR: modpost: ".of_get_cpu_hwid" [drivers/edac/cpc925_edac.ko] undefined!
> make[1]: *** [scripts/Makefile.modpost:136: Module.symvers] Error 1
> make: *** [Makefile:1980: modpost] Error 2

I'd rather not export of_get_cpu_hwid() which is otherwise only used in 
arch code. I think I'll rewrite this in terms of for_each_possible_cpu() 
and topology_core_id(). Though that would make a UP build not enable 
core 1, but that seems undesirable anyways. 

Rob
