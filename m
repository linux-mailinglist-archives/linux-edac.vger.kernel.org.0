Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44B21CFED2
	for <lists+linux-edac@lfdr.de>; Tue, 12 May 2020 22:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbgELUBb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 12 May 2020 16:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgELUBa (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 12 May 2020 16:01:30 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50061C061A0C
        for <linux-edac@vger.kernel.org>; Tue, 12 May 2020 13:01:30 -0700 (PDT)
Received: from zn.tnic (p200300EC2F0A9D00453FDBD40815C9C6.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:9d00:453f:dbd4:815:c9c6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A21401EC02A1;
        Tue, 12 May 2020 22:01:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1589313688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=F1JSzXFshSKUMA8I/Y00shKYc00dzEpUFFErf8jm7uU=;
        b=CPsW/TarhF82omQoyF7Likq7axYMUV2bpiM0I604HmOmQ85SbHYw0IRYKqiHitrrgiIG7x
        AnnYf3VusIYp809kwArec2mJw87cJrBoaH8uQx0sWt3woU65tPdpq/p4IRVAFkZqkZDlxC
        rtW5koDq004EXreDYpHlnMLe+0LCti4=
Date:   Tue, 12 May 2020 22:01:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Hawa, Hanna" <hhhawa@amazon.com>
Cc:     "james.morse@arm.com" <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Krupnik, Ronen" <ronenk@amazon.com>, talel@amazon.com,
        jonnyc@amazon.com, "Hanoch, Uri" <hanochu@amazon.com>
Subject: Re: [RFC] Support different block names with same EDAC device
Message-ID: <20200512200123.GE6859@zn.tnic>
References: <0ae313a4-97c3-5681-f22c-23decb261b74@amazon.com>
 <20200511135507.GC25861@zn.tnic>
 <2fc308f9-47d6-7c75-775b-3f6579dfe571@amazon.com>
 <20200511142619.GD25861@zn.tnic>
 <50666803-ed9d-670a-e9a0-994547e4cdf8@amazon.com>
 <20200512103500.GA6859@zn.tnic>
 <d4886b17-3d69-2cd0-2999-6eb10e3d5926@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d4886b17-3d69-2cd0-2999-6eb10e3d5926@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, May 12, 2020 at 10:27:07PM +0300, Hawa, Hanna wrote:
> The pci layout on EDAC supports counters for parity/non parity errors. We
> are searching for something more general. To add more error for PCIe layout,
> to have counters, and to control panic flag per error.

Looking at edac_device_alloc_ctl_info(), reading the doc section I
pointed you at earlier and then maybe extending that function - if
needed - is what I'd do. After having looked how the others call it.

But you cannot break the existing drivers - adding new
functionality/sysfs nodes etc should be fine, of course.

> Didn't get your suggestion, where can I add name?

See above.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
