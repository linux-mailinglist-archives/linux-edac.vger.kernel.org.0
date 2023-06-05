Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FAB722DC2
	for <lists+linux-edac@lfdr.de>; Mon,  5 Jun 2023 19:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjFERlN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 5 Jun 2023 13:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjFERlM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 5 Jun 2023 13:41:12 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E0E91
        for <linux-edac@vger.kernel.org>; Mon,  5 Jun 2023 10:41:10 -0700 (PDT)
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7C6EC1EC064A;
        Mon,  5 Jun 2023 19:41:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1685986868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=eUuT3U/RqAKo5MHTy+pSdoYbm9/AKy1U3qZ1r6S7tAo=;
        b=C9pGLEGiY0LQguX2fM2Z8L2mrpFWhD9HIjX3qv0Qsf1ajq0Xv/sSyrV1uAuuJt41QMYwQZ
        RFFuJdVjXXKH3N5Xcm8JAKYfPEW1mwGFs2uITECfPMjzPIZMM8NbLy2BcihKFEhEcdnWPK
        VYR8rIKFeYknXq3sGdGucKCiVYre+tE=
Date:   Mon, 5 Jun 2023 19:41:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Aristeu Rozanski <aris@ruivo.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Aristeu Rozanski <aris@redhat.com>
Subject: Re: [PATCH] mce: prevent concurrent polling of MCE events
Message-ID: <20230605174104.GBZH4eMLx1cp+nQJH2@fat_crate.local>
References: <20230515143225.GC4090740@cathedrallabs.org>
 <20230515145227.GGZGJHKyH9sAfToD03@fat_crate.local>
 <SJ1PR11MB6083576B4BE589D6F04559A5FC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230515183050.GJZGJ6Wsmr4Yf/H5Ps@fat_crate.local>
 <SJ1PR11MB6083DC9538CDB6E7FA8B803BFC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230515194423.GKZGKLl+8mJiLoJAp1@fat_crate.local>
 <SJ1PR11MB6083B867B6B95820366C08BDFC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230523141523.GL4090740@cathedrallabs.org>
 <20230604160442.GN4090740@cathedrallabs.org>
 <SJ1PR11MB60830E9036D6D0181CF9CFD4FC4DA@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB60830E9036D6D0181CF9CFD4FC4DA@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jun 05, 2023 at 03:33:48PM +0000, Luck, Tony wrote:
> Since mce=no_cmci is a supported mode, and end-users are making use
> of it on production systems ... I think Linux needs a patch to prevent multiple
> CPUs logging the same error.
> 
> I don't have any other ideas

I have some:

1. One can teach mce_gen_pool_add() to scan what's already on the list
   and drop duplicate errors. Not sure if it is worth it.

or

2. Carve out that abysmal locking into a function called
   poll_cmci_disabled() or so, run this function only on CMCI machines
   and make sure the use case is properly explained in the commit
   message.

I have no clue what "they can use thresholding to signal UCNA without
signaling any corrected events and it won't work with CMCI enabled."

I thought HP use firmware first and all that magic EFI gunk to do RAS
and don't rely on OS facilities. Oh well...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
