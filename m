Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBCDF6984
	for <lists+linux-edac@lfdr.de>; Sun, 10 Nov 2019 15:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfKJOvL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 10 Nov 2019 09:51:11 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54378 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbfKJOvL (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 10 Nov 2019 09:51:11 -0500
Received: from zn.tnic (p200300EC2F26BB00D42A27CD7BFC583C.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:bb00:d42a:27cd:7bfc:583c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D00381EC0982;
        Sun, 10 Nov 2019 15:51:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573397470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xO0lB4uGxIXMoeB+wg7ZV0Q6T8U7kfsLIan1I/NRv50=;
        b=q2Ozd2zVPLt3azwaOD4yqZ8j1dPFxql7nj5emegrt0Ps21bLyGoceMKua1z8WwjZ0grcts
        C8dayUH4fLgsvs/Zq5zjvpYomqqRTXv1RYQnt7RGc45h+bpsJbGl97JOs5VUQjHrjdb9Vu
        YumeyboKjjf8V9tP8uaG2dd1XYNO2dM=
Date:   Sun, 10 Nov 2019 15:51:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/20] EDAC: Rework edac_mc and ghes drivers
Message-ID: <20191110145104.GB12627@zn.tnic>
References: <20191106093239.25517-1-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191106093239.25517-1-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Nov 06, 2019 at 09:32:58AM +0000, Robert Richter wrote:
> Robert Richter (20):
>   EDAC: Replace EDAC_DIMM_PTR() macro with edac_get_dimm() function
>   EDAC: Remove EDAC_DIMM_OFF() macro
>   EDAC: Introduce mci_for_each_dimm() iterator
>   EDAC, mc: Do not BUG_ON() in edac_mc_alloc()
>   EDAC, mc: Remove needless zero string termination
>   EDAC, mc: Reduce indentation level in edac_mc_handle_error()
>   EDAC, mc: Rename iterator variable to idx
>   EDAC: Remove misleading comment in struct edac_raw_error_desc
>   EDAC, ghes: Use standard kernel macros for page calculations
>   EDAC, ghes: Fix grain calculation
>   EDAC, ghes: Remove intermediate buffer pvt->detail_location
>   EDAC, ghes: Unify trace_mc_event() code with edac_mc driver
>   EDAC, Documentation: Describe CPER module definition and DIMM ranks

Queued up to here.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
