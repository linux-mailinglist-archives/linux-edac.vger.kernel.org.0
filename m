Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D217296D3
	for <lists+linux-edac@lfdr.de>; Fri,  9 Jun 2023 12:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238764AbjFIK2g (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 9 Jun 2023 06:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238843AbjFIK2J (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 9 Jun 2023 06:28:09 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5120184
        for <linux-edac@vger.kernel.org>; Fri,  9 Jun 2023 03:18:04 -0700 (PDT)
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B9D191EC0304;
        Fri,  9 Jun 2023 12:18:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686305882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XHqrJ4OjN4Wq/QV9B5FtMDdPnCSzpUhGiqUtrexb0Iw=;
        b=Zb9C12fxPtI4a+XA/C8tzErzokwoyrvjRzzYPPCTTbT3SgDY0hWiKlXiKCDoqX1fteXlc0
        5JCh05Qk8TVOPaLuyFtwzRh5BH4vjtSzjB4l8y42loHosUZCcAeqvQZUiUwjBnUMJE6EpP
        HSRLJ5b4DAAwgSl9q1u7o3aJcJjCbc4=
Date:   Fri, 9 Jun 2023 12:17:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Aristeu Rozanski <aris@ruivo.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Aristeu Rozanski <aris@redhat.com>
Subject: Re: [PATCH] mce: prevent concurrent polling of MCE events
Message-ID: <20230609101757.GAZIL8VaLwAckejYZt@fat_crate.local>
References: <20230605193000.GDZH43uFhBmQfSO+9D@fat_crate.local>
 <20230605203315.GR4090740@cathedrallabs.org>
 <20230605205658.GFZH5MGg2QizffZRte@fat_crate.local>
 <20230605210108.GS4090740@cathedrallabs.org>
 <20230605210610.GGZH5OQkeWMXGZzxhR@fat_crate.local>
 <20230605215839.GT4090740@cathedrallabs.org>
 <20230606082541.GAZH7thXcj7SatSNtO@fat_crate.local>
 <20230606140011.GU4090740@cathedrallabs.org>
 <20230606140848.GCZH898MYjw6+b2yux@fat_crate.local>
 <SJ1PR11MB6083807C3144C28B3E30840DFC51A@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083807C3144C28B3E30840DFC51A@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jun 09, 2023 at 12:26:56AM +0000, Luck, Tony wrote:
> > Independent of that, yes, we will try not to pollute it with duplicates
> > once we know what the issue exactly is which makes people disable CMCI.
> 
> I talked to the vendor today. They have customers who want the OS to see
> all reported corrected errors, but they also need to have their firmware keep
> logs of all uncorrected errors (so their field engineers can replace the DIMMs
> that are throwing the UC errors).
> 
> Intel machine check architecture has conflated processing of corrected errors
> and "UCNA" (the log that comes from the memory controller when ECC says
> the error is uncorrected ... this is distinct from the log that comes from the core
> when the poison data is consumed and signals a machine check).

I'd expect poison data consumption not to be a "UCNA" - i.e., "No
Action" required :)

> So the closest they can get to meeting both the customer requirement and
> their service requirement is to have their BIOS configure to get an SMI for
> the UCNA *and* tell the users to run in mce=no_cmci mode. If Linux enables
> CMCI, then the h/w will also generate an SMI for every corrected error. Neither
> the customer, nor the vendor wants that overhead.
> 
> Bottom line: This is a legitimate, production, use case.

Ok, that makes more sense.

Thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
