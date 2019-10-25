Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81199E4C5E
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2019 15:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfJYNfD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 25 Oct 2019 09:35:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46422 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbfJYNfD (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 25 Oct 2019 09:35:03 -0400
Received: from zn.tnic (p200300EC2F0D3C00E44239D1C9BE3FA7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:3c00:e442:39d1:c9be:3fa7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6FF6C1EC0CE5;
        Fri, 25 Oct 2019 15:35:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1572010501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cie/7pIdBT5SGI8liusfhALfpJe2qIxSGd9dh0LI6q0=;
        b=JDNgbHuUNPJ2lblaM2IUPPB9PYlwz+hzNggdEN37YQEXp5nFptxmzkjbAg2Q5GHwhQmuri
        zOdffNVl9+k2vaW1Z1N+ySLWfR5/dlgp4Z8qAR2ByVgqdhnGEmxd7H7exJFY0eAGs02Fxr
        jpVz9JmFBk+xbsJPkuO/kRbMiwndp2A=
Date:   Fri, 25 Oct 2019 15:34:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] AMD64 EDAC: Check for nodes without memory, etc.
Message-ID: <20191025133456.GA6483@zn.tnic>
References: <20191022203448.13962-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191022203448.13962-1-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Oct 22, 2019 at 08:35:08PM +0000, Ghannam, Yazen wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Hi Boris,
> 
> Most of these patches address the issue where the module checks and
> complains about DRAM ECC on nodes without memory.
> 
> Thanks,
> Yazen
> 
> Link:
> https://lkml.kernel.org/r/20191018153114.39378-1-Yazen.Ghannam@amd.com
> 
> Yazen Ghannam (6):
>   EDAC/amd64: Make struct amd64_family_type global
>   EDAC/amd64: Gather hardware information early
>   EDAC/amd64: Save max number of controllers to family type
>   EDAC/amd64: Use cached data when checking for ECC
>   EDAC/amd64: Check for memory before fully initializing an instance
>   EDAC/amd64: Set grain per DIMM
> 
>  drivers/edac/amd64_edac.c | 196 +++++++++++++++++++-------------------
>  drivers/edac/amd64_edac.h |   2 +
>  2 files changed, 100 insertions(+), 98 deletions(-)

Almost there: now it dumps the whole shebang twice. This is on an old
F10h box which doesn't have ECC DIMMs:

[    2.222853] EDAC MC: Ver: 3.0.0
[    2.226881] EDAC DEBUG: edac_mc_sysfs_init: device mc created
[    5.726912] EDAC amd64: F10h detected (node 0).
[    5.732709] EDAC DEBUG: reserve_mc_sibling_devs: F1: 0000:00:18.1
[    5.750886] EDAC DEBUG: reserve_mc_sibling_devs: F2: 0000:00:18.2
[    5.758427] EDAC DEBUG: reserve_mc_sibling_devs: F3: 0000:00:18.3
[    5.765871] EDAC DEBUG: read_mc_regs:   TOP_MEM:  0x00000000d0000000
[    5.774098] EDAC DEBUG: read_mc_regs:   TOP_MEM2: 0x0000000230000000
[    5.782339] EDAC DEBUG: read_dram_ctl_register: F2x110 (DCTSelLow): 0xffffffff, High range addrs at: 0xfffff800
[    5.793976] EDAC DEBUG: read_dram_ctl_register:   DCTs operate in ganged mode
[    5.802429] EDAC DEBUG: read_dram_ctl_register:   data interleave for ECC: enabled, DRAM cleared since last warm reset: yes
[    5.814702] EDAC DEBUG: read_dram_ctl_register:   channel interleave: enabled, interleave bits selector: 0x3
[    5.826142] EDAC DEBUG: read_mc_regs:   DRAM range[0], base: 0x0000ff0000000000; limit: 0x0000ff022fffffff
[    5.837070] EDAC DEBUG: read_mc_regs:    IntlvEn=Disabled; Range access: RW IntlvSel=0 DstNode=0
[    5.847061] EDAC DEBUG: read_dct_base_mask:   DCSB0[0]=0x00000001 reg: F2x40
[    5.854699] EDAC DEBUG: read_dct_base_mask:   DCSB1[0]=0x00000000 reg: F2x140
[    5.862763] EDAC DEBUG: read_dct_base_mask:   DCSB0[1]=0x00000101 reg: F2x44
[    5.870614] EDAC DEBUG: read_dct_base_mask:   DCSB1[1]=0x00000000 reg: F2x144
[    5.878457] EDAC DEBUG: read_dct_base_mask:   DCSB0[2]=0x00000201 reg: F2x48
[    5.888483] EDAC DEBUG: read_dct_base_mask:   DCSB1[2]=0x00000000 reg: F2x148
[    5.897359] EDAC DEBUG: read_dct_base_mask:   DCSB0[3]=0x00000301 reg: F2x4c
[    5.906307] EDAC DEBUG: read_dct_base_mask:   DCSB1[3]=0x00000000 reg: F2x14c
[    5.913698] EDAC DEBUG: read_dct_base_mask:   DCSB0[4]=0x00000000 reg: F2x50
[    5.921646] EDAC DEBUG: read_dct_base_mask:   DCSB1[4]=0x00000000 reg: F2x150
[    5.930415] EDAC DEBUG: read_dct_base_mask:   DCSB0[5]=0x00000000 reg: F2x54
[    5.937772] EDAC DEBUG: read_dct_base_mask:   DCSB1[5]=0x00000000 reg: F2x154
[    5.945684] EDAC DEBUG: read_dct_base_mask:   DCSB0[6]=0x00000000 reg: F2x58
[    5.953523] EDAC DEBUG: read_dct_base_mask:   DCSB1[6]=0x00000000 reg: F2x158
[    5.961546] EDAC DEBUG: read_dct_base_mask:   DCSB0[7]=0x00000000 reg: F2x5c
[    5.969385] EDAC DEBUG: read_dct_base_mask:   DCSB1[7]=0x00000000 reg: F2x15c
[    5.977333] EDAC DEBUG: read_dct_base_mask:     DCSM0[0]=0x00f83ce0 reg: F2x60
[    5.986777] EDAC DEBUG: read_dct_base_mask:     DCSM1[0]=0x00000000 reg: F2x160
[    6.000195] EDAC DEBUG: read_dct_base_mask:     DCSM0[1]=0x00f83ce0 reg: F2x64
[    6.012487] EDAC DEBUG: read_dct_base_mask:     DCSM1[1]=0x00000000 reg: F2x164
[    6.019946] EDAC DEBUG: read_dct_base_mask:     DCSM0[2]=0x00000000 reg: F2x68
[    6.027283] EDAC DEBUG: read_dct_base_mask:     DCSM1[2]=0x00000000 reg: F2x168
[    6.035342] EDAC DEBUG: read_dct_base_mask:     DCSM0[3]=0x00000000 reg: F2x6c
[    6.042800] EDAC DEBUG: read_dct_base_mask:     DCSM1[3]=0x00000000 reg: F2x16c
[    6.050913] EDAC DEBUG: read_mc_regs:   DIMM type: Unbuffered-DDR2
[    6.057183] EDAC DEBUG: nb_mce_bank_enabled_on_node: core: 0, MCG_CTL: 0x3f, NB MSR is enabled
[    6.065925] EDAC DEBUG: nb_mce_bank_enabled_on_node: core: 1, MCG_CTL: 0x3f, NB MSR is enabled
[    6.081200] EDAC amd64: Node 0: DRAM ECC disabled.
[    6.092690] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
[    6.208087] EDAC amd64: F10h detected (node 0).
[    6.212966] EDAC DEBUG: reserve_mc_sibling_devs: F1: 0000:00:18.1
[    6.235500] EDAC DEBUG: reserve_mc_sibling_devs: F2: 0000:00:18.2
[    6.241661] EDAC DEBUG: reserve_mc_sibling_devs: F3: 0000:00:18.3
[    6.252691] EDAC DEBUG: read_mc_regs:   TOP_MEM:  0x00000000d0000000
[    6.259134] EDAC DEBUG: read_mc_regs:   TOP_MEM2: 0x0000000230000000
[    6.265823] EDAC DEBUG: read_dram_ctl_register: F2x110 (DCTSelLow): 0xffffffff, High range addrs at: 0xfffff800
[    6.275978] EDAC DEBUG: read_dram_ctl_register:   DCTs operate in ganged mode
[    6.283271] EDAC DEBUG: read_dram_ctl_register:   data interleave for ECC: enabled, DRAM cleared since last warm reset: yes
[    6.294635] EDAC DEBUG: read_dram_ctl_register:   channel interleave: enabled, interleave bits selector: 0x3
[    6.304565] EDAC DEBUG: read_mc_regs:   DRAM range[0], base: 0x0000ff0000000000; limit: 0x0000ff022fffffff
[    6.314367] EDAC DEBUG: read_mc_regs:    IntlvEn=Disabled; Range access: RW IntlvSel=0 DstNode=0
[    6.323259] EDAC DEBUG: read_dct_base_mask:   DCSB0[0]=0x00000001 reg: F2x40
[    6.330434] EDAC DEBUG: read_dct_base_mask:   DCSB1[0]=0x00000000 reg: F2x140
[    6.337648] EDAC DEBUG: read_dct_base_mask:   DCSB0[1]=0x00000101 reg: F2x44
[    6.351551] EDAC DEBUG: read_dct_base_mask:   DCSB1[1]=0x00000000 reg: F2x144
[    6.364985] EDAC DEBUG: read_dct_base_mask:   DCSB0[2]=0x00000201 reg: F2x48
[    6.379708] EDAC DEBUG: read_dct_base_mask:   DCSB1[2]=0x00000000 reg: F2x148
[    6.386913] EDAC DEBUG: read_dct_base_mask:   DCSB0[3]=0x00000301 reg: F2x4c
[    6.394037] EDAC DEBUG: read_dct_base_mask:   DCSB1[3]=0x00000000 reg: F2x14c
[    6.401259] EDAC DEBUG: read_dct_base_mask:   DCSB0[4]=0x00000000 reg: F2x50
[    6.408377] EDAC DEBUG: read_dct_base_mask:   DCSB1[4]=0x00000000 reg: F2x150
[    6.415854] EDAC DEBUG: read_dct_base_mask:   DCSB0[5]=0x00000000 reg: F2x54
[    6.422976] EDAC DEBUG: read_dct_base_mask:   DCSB1[5]=0x00000000 reg: F2x154
[    6.430178] EDAC DEBUG: read_dct_base_mask:   DCSB0[6]=0x00000000 reg: F2x58
[    6.437300] EDAC DEBUG: read_dct_base_mask:   DCSB1[6]=0x00000000 reg: F2x158
[    6.444507] EDAC DEBUG: read_dct_base_mask:   DCSB0[7]=0x00000000 reg: F2x5c
[    6.451621] EDAC DEBUG: read_dct_base_mask:   DCSB1[7]=0x00000000 reg: F2x15c
[    6.458833] EDAC DEBUG: read_dct_base_mask:     DCSM0[0]=0x00f83ce0 reg: F2x60
[    6.466155] EDAC DEBUG: read_dct_base_mask:     DCSM1[0]=0x00000000 reg: F2x160
[    6.473571] EDAC DEBUG: read_dct_base_mask:     DCSM0[1]=0x00f83ce0 reg: F2x64
[    6.480901] EDAC DEBUG: read_dct_base_mask:     DCSM1[1]=0x00000000 reg: F2x164
[    6.488305] EDAC DEBUG: read_dct_base_mask:     DCSM0[2]=0x00000000 reg: F2x68
[    6.495647] EDAC DEBUG: read_dct_base_mask:     DCSM1[2]=0x00000000 reg: F2x168
[    6.511447] EDAC DEBUG: read_dct_base_mask:     DCSM0[3]=0x00000000 reg: F2x6c
[    6.511448] EDAC DEBUG: read_dct_base_mask:     DCSM1[3]=0x00000000 reg: F2x16c
[    6.511451] EDAC DEBUG: read_mc_regs:   DIMM type: Unbuffered-DDR2
[    6.511458] EDAC DEBUG: nb_mce_bank_enabled_on_node: core: 0, MCG_CTL: 0x3f, NB MSR is enabled
[    6.511459] EDAC DEBUG: nb_mce_bank_enabled_on_node: core: 1, MCG_CTL: 0x3f, NB MSR is enabled
[    6.511460] EDAC amd64: Node 0: DRAM ECC disabled.
[    6.511461] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
