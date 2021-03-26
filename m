Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0AD34AEE8
	for <lists+linux-edac@lfdr.de>; Fri, 26 Mar 2021 20:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhCZTDR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 26 Mar 2021 15:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhCZTCq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 26 Mar 2021 15:02:46 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1DDC0613AA;
        Fri, 26 Mar 2021 12:02:46 -0700 (PDT)
Received: from zn.tnic (p200300ec2f075f009137b2b45d3c68fe.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:5f00:9137:b2b4:5d3c:68fe])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9A07D1EC0535;
        Fri, 26 Mar 2021 20:02:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1616785364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pNepeXgzN5qI4UVgnwILkLgRD+nXFi0Pb4g+8b0wXzU=;
        b=cckApBH0xFu4mMTQPL9igk2tMFUKsCwvt617mpgXQHPPGvmVAE1lfvMbRU5Do/fxiYwVGN
        EEWdZ2qJYvB7veyodc4/bLOM+O+HCEZPilcbsAQC9KXXCzYXxd0QD1qNhYl41SRQsdGDt8
        HBblwvnA2rn6OZsChWTr9mg3A+1HZBI=
Date:   Fri, 26 Mar 2021 20:02:42 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     =?utf-8?Q?=E2=80=9CWilliam?= Roche <william.roche@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v1] RAS/CEC: Memory Corrected Errors consistent event
 filtering
Message-ID: <20210326190242.GI25229@zn.tnic>
References: <1616783429-6793-1-git-send-email-william.roche@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1616783429-6793-1-git-send-email-william.roche@oracle.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Mar 26, 2021 at 02:30:29PM -0400, “William Roche wrote:
> From: William Roche <william.roche@oracle.com>
> 
> The Corrected Error events collected by the cec_add_elem() have to be
> consistently filtered out.
> We fix the case where the value of find_elem() to find the slot of a pfn
> was mistakenly used as the return value of the function.
> Now the MCE notifiers chain relying on MCE_HANDLED_CEC would only report
> filtered corrected errors that reached the action threshold.
> 
> Signed-off-by: William Roche <william.roche@oracle.com>
> ---
> 
> Notes:
>     Some machines are reporting Corrected Errors events without any
>     information about a PFN Soft-offlining or Invalid pfn (report given by
>     the EDAC module or the mcelog daemon).
>     
>     A research showed that it reflected the first occurrence of a CE error
>     on the system which should have been filtered by the RAS_CEC component.
>     We could also notice that if 2 PFNs are impacted by CE errors, the PFN
>     on the non-zero slot gets its CE errors reported every-time instead of
>     being filtered out.
>     
>     This problem has appeared with the introduction of commit
>     de0e0624d86ff9fc512dedb297f8978698abf21a where the filtering logic has
>     been modified.
>     
>     Could you please review this small suggested fix ?
>     
>     Thanks in advance for any feedback you could have.
>     William.
> 
>  drivers/ras/cec.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

AFAIU, I think you want something like the below untested hunk:

You set it to 0 when it cannot find an element and that "ret = 1" we can
remove because callers don't care about the offlining threshold - the
only caller that looks at its retval wants to know whether it added the
VA successfully to note that it handled the error.

Makes sense?

---
diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index ddecf25b5dd4..a29994d726d8 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -341,6 +341,8 @@ static int cec_add_elem(u64 pfn)
 
 		ca->array[to] = pfn << PAGE_SHIFT;
 		ca->n++;
+
+		ret = 0;
 	}
 
 	/* Add/refresh element generation and increment count */
@@ -363,12 +365,6 @@ static int cec_add_elem(u64 pfn)
 
 		del_elem(ca, to);
 
-		/*
-		 * Return a >0 value to callers, to denote that we've reached
-		 * the offlining threshold.
-		 */
-		ret = 1;
-
 		goto unlock;
 	}
---

Thx.
 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
