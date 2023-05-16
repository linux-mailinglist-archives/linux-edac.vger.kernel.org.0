Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062B37054B3
	for <lists+linux-edac@lfdr.de>; Tue, 16 May 2023 19:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjEPRIj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 May 2023 13:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjEPRIi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 May 2023 13:08:38 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14483588
        for <linux-edac@vger.kernel.org>; Tue, 16 May 2023 10:08:37 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 583981EC0478;
        Tue, 16 May 2023 19:08:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1684256916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fxZ3bYuy4gAzyfnn+2Yt5EUHWEN7HeJuHr9KE49MfDk=;
        b=B9iLtXBXnfmADkiNsO0c/4LU+X2LKfGb6PMLHSW0afLwqR9on5EKoblX22SGIWA+tRpxWf
        jcbx7qNp7gxpQuhCMNx37xUwE0IMrR6WOOw6bwt4wA0RQskpT01tdie32QHTGf/wzlQg8p
        8uR5FrAS7MWK9k4AH2gGyIY/efKAOac=
Date:   Tue, 16 May 2023 19:08:32 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Aristeu Rozanski <aris@ruivo.org>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Aristeu Rozanski <aris@redhat.com>
Subject: Re: [PATCH] mce: prevent concurrent polling of MCE events
Message-ID: <20230516170832.GEZGO4kBfDxzBiW6oM@fat_crate.local>
References: <20230515143225.GC4090740@cathedrallabs.org>
 <20230515145227.GGZGJHKyH9sAfToD03@fat_crate.local>
 <SJ1PR11MB6083576B4BE589D6F04559A5FC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230515183050.GJZGJ6Wsmr4Yf/H5Ps@fat_crate.local>
 <SJ1PR11MB6083DC9538CDB6E7FA8B803BFC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230515194423.GKZGKLl+8mJiLoJAp1@fat_crate.local>
 <SJ1PR11MB6083B867B6B95820366C08BDFC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230515202057.GD4090740@cathedrallabs.org>
 <SJ1PR11MB6083A169CC5FD7057338027AFC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230515203220.GE4090740@cathedrallabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230515203220.GE4090740@cathedrallabs.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, May 15, 2023 at 04:32:20PM -0400, Aristeu Rozanski wrote:
> On Mon, May 15, 2023 at 08:27:19PM +0000, Luck, Tony wrote:
> > If CMCI storms are their problem ... perhaps this is an answer:
> > 
> > https://lore.kernel.org/all/20230411173841.70491-1-tony.luck@intel.com/
> 
> Apparently they're disabling CMCI for CE and UCNA events when OS-first is
> enabled for two entire lines of products. So there might be more behind
> this than I suspected. I just sent a message to their engineers to find out
> what's going on.

Might also ask them to test Tony's patches, see whether they help.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
