Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68997497C65
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jan 2022 10:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbiAXJrh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Jan 2022 04:47:37 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48614 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234824AbiAXJrh (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 24 Jan 2022 04:47:37 -0500
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F02141EC01A9;
        Mon, 24 Jan 2022 10:47:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643017651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CcLTDVSM75ulMuSB/GUt0Op09+BKvmEOlIHEnWSP7UM=;
        b=kS4brgDkqwyrvLTFLRUEVirhDn29ILA76d5VFA0Ss9wQT1G21jLMjQCs1HttX3dlcL8xx8
        cBLfcypm60raXTkbN/ydIm/oO6CSi1XTqdV8evIkTmSEUGlPTcHtSBPiDQRMetcyGa1t0O
        uDDgGt2V39NtlU78/jMiBBWdS8OkLAE=
Date:   Mon, 24 Jan 2022 10:47:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     luofei <luofei@unicloud.com>
Cc:     tony.luck@intel.com, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mce: Always call kill_me_maybe() to handle memory
 failure in user mode
Message-ID: <Ye51rSZgBhpl4lzD@zn.tnic>
References: <20220124081501.235236-1-luofei@unicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220124081501.235236-1-luofei@unicloud.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jan 24, 2022 at 03:15:01AM -0500, luofei wrote:
> Just killing the current process is not enough, it is necessory
> to offload the faulty page.
> 
> In the virtualization scenario, qemu does not set MCG_STATUS_RIPV by
> default.

Yes, we've had this before. Fix qemu.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
