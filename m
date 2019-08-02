Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AADB07FC7B
	for <lists+linux-edac@lfdr.de>; Fri,  2 Aug 2019 16:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395017AbfHBOq3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Aug 2019 10:46:29 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33270 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727127AbfHBOq3 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 2 Aug 2019 10:46:29 -0400
Received: from zn.tnic (p200300EC2F0D9600E09105D62CCA3801.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:9600:e091:5d6:2cca:3801])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 757C91EC02FF;
        Fri,  2 Aug 2019 16:46:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1564757187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3Riak9a7wYC5o1rshs04eW9FFUa8lyoZHTKtKkJRJBc=;
        b=Q7ujHGeBtBO7TVI/+2dMnjVIaNTRiK/Q1dA6btQf8HgcRmK1HVPQo8LlmoIiO0SbYgBnom
        pwlE8fq7YLj7xpBYCM1pq4XLL6fyTMC3tHItNHjBuSWO18xcmII5P0Zq/24tQHwGPdxHz9
        adHYXKNAc2YtMObzAXnpl//aAcDpRdU=
Date:   Fri, 2 Aug 2019 16:46:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] AMD64 EDAC fixes
Message-ID: <20190802144626.GD30661@zn.tnic>
References: <20190709215643.171078-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190709215643.171078-1-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jul 09, 2019 at 09:56:54PM +0000, Ghannam, Yazen wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Hi Boris,
> 
> This set contains a few fixes for some changes merged in v5.2. There
> are also a couple of fixes for older issues. In addition, there are a
> couple of patches to add support for Asymmetric Dual-Rank DIMMs.
> 
> Thanks,
> Yazen
> 
> Link:
> https://lkml.kernel.org/r/20190531234501.32826-1-Yazen.Ghannam@amd.com
> 
> v1->v2:
> * Squash patches 1 and 2 together.
> 
> Yazen Ghannam (7):
>   EDAC/amd64: Support more than two controllers for chip selects
>     handling
>   EDAC/amd64: Recognize DRAM device type with EDAC_CTL_CAP
>   EDAC/amd64: Initialize DIMM info for systems with more than two
>     channels
>   EDAC/amd64: Find Chip Select memory size using Address Mask
>   EDAC/amd64: Decode syndrome before translating address
>   EDAC/amd64: Cache secondary Chip Select registers
>   EDAC/amd64: Support Asymmetric Dual-Rank DIMMs
> 
>  drivers/edac/amd64_edac.c | 348 ++++++++++++++++++++++++--------------
>  drivers/edac/amd64_edac.h |   9 +-
>  2 files changed, 232 insertions(+), 125 deletions(-)

So this still has this confusing reporting of unpopulated nodes:

[    4.291774] EDAC MC1: Giving out device to module amd64_edac controller F17h: DEV 0000:00:19.3 (INTERRUPT)
[    4.292021] EDAC DEBUG: ecc_enabled: Node 2: No enabled UMCs.
[    4.292231] EDAC amd64: Node 2: DRAM ECC disabled.
[    4.292405] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
[    4.292859] EDAC DEBUG: ecc_enabled: Node 3: No enabled UMCs.
[    4.292963] EDAC amd64: Node 3: DRAM ECC disabled.
[    4.293063] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
[    4.293347] AMD64 EDAC driver v3.5.0

which needs fixing.

Regardless, still not good enough. The snowy owl box I have here has 16
GB:

$ head -n1 /proc/meminfo
MemTotal:       15715328 kB

and yet

[    4.282251] EDAC MC: UMC0 chip selects:
[    4.282348] EDAC DEBUG: f17_addr_mask_to_cs_size: CS0 DIMM0 AddrMasks:
[    4.282455] EDAC DEBUG: f17_addr_mask_to_cs_size:   Original AddrMask: 0x1fffffe
[    4.282592] EDAC DEBUG: f17_addr_mask_to_cs_size:   Deinterleaved AddrMask: 0x1fffffe
[    4.282732] EDAC DEBUG: f17_addr_mask_to_cs_size: CS1 DIMM0 AddrMasks:
[    4.282839] EDAC DEBUG: f17_addr_mask_to_cs_size:   Original AddrMask: 0x1fffffe
[    4.283060] EDAC DEBUG: f17_addr_mask_to_cs_size:   Deinterleaved AddrMask: 0x1fffffe
[    4.283286] EDAC amd64: MC: 0:  8191MB 1:  8191MB
				   ^^^^^^^^^^^^^^^^^

[    4.283456] EDAC amd64: MC: 2:     0MB 3:     0MB

...

[    4.285379] EDAC MC: UMC1 chip selects:
[    4.285476] EDAC DEBUG: f17_addr_mask_to_cs_size: CS0 DIMM0 AddrMasks:
[    4.285583] EDAC DEBUG: f17_addr_mask_to_cs_size:   Original AddrMask: 0x1fffffe
[    4.285721] EDAC DEBUG: f17_addr_mask_to_cs_size:   Deinterleaved AddrMask: 0x1fffffe
[    4.285860] EDAC DEBUG: f17_addr_mask_to_cs_size: CS1 DIMM0 AddrMasks:
[    4.285967] EDAC DEBUG: f17_addr_mask_to_cs_size:   Original AddrMask: 0x1fffffe
[    4.286105] EDAC DEBUG: f17_addr_mask_to_cs_size:   Deinterleaved AddrMask: 0x1fffffe
[    4.286244] EDAC amd64: MC: 0:  8191MB 1:  8191MB
				   ^^^^^^^^^^^^^^^^^

[    4.286345] EDAC amd64: MC: 2:     0MB 3:     0MB

which shows 4 chip selects x 8Gb = 32G.

So something's still wrong. Before the patchset it says:

EDAC MC: UMC0 chip selects:
EDAC amd64: MC: 0:  8192MB 1:     0MB
...
EDAC MC: UMC1 chip selects:
EDAC amd64: MC: 0:  8192MB 1:     0MB

which is the correct output.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
