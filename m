Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E74A318919B
	for <lists+linux-edac@lfdr.de>; Tue, 17 Mar 2020 23:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgCQWug (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 17 Mar 2020 18:50:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51732 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgCQWug (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 17 Mar 2020 18:50:36 -0400
Received: from zn.tnic (p200300EC2F0C96006568A6001794F16F.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9600:6568:a600:1794:f16f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CE3F01EC0C68;
        Tue, 17 Mar 2020 23:50:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584485434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=aQFlj1Te2JyH6tAhRl1we9NkB8tteWbuHNqa4yZWmGg=;
        b=Fjsz9LNz/bpu3rRxfqqw3bzP8Iek2GeeWg6+lGUW73RRWl01PFfQ7PJ5P1My2+c7BnFF2n
        P0pcRcWJrOpiADHKNQNzYAnITwcPiqOEGKD3/MCbIm5cDfpceLMt/ogBchLSBszZIp2npg
        eSiJroIj1KQ15Tr/3XB+mmjPkKNfo6I=
Date:   Tue, 17 Mar 2020 23:50:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kani, Toshi" <toshi.kani@hpe.com>
Cc:     John Garry <john.garry@huawei.com>,
        Robert Richter <rrichter@marvell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        Shiju Jose <shiju.jose@huawei.com>
Subject: Re: [PATCH 11/11] EDAC/ghes: Create one memory controller per
 physical memory array
Message-ID: <20200317225039.GI15609@zn.tnic>
References: <20200306151318.17422-1-rrichter@marvell.com>
 <20200306151318.17422-12-rrichter@marvell.com>
 <20200316095149.GE26126@zn.tnic>
 <924f4c0e-1f9d-e7de-17cd-466eb3a74d90@huawei.com>
 <DF4PR8401MB073186E9C0F1514827781CC582F60@DF4PR8401MB0731.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DF4PR8401MB073186E9C0F1514827781CC582F60@DF4PR8401MB0731.NAMPRD84.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Mar 17, 2020 at 10:14:46PM +0000, Kani, Toshi wrote:
> > > This is all fine and good but that change affects the one x86 platform
> > > we support so the whole patchset should be tested there too. Adding
> > > Toshi.
> 
> Thanks for the heads-up.  I do not have an access to a test system at
> the moment, but am checking my colleague to do the test.

Thx but hold that off for now - Robert is reworking the set.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
