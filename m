Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7EF3F1ABB
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2019 17:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfKFQGO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Nov 2019 11:06:14 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53778 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbfKFQGO (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 6 Nov 2019 11:06:14 -0500
Received: from zn.tnic (p200300EC2F0E77001533F52C90575FC8.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:7700:1533:f52c:9057:5fc8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B81E31EC0CDD;
        Wed,  6 Nov 2019 17:06:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573056372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=AqHULZoJql977LklrjplN/5siEITgkPs6pyHRw7U4cg=;
        b=p3YMbmhLxImOHnMqQ6NIFKZg2CaIFKsc2GT9mAa7Fq1gP8GSi45H4LPi0fJJw3sSJaqeT9
        YNKQApVsqiPtRzn57u3TRZ89HCy2kU4gOPhQCMS6Ng8BSCd9yx+KZ4V5MLC68V+JfN5H33
        3zZh3iQsgjJwy1aCG8e6VmHbC4MY/2A=
Date:   Wed, 6 Nov 2019 17:06:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] AMD64 EDAC: Check for nodes without memory, etc.
Message-ID: <20191106160607.GC28380@zn.tnic>
References: <20191106012448.243970-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191106012448.243970-1-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Nov 06, 2019 at 01:24:59AM +0000, Ghannam, Yazen wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Hi Boris,
> 
> These patches address the issue where the module checks and complains
> about DRAM ECC on nodes without memory.
> 
> Changes from last revision:
>   1) Dropped patch 6 which was for adding a grain value.
>   2) Added an error code for !ecc_enabled() in patch 5.

Still doesn't help. The load gets attempted twice still. Try reproducing
it on a small, single-node box where ECC is disabled.

[    2.590123] EDAC MC: Ver: 3.0.0
[    2.594153] EDAC DEBUG: edac_mc_sysfs_init: device mc created
[    5.946482] EDAC amd64: F10h detected (node 0).
[    5.952134] EDAC DEBUG: reserve_mc_sibling_devs: F1: 0000:00:18.1
[    5.958967] EDAC DEBUG: reserve_mc_sibling_devs: F2: 0000:00:18.2
[    5.969869] EDAC DEBUG: reserve_mc_sibling_devs: F3: 0000:00:18.3
[    5.981125] EDAC DEBUG: read_mc_regs:   TOP_MEM:  0x00000000d0000000
[    5.981126] EDAC DEBUG: read_mc_regs:   TOP_MEM2: 0x0000000230000000
[    5.981130] EDAC DEBUG: read_dram_ctl_register: F2x110 (DCTSelLow): 0xffffffff, High range addrs at: 0xfffff800
[    5.981131] EDAC DEBUG: read_dram_ctl_register:   DCTs operate in ganged mode
[    5.981132] EDAC DEBUG: read_dram_ctl_register:   data interleave for ECC: enabled, DRAM cleared since last warm reset: yes
[    5.981133] EDAC DEBUG: read_dram_ctl_register:   channel interleave: enabled, interleave bits selector: 0x3
[    5.981137] EDAC DEBUG: read_mc_regs:   DRAM range[0], base: 0x0000ff0000000000; limit: 0x0000ff022fffffff
[    5.981138] EDAC DEBUG: read_mc_regs:    IntlvEn=Disabled; Range access: RW IntlvSel=0 DstNode=0
[    5.981144] EDAC DEBUG: read_dct_base_mask:   DCSB0[0]=0x00000001 reg: F2x40
[    5.981146] EDAC DEBUG: read_dct_base_mask:   DCSB1[0]=0x00000000 reg: F2x140
[    5.981147] EDAC DEBUG: read_dct_base_mask:   DCSB0[1]=0x00000101 reg: F2x44
[    5.981148] EDAC DEBUG: read_dct_base_mask:   DCSB1[1]=0x00000000 reg: F2x144
[    5.981149] EDAC DEBUG: read_dct_base_mask:   DCSB0[2]=0x00000201 reg: F2x48
[    5.981150] EDAC DEBUG: read_dct_base_mask:   DCSB1[2]=0x00000000 reg: F2x148
[    5.981151] EDAC DEBUG: read_dct_base_mask:   DCSB0[3]=0x00000301 reg: F2x4c
[    5.981152] EDAC DEBUG: read_dct_base_mask:   DCSB1[3]=0x00000000 reg: F2x14c
[    5.981153] EDAC DEBUG: read_dct_base_mask:   DCSB0[4]=0x00000000 reg: F2x50
[    5.981154] EDAC DEBUG: read_dct_base_mask:   DCSB1[4]=0x00000000 reg: F2x150
[    5.981155] EDAC DEBUG: read_dct_base_mask:   DCSB0[5]=0x00000000 reg: F2x54
[    5.981156] EDAC DEBUG: read_dct_base_mask:   DCSB1[5]=0x00000000 reg: F2x154
[    5.981157] EDAC DEBUG: read_dct_base_mask:   DCSB0[6]=0x00000000 reg: F2x58
[    5.981158] EDAC DEBUG: read_dct_base_mask:   DCSB1[6]=0x00000000 reg: F2x158
[    5.981159] EDAC DEBUG: read_dct_base_mask:   DCSB0[7]=0x00000000 reg: F2x5c
[    5.981160] EDAC DEBUG: read_dct_base_mask:   DCSB1[7]=0x00000000 reg: F2x15c
[    5.981161] EDAC DEBUG: read_dct_base_mask:     DCSM0[0]=0x00f83ce0 reg: F2x60
[    5.981162] EDAC DEBUG: read_dct_base_mask:     DCSM1[0]=0x00000000 reg: F2x160
[    5.981163] EDAC DEBUG: read_dct_base_mask:     DCSM0[1]=0x00f83ce0 reg: F2x64
[    5.981164] EDAC DEBUG: read_dct_base_mask:     DCSM1[1]=0x00000000 reg: F2x164
[    5.981165] EDAC DEBUG: read_dct_base_mask:     DCSM0[2]=0x00000000 reg: F2x68
[    5.981166] EDAC DEBUG: read_dct_base_mask:     DCSM1[2]=0x00000000 reg: F2x168
[    5.981167] EDAC DEBUG: read_dct_base_mask:     DCSM0[3]=0x00000000 reg: F2x6c
[    5.981168] EDAC DEBUG: read_dct_base_mask:     DCSM1[3]=0x00000000 reg: F2x16c
[    5.981169] EDAC DEBUG: read_mc_regs:   DIMM type: Unbuffered-DDR2
[    5.981219] EDAC DEBUG: nb_mce_bank_enabled_on_node: core: 0, MCG_CTL: 0x3f, NB MSR is enabled
[    5.981221] EDAC DEBUG: nb_mce_bank_enabled_on_node: core: 1, MCG_CTL: 0x3f, NB MSR is enabled
[    5.981221] EDAC amd64: Node 0: DRAM ECC disabled.
[    5.981223] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
[    6.302561] EDAC amd64: F10h detected (node 0).
[    6.307276] EDAC DEBUG: reserve_mc_sibling_devs: F1: 0000:00:18.1
[    6.313630] EDAC DEBUG: reserve_mc_sibling_devs: F2: 0000:00:18.2
[    6.320589] EDAC DEBUG: reserve_mc_sibling_devs: F3: 0000:00:18.3
[    6.328359] EDAC DEBUG: read_mc_regs:   TOP_MEM:  0x00000000d0000000
[    6.335150] EDAC DEBUG: read_mc_regs:   TOP_MEM2: 0x0000000230000000
[    6.342188] EDAC DEBUG: read_dram_ctl_register: F2x110 (DCTSelLow): 0xffffffff, High range addrs at: 0xfffff800
[    6.353691] EDAC DEBUG: read_dram_ctl_register:   DCTs operate in ganged mode
[    6.361527] EDAC DEBUG: read_dram_ctl_register:   data interleave for ECC: enabled, DRAM cleared since last warm reset: yes
[    6.374204] EDAC DEBUG: read_dram_ctl_register:   channel interleave: enabled, interleave bits selector: 0x3
[    6.384343] EDAC DEBUG: read_mc_regs:   DRAM range[0], base: 0x0000ff0000000000; limit: 0x0000ff022fffffff
[    6.395942] EDAC DEBUG: read_mc_regs:    IntlvEn=Disabled; Range access: RW IntlvSel=0 DstNode=0
[    6.406619] EDAC DEBUG: read_dct_base_mask:   DCSB0[0]=0x00000001 reg: F2x40
[    6.414646] EDAC DEBUG: read_dct_base_mask:   DCSB1[0]=0x00000000 reg: F2x140
[    6.422526] EDAC DEBUG: read_dct_base_mask:   DCSB0[1]=0x00000101 reg: F2x44
[    6.430823] EDAC DEBUG: read_dct_base_mask:   DCSB1[1]=0x00000000 reg: F2x144
[    6.438710] EDAC DEBUG: read_dct_base_mask:   DCSB0[2]=0x00000201 reg: F2x48
[    6.446810] EDAC DEBUG: read_dct_base_mask:   DCSB1[2]=0x00000000 reg: F2x148
[    6.454788] EDAC DEBUG: read_dct_base_mask:   DCSB0[3]=0x00000301 reg: F2x4c
[    6.462743] EDAC DEBUG: read_dct_base_mask:   DCSB1[3]=0x00000000 reg: F2x14c
[    6.470585] EDAC DEBUG: read_dct_base_mask:   DCSB0[4]=0x00000000 reg: F2x50
[    6.478698] EDAC DEBUG: read_dct_base_mask:   DCSB1[4]=0x00000000 reg: F2x150
[    6.486624] EDAC DEBUG: read_dct_base_mask:   DCSB0[5]=0x00000000 reg: F2x54
[    6.494631] EDAC DEBUG: read_dct_base_mask:   DCSB1[5]=0x00000000 reg: F2x154
[    6.502866] EDAC DEBUG: read_dct_base_mask:   DCSB0[6]=0x00000000 reg: F2x58
[    6.510817] EDAC DEBUG: read_dct_base_mask:   DCSB1[6]=0x00000000 reg: F2x158
[    6.518602] EDAC DEBUG: read_dct_base_mask:   DCSB0[7]=0x00000000 reg: F2x5c
[    6.527120] EDAC DEBUG: read_dct_base_mask:   DCSB1[7]=0x00000000 reg: F2x15c
[    6.534926] EDAC DEBUG: read_dct_base_mask:     DCSM0[0]=0x00f83ce0 reg: F2x60
[    6.548356] EDAC DEBUG: read_dct_base_mask:     DCSM1[0]=0x00000000 reg: F2x160
[    6.560715] EDAC DEBUG: read_dct_base_mask:     DCSM0[1]=0x00f83ce0 reg: F2x64
[    6.568116] EDAC DEBUG: read_dct_base_mask:     DCSM1[1]=0x00000000 reg: F2x164
[    6.575596] EDAC DEBUG: read_dct_base_mask:     DCSM0[2]=0x00000000 reg: F2x68
[    6.584317] EDAC DEBUG: read_dct_base_mask:     DCSM1[2]=0x00000000 reg: F2x168
[    6.591899] EDAC DEBUG: read_dct_base_mask:     DCSM0[3]=0x00000000 reg: F2x6c
[    6.599460] EDAC DEBUG: read_dct_base_mask:     DCSM1[3]=0x00000000 reg: F2x16c
[    6.606877] EDAC DEBUG: read_mc_regs:   DIMM type: Unbuffered-DDR2
[    6.619722] EDAC DEBUG: nb_mce_bank_enabled_on_node: core: 0, MCG_CTL: 0x3f, NB MSR is enabled
[    6.628463] EDAC DEBUG: nb_mce_bank_enabled_on_node: core: 1, MCG_CTL: 0x3f, NB MSR is enabled
[    6.648232] EDAC amd64: Node 0: DRAM ECC disabled.
[    6.657843] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
