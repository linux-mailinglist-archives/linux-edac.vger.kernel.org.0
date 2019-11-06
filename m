Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAE5AF1F55
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2019 20:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfKFTyX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Nov 2019 14:54:23 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59020 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfKFTyX (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 6 Nov 2019 14:54:23 -0500
Received: from zn.tnic (p200300EC2F0E770015F12088A3A733FB.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:7700:15f1:2088:a3a7:33fb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A7E991EC0C0A;
        Wed,  6 Nov 2019 20:54:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573070058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NqnKZD7v5vhUknGzYXDmsscw3ntoXp0LPGStz0LieMA=;
        b=FZuZXf39JHb1lPOyMKzk9vaZ25r+80otRW6jw5FdMqSOhJmCe6TK5TjTN9Mf9Mxnj8AeYB
        89ZcuuIa/klJOib6HfIdPc0ChsGIqo9yP7Oim2XCstMMo1VDGaRR8H4sAQEI8tNj6rwBVB
        lsfB33HPXfpW0P5geuhJEUNVuk8UbUU=
Date:   Wed, 6 Nov 2019 20:54:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] AMD64 EDAC: Check for nodes without memory, etc.
Message-ID: <20191106195417.GF28380@zn.tnic>
References: <20191106012448.243970-1-Yazen.Ghannam@amd.com>
 <20191106160607.GC28380@zn.tnic>
 <SN6PR12MB26398D9E617DF8C0ABE0252CF8790@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB26398D9E617DF8C0ABE0252CF8790@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Nov 06, 2019 at 06:16:12PM +0000, Ghannam, Yazen wrote:
> We had a thread before about usersapce loading the module multiple times on
> failure:
> https://lore.kernel.org/linux-edac/20190822005020.GA403@angband.pl/
> 
> I tried to look into it a bit, but I didn't get very far.

Right, I'll try to have a look soon, as it reproduces here.

> So is the behavior you see only happening with the new patchset applied? That
> may be a clue that we can fix this in the module.

Actually, it did try twice before your patchset and I didn't notice it
then because it wouldn't spit so much debug output. But that happens now
because your patchset pulls up the detection early. And without it we
had:

$ dmesg | grep -i edac
[    2.590869] EDAC MC: Ver: 3.0.0
[    2.594855] EDAC DEBUG: edac_mc_sysfs_init: device mc created
[    5.939351] EDAC DEBUG: nb_mce_bank_enabled_on_node: core: 0, MCG_CTL: 0x3f, NB MSR is enabled
[    5.948488] EDAC DEBUG: nb_mce_bank_enabled_on_node: core: 1, MCG_CTL: 0x3f, NB MSR is enabled
[    5.957312] EDAC amd64: Node 0: DRAM ECC disabled.
[    5.967746] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
[    6.031424] EDAC DEBUG: nb_mce_bank_enabled_on_node: core: 0, MCG_CTL: 0x3f, NB MSR is enabled
[    6.042173] EDAC DEBUG: nb_mce_bank_enabled_on_node: core: 1, MCG_CTL: 0x3f, NB MSR is enabled
[    6.052253] EDAC amd64: Node 0: DRAM ECC disabled.
[    6.057804] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.

which are also two attempts.

Anyway, I'll queue your set and I'll try to debug that thing because it
is getting on my nerves slowly...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
