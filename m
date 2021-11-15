Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832DC450930
	for <lists+linux-edac@lfdr.de>; Mon, 15 Nov 2021 17:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236709AbhKOQIa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 15 Nov 2021 11:08:30 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48242 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236618AbhKOQHu (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 15 Nov 2021 11:07:50 -0500
Received: from zn.tnic (p200300ec2f0b5600329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:5600:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9BDA91EC0283;
        Mon, 15 Nov 2021 17:04:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636992281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=A5es2ls9sF041xL932PggqKzePNRYdDu0Notq+AQ++4=;
        b=bD2S1Tx6UNeSVqnibY0x84EtiVVZga7M4RegujnuD/YDA4uoyV8LlhuCNuTSsFibbb7KYH
        1MdKWgBjHZTpnL+wbtQ7QXQg3K7sjfiQaO7SUMCWzhOKYVQFI7K8A63rUcf4fwoGyLso9U
        pURavpZPUKO6hm6a+r/jMCO+11tYVm0=
Date:   Mon, 15 Nov 2021 17:04:30 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Chatradhi, Naveen Krishna" <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        yazen.ghannam@amd.com, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v6 5/5] EDAC/amd64: Enumerate memory on Aldebaran GPU
 nodes
Message-ID: <YZKFDgtaBtvD6NIz@zn.tnic>
References: <20211028130106.15701-1-nchatrad@amd.com>
 <20211028130106.15701-6-nchatrad@amd.com>
 <YY0WrKjnQ20IjrhB@zn.tnic>
 <90642509-81af-51f2-8942-c90432680fa2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <90642509-81af-51f2-8942-c90432680fa2@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Nov 15, 2021 at 08:54:55PM +0530, Chatradhi, Naveen Krishna wrote:
> The errors are not specific to GPUs, the errors are originating from HBM2e
> memory chips on the GPU.
> 
> As a first step, I'm trying to leverage the existing EDAC interfaces to
> report the HBM errors.

Report them how? How do the HBM chips fit in the EDAC sysfs hierarchy?
Does it even work with the current hierarchy or does EDAC need more
major restructuring?

You can send me an example from sysfs on such a system, privately is
fine too.

> Page retirement and storing the bad pages info on a persistent storage can
> be the next steps.

If you're thinking about plugging this into memory_failure(), then this
has nothing to do with EDAC.

All EDAC can give you is error count numbers in sysfs.

So I'd like to see where this is going first, and whether it is even
worth it adding it to EDAC.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
