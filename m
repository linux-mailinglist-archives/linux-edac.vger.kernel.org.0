Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098632E6A06
	for <lists+linux-edac@lfdr.de>; Mon, 28 Dec 2020 19:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgL1Sgj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Dec 2020 13:36:39 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36206 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728804AbgL1Sgi (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 28 Dec 2020 13:36:38 -0500
Received: from zn.tnic (p200300ec2f07e40085f47ee5beeb4d19.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:e400:85f4:7ee5:beeb:4d19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 42B1E1EC03FA;
        Mon, 28 Dec 2020 19:35:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1609180557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qPxWIwUrwc6PSC5IAuON4YtJ3HEhC4wLA/FNfgUYLJA=;
        b=UgpV6EDu3fHMNWeF94rMTKAEa+Zm2shzYiigfDMI/Gc3n7w6S1JFwIknnaF3nUCrQxmA1I
        SlYDv4/n1UnYIPz4uVJoL0AXgAWSL9ONPkUYjijd7isYSpIeuBaT/Lyv8pgSpugeRFNa7Y
        BV76q9Ih8QTHC0MSbTT1DFtCCu16b9s=
Date:   Mon, 28 Dec 2020 19:35:54 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH] EDAC/amd64: Tone down messages about missing PCI IDs
Message-ID: <20201228183554.GB20321@zn.tnic>
References: <20201215170131.8496-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201215170131.8496-1-Yazen.Ghannam@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Dec 15, 2020 at 05:01:31PM +0000, Yazen Ghannam wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Give these messages a debug severity as they are really only useful to
> the module developers.
> 
> Also, drop the "(broken BIOS?)" phrase, since this can cause churn for
> BIOS folks. The PCI IDs needed by the module, at least on modern systems,
> are fixed in hardware.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/edac/amd64_edac.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
