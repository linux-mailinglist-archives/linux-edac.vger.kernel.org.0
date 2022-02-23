Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54C34C19F4
	for <lists+linux-edac@lfdr.de>; Wed, 23 Feb 2022 18:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbiBWRkJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Feb 2022 12:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbiBWRkJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 23 Feb 2022 12:40:09 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2BCB48;
        Wed, 23 Feb 2022 09:39:41 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 999C71EC054C;
        Wed, 23 Feb 2022 18:39:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645637975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=g0YIzePoWzAZ4Uvnm49byjS7oxjoYq8edIxADQrVPyU=;
        b=hyLDcdco9pcxOsUFOHfBuUy1pDsGbEWFw7QZ8l1lk4KR6O3F3DAk2Geu11gbBFR2DCTr0X
        ChUcIMCnN4QFufWvZ28wdusRe8NKKw3ltJcDyKbikFRanyNu76QCRILf0XbaMfODp5sfQt
        AXblI4oinJ2VQnql++MhoYKvyMaSpRU=
Date:   Wed, 23 Feb 2022 18:39:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     luofei <luofei@unicloud.com>
Cc:     tony.luck@intel.com, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        naoya.horiguchi@nec.com, akpm@linux-foundation.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v5 1/2] mm/hwpoison: Avoid the impact of
 hwpoison_filter() return value on mce handler
Message-ID: <YhZxWjei2Iw65mAF@zn.tnic>
References: <20220223082135.2769649-1-luofei@unicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220223082135.2769649-1-luofei@unicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Feb 23, 2022 at 03:21:35AM -0500, luofei wrote:
> When the hwpoison page meets the filter conditions, it should
> not be regarded as successful memory_failure() processing for
> mce handler, but should return a distinct value, otherwise
> mce handler regards the error page has been identified and
> isolated, which may lead to calling set_mce_nospec() to change
> page attribute, etc.
> 
> Here memory_failure() return -EOPNOTSUPP to indicate that the
> error event is filtered, mce handler should not take any action
> for this situation and hwpoison injector should treat as correct.
> 
> Signed-off-by: luofei <luofei@unicloud.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 8 +++++---
>  drivers/base/memory.c          | 2 ++
>  mm/hwpoison-inject.c           | 3 ++-
>  mm/madvise.c                   | 2 ++
>  mm/memory-failure.c            | 9 +++++++--
>  5 files changed, 18 insertions(+), 6 deletions(-)

Much better, thanks.

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
