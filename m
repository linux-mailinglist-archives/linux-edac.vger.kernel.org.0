Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36FC41CF298
	for <lists+linux-edac@lfdr.de>; Tue, 12 May 2020 12:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgELKfH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 12 May 2020 06:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729474AbgELKfH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 12 May 2020 06:35:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC9AC061A0C
        for <linux-edac@vger.kernel.org>; Tue, 12 May 2020 03:35:07 -0700 (PDT)
Received: from zn.tnic (p200300EC2F0A9D0028B27B2F0E97CDFB.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:9d00:28b2:7b2f:e97:cdfb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D21C21EC0324;
        Tue, 12 May 2020 12:35:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1589279705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V/fmXKG0JB9zHK/kK73qevMrMCJJO9yZ3hsgzZOxL/w=;
        b=dVpRTmwd8IJNXJ/yr9xyW2OF73KW2L4n+gAYpBuHJED/3TEuvjhd8CEU4m7aZjlBMXqxLc
        XmB+5EPhhUhdclg2D0FH+VToE6M8g5KKH7UPvU+UCepkM5Rx78XT5NZvrSsITW8d08x6Wc
        dVMFeBli4tMmZJNMHYYTPNnLZvPb+HM=
Date:   Tue, 12 May 2020 12:35:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Hawa, Hanna" <hhhawa@amazon.com>
Cc:     "james.morse@arm.com" <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Krupnik, Ronen" <ronenk@amazon.com>, talel@amazon.com,
        jonnyc@amazon.com, "Hanoch, Uri" <hanochu@amazon.com>
Subject: Re: [RFC] Support different block names with same EDAC device
Message-ID: <20200512103500.GA6859@zn.tnic>
References: <0ae313a4-97c3-5681-f22c-23decb261b74@amazon.com>
 <20200511135507.GC25861@zn.tnic>
 <2fc308f9-47d6-7c75-775b-3f6579dfe571@amazon.com>
 <20200511142619.GD25861@zn.tnic>
 <50666803-ed9d-670a-e9a0-994547e4cdf8@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50666803-ed9d-670a-e9a0-994547e4cdf8@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, May 12, 2020 at 11:47:06AM +0300, Hawa, Hanna wrote:
> pcie/pcie0/..
>           /axi_write_parity_error/ce_count
>                                  /ue_count
>           /axi_read_parity_error/ce_count
>                                 /ue_count
>           /completion_timeout/ce_count
>                              /ue_count
>           /write_overflow_error/ce_count
>                                /ue_count
>           /parity_error/ce_count
>                        /ue_count
> 
> same for pcie1/pcie2

The "...pci" layout on my box looks like this:

$ tree /sys/devices/system/edac/pci/
/sys/devices/system/edac/pci/
├── check_pci_errors
├── edac_pci_log_npe
├── edac_pci_log_pe
├── edac_pci_panic_on_pe
├── pci0
│   ├── device -> ../../../../pci0000:00/0000:00:18.0
│   ├── npe_count
│   └── pe_count
├── pci_nonparity_count
└── pci_parity_count

so what's wrong with having "pcie0, pcie1, pcie2, ..." for those
different functional units?

I guess you could add a "name" node so that you have:

pcie
|-> pcie0
    |-> name:	axi_write_parity_error
    |-> ce_count
    |-> ue_count

and so on so that tools can know what those FUs are.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
