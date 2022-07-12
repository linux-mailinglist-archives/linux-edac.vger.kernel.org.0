Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4F3571BF2
	for <lists+linux-edac@lfdr.de>; Tue, 12 Jul 2022 16:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiGLOIF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 12 Jul 2022 10:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiGLOID (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 12 Jul 2022 10:08:03 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947002655C;
        Tue, 12 Jul 2022 07:08:02 -0700 (PDT)
Received: from nazgul.tnic (unknown [193.86.92.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 218971EC008F;
        Tue, 12 Jul 2022 16:07:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1657634877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QWJ+poG5yR9gfOjP062iPsNf/GEy2q/sVxwS/bUIYNE=;
        b=dIx/zvXqBMJBB7HX2cpGBd+EOGQBm/v4vs7veaIDqCn24HjhVt2E6q2WzPG2x8YUGPzk/V
        jqlSexR6ZRSBKvzbRLiNJBUPH36oMhy5kbgK3rvfYIi4mB9XEJgrploR17tFopS02Y35bt
        757wMEpFt6RgXJX5O4Z04p+w1AMOKHc=
Date:   Tue, 12 Jul 2022 16:08:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v5 2/2] x86/mce: Add support for Extended Physical
 Address MCA changes
Message-ID: <Ys2ARtIOnkAh6zzk@nazgul.tnic>
References: <YlbkCK9LU2KdXZUG@zn.tnic>
 <YlbzbZO6AvxOqQb/@agluck-desk3.sc.intel.com>
 <Ylb3/4oi6KAjdsJW@zn.tnic>
 <YlcnN2q9ducdvsUZ@yaz-ubuntu>
 <YlflJfyQR/j/eRkn@zn.tnic>
 <YlmHtlKABn9W0pu5@yaz-ubuntu>
 <YlmfZU2Bg5cRk07J@agluck-desk3.sc.intel.com>
 <YqJHwXkg3Ny9fI3s@yaz-fattaah>
 <YrnTMmwl5TrHwT9J@zn.tnic>
 <Ys18XVCB7CeR/jVw@yaz-fattaah>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ys18XVCB7CeR/jVw@yaz-fattaah>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jul 12, 2022 at 01:51:25PM +0000, Yazen Ghannam wrote:
> Thanks. Do you want a set with yours, mine, and Smita's patches all together?

Sure, whatever you have ready.

No hurry, though, we'll probably have merge window next week...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
