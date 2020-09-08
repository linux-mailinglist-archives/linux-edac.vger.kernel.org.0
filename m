Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4387261CA4
	for <lists+linux-edac@lfdr.de>; Tue,  8 Sep 2020 21:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731575AbgIHTYS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 8 Sep 2020 15:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731044AbgIHTYI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 8 Sep 2020 15:24:08 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BD6C061573;
        Tue,  8 Sep 2020 12:24:08 -0700 (PDT)
Received: from zn.tnic (p200300ec2f10bf0059bdf9fa8e813382.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:bf00:59bd:f9fa:8e81:3382])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 023761EC02B9;
        Tue,  8 Sep 2020 21:24:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599593046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ro+A4oaZan++1bEEF78omLXWyttKgPI68af9UKTgJos=;
        b=iYMrYMz9RzyMu+adm6Rv7xJxg/qLEoDX6oFI8DRIhty6zebS5PUUSzW93MiQ+drODzcq4v
        bWzhGMUw4zUKSLuDxsGDAsgRQM40ganzushZ2UZ4x5NkvR1X94uT7ueS+4np5IcF/XTPtD
        hctrYRFJhtan1tDX8AzHYFvTM5BCNRI=
Date:   Tue, 8 Sep 2020 21:24:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Gregor Herburger <gregor.herburger@ew.tq-group.com>
Cc:     "york.sun@nxp.com" <york.sun@nxp.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rrichter@marvell.com" <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] edac: fsl_ddr_edac: fix expected data message
Message-ID: <20200908192400.GL25236@zn.tnic>
References: <kcEE.e0qfoTd8SOOr3lTVWaXz/A.AASg8YeC1gE@vtuxmail01.tq-net.de>
 <20200904091718.GC21499@zn.tnic>
 <20200904133258.GA21716@herburgerg-w.tq-net.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200904133258.GA21716@herburgerg-w.tq-net.de>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Sep 04, 2020 at 03:32:58PM +0200, Gregor Herburger wrote:
> That shouldn't happen. The whole if-block is only executed when a single 
> bit correctable error has occured (DDR_EDE_SBE). So we always should have
> bad_data_bit or bad_ecc_bit (exclusively).

Ooh, that sbe_ecc_decode() function would give you either the data bit
- if that one is in error - and if not the data bit, then the ECC bit.
Aha.

Ok, so what the driver should do, IMO, is this:

	if (bad_data_bit != -1) {
		...

		fsl_mc_printk("Single-bit data error, ... ", bad_data_bit);
		fsl_mc_printk("Expected Data/Captured Data, ... ", exp_high, exp_low, cap_high, cap_low);
	}

	if (bad_ecc_bit != -1) {
		...

		fsl_mc_printk("Single-bit ECC error, ... ", bad_ecc_bit);
		fsl_mc_printk("Expected ECC/Captured ECC, ... ", exp_syndrome, syndrome);
	}

This way you only print either the data or the ECC value which was in
error but not both.

Makes sense?

> Also i just noticed in the kernel log is no hint that this is an
> single bit error. Maybe we should add this too?

Yap, see above.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
