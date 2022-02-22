Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EFE4BFD27
	for <lists+linux-edac@lfdr.de>; Tue, 22 Feb 2022 16:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbiBVPhk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 22 Feb 2022 10:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbiBVPhW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 22 Feb 2022 10:37:22 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D90163D5A;
        Tue, 22 Feb 2022 07:36:23 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8A88A1EC0478;
        Tue, 22 Feb 2022 16:36:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645544177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=aij7NjY9ZQjgmVDgEW1KRwEwnwbxjt+LJNVGVugfzBg=;
        b=mVLxeE0TUg9Jlj9JbMpInhMy0w0ftP1W3XN+a4MG+VO4BtBq0a5upSYITit3RuUFiEgFao
        0uQAQckBp4+TLx2ACyGqLWfoZ9H4QPUkuLy5Gn15czprfb1SZOjWc0ipqFyFSDXfDtdtWG
        EQVeCJIu9PeLyP6E3uWJ/JB5ijiquxU=
Date:   Tue, 22 Feb 2022 16:36:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v3 4/4] x86/mce: Avoid unnecessary padding in struct
 mce_bank
Message-ID: <YhUC+T44sQK43+QZ@zn.tnic>
References: <20220211223442.254489-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220211223442.254489-5-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220211223442.254489-5-Smita.KoralahalliChannabasappa@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Feb 11, 2022 at 04:34:42PM -0600, Smita Koralahalli wrote:
> Include struct mce_bank member "init" in the bitfield by changing its type
> from bool to get rid of unnecessary padding and to reduce the overall
> struct size.
> 
> Outputs collected before and after the change.
> 
> $ pahole -C mce_bank arch/x86/kernel/cpu/mce/core.o
> 
> before:
> 
> 	/* size: 24, cachelines: 1, members: 5 */
> 	/* bit holes: 1, sum bit holes: 62 bits */
> 	/* bit_padding: 2 bits */
> 	/* last cacheline: 24 bytes */
> 
> after:
> 
> 	/* size: 16, cachelines: 1, members: 5 */
> 	/* last cacheline: 16 bytes */

I don't mind cleanups like that but when you send them as part of a set
adding new functionality, the usual rule is to put bug fixes, cleanups,
improvements, etc to the existing code *first*, and then, ontop you add
your new code.

IOW, this patch should be first in your set.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
