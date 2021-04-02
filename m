Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD15352DFD
	for <lists+linux-edac@lfdr.de>; Fri,  2 Apr 2021 19:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbhDBRHi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Apr 2021 13:07:38 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37026 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229722AbhDBRHh (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 2 Apr 2021 13:07:37 -0400
Received: from zn.tnic (p200300ec2f0a2000dbf770433a2c90d5.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:2000:dbf7:7043:3a2c:90d5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4B3F81EC036C;
        Fri,  2 Apr 2021 19:07:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1617383255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=euJLUWQa2u+XPOsgFmEOgV9vS2H3yqYKVzrt+5aZ+XY=;
        b=nHErEZvLeOOYYjdad438mYJGLNTDyIedW8FqyIZI4qEthxxAajEdqygb7Jg3KHx7705Zqo
        4wDrflVqmGkyJ+iuXJEiQf5H9BW2OavzUJ+bADa61DSUSR3zscRdDAVs5pxLfiGqwjnQpR
        qvn+KoueXIHPnBPnxx/RNP+qeU4tFC8=
Date:   Fri, 2 Apr 2021 19:07:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     William Roche <william.roche@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v1] RAS/CEC: Memory Corrected Errors consistent event
 filtering
Message-ID: <20210402170736.GJ28499@zn.tnic>
References: <1616783429-6793-1-git-send-email-william.roche@oracle.com>
 <20210326190242.GI25229@zn.tnic>
 <fac89612-e15c-2940-9d6d-70a812dbe99c@oracle.com>
 <20210326224310.GL25229@zn.tnic>
 <3ee5551c-d311-1939-315f-a4712e3821ff@oracle.com>
 <20210401161237.GC28954@zn.tnic>
 <5ba128f6-62f3-beb2-9f04-fdebaf411414@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ba128f6-62f3-beb2-9f04-fdebaf411414@oracle.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Apr 02, 2021 at 06:00:42PM +0200, William Roche wrote:
> Corrected Errors are not the best indicators for a failing DIMM

In the OS, errors reported through different mechanisms is all we have.

> For the moment we will have the CE MCE handled my the MCE_HANDLED_CEC
> aware notifiers only when a page is off-lined, like it used to be.
> 
> Can we start with that small fix ?

Sure but do two variables pls - an "err" one which catches the
function's retval and a "ret" one which ce_add_elem() itself returns so
that there's no confusion like it was before:

---
diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index ddecf25b5dd4..b926c679cdaf 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -312,8 +312,8 @@ static bool sanity_check(struct ce_array *ca)
 static int cec_add_elem(u64 pfn)
 {
 	struct ce_array *ca = &ce_arr;
+	int count, err, ret = 0;
 	unsigned int to = 0;
-	int count, ret = 0;
 
 	/*
 	 * We can be called very early on the identify_cpu() path where we are
@@ -330,8 +330,8 @@ static int cec_add_elem(u64 pfn)
 	if (ca->n == MAX_ELEMS)
 		WARN_ON(!del_lru_elem_unlocked(ca));
 
-	ret = find_elem(ca, pfn, &to);
-	if (ret < 0) {
+	err = find_elem(ca, pfn, &to);
+	if (err < 0) {
 		/*
 		 * Shift range [to-end] to make room for one more element.
 		 */

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
