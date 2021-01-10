Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DC22F06A7
	for <lists+linux-edac@lfdr.de>; Sun, 10 Jan 2021 12:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbhAJLdz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 10 Jan 2021 06:33:55 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45916 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbhAJLdy (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 10 Jan 2021 06:33:54 -0500
Received: from zn.tnic (p200300ec2f24190001c871219039d0da.dip0.t-ipconnect.de [IPv6:2003:ec:2f24:1900:1c8:7121:9039:d0da])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8BCF21EC04E0;
        Sun, 10 Jan 2021 12:33:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610278393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7haxQIEb2EeMj0tasgoGkUtD2sC4DQt95Px2XaAC3+k=;
        b=JZ2/7l3I44RciEZ8lJbapOW+6PH92PUiuJ1GQ7gksO+e2AwKjyGkPR2NY+iNu9qQ5yOu7W
        Ekp2QqJX3bVm1HbV/QKS29ehSn1cDFi+s1i3Q3684GW4Il36f+yHoGAcQMto53Gv22MZEB
        fN2jgFcQTos2kYMzenq7il+AYTjJEGQ=
Date:   Sun, 10 Jan 2021 12:33:08 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     WGH <wgh@torlan.ru>, Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org
Subject: Re: Unable to set (or read back) sdram_scrub_rate on amd64_edac
 F17h_M70h (Ryzen 3rd gen)
Message-ID: <20210110113308.GB22211@zn.tnic>
References: <a9cdf7c2-868a-8f67-ac4e-c6bff60552e2@torlan.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9cdf7c2-868a-8f67-ac4e-c6bff60552e2@torlan.ru>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Jan 10, 2021 at 09:03:24AM +0300, WGH wrote:
> I tried many rates mentioned in scrubrates[] array, but the result is still the same.
> 
> % echo 100000 | sudo tee /sys/devices/system/edac/mc/mc0/sdram_scrub_rate
> 100000
> % sudo cat /sys/devices/system/edac/mc/mc0/sdram_scrub_rate
> 0
> 
> dmesg excerpt:
> 
> [    0.561809] EDAC MC: Ver: 3.0.0
> (skip)
> [    0.825762] EDAC amd64: F17h_M70h detected (node 0).
> [    0.826343] EDAC amd64: Node 0: DRAM ECC enabled.
> [    0.826901] EDAC amd64: MCT channel count: 2
> [    0.827512] EDAC MC0: Giving out device to module amd64_edac controller F17h_M70h: DEV 0000:00:18.3 (INTERRUPT)
> [    0.828106] EDAC MC: UMC0 chip selects:
> [    0.828106] EDAC amd64: MC: 0: 16384MB 1: 16384MB
> [    0.828690] EDAC amd64: MC: 2: 16384MB 3: 16384MB
> [    0.829262] EDAC MC: UMC1 chip selects:
> [    0.829262] EDAC amd64: MC: 0: 16384MB 1: 16384MB
> [    0.829829] EDAC amd64: MC: 2: 16384MB 3: 16384MB
> [    0.830383] EDAC amd64: using x16 syndromes.
> [    0.830992] EDAC PCI0: Giving out device to module amd64_edac controller EDAC PCI controller: DEV 0000:00:18.0 (POLLED)
> [    0.831577] AMD64 EDAC driver v3.5.0
> 
> This is AMD Ryzen 9 3900XT on ASRock B550 Extreme4 motherboard, Linux 5.10.5.

That thing checks a bit 0 in some PCI cfg reg on F17h before returning
the scrubrate. Do as root:

# setpci -s 00:18.6 0x0x48.l

It could be that scrub rate setting is locked on your machine. Because
it works here:

# echo 100000 > /sys/devices/system/edac/mc/mc0/sdram_scrub_rate
# cat  /sys/devices/system/edac/mc/mc0/sdram_scrub_rate
390720

That's a AMD Ryzen 7 2700X Eight-Core Processor, however.

Yazen?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
