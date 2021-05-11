Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CC437ABE6
	for <lists+linux-edac@lfdr.de>; Tue, 11 May 2021 18:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhEKQ3c (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 11 May 2021 12:29:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33360 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229921AbhEKQ3b (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 11 May 2021 12:29:31 -0400
Received: from zn.tnic (p200300ec2f0ec70020ab858661d7f414.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:c700:20ab:8586:61d7:f414])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 53DD81EC01A9;
        Tue, 11 May 2021 18:28:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1620750503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=l70VFQfSykNK0/Kv6Zb9CBwNvFZiAaJ15I4cl2Oz1Zc=;
        b=aD62trHtFrrxaAZp9DjeWDf1xk9g/mpwA1u4zFkCxSWZqpNFRNC4w3C3G1xNRtYiJI3/AX
        +siWnezRdcFDa4VnqR10/3KGB7Hlf3SQiRAskrBfaA97WdXIEKAnjBhV3oT1CTF2j4YN5i
        7VBlN+gyrnBfIfzpyC0+SDg4USMB5A8=
Date:   Tue, 11 May 2021 18:28:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH 00/25] AMD MCA Address Translation Updates
Message-ID: <YJqwpKBsKL1QKR5z@zn.tnic>
References: <20210507190140.18854-1-Yazen.Ghannam@amd.com>
 <1bd2362b-9bbd-c813-e678-66119b53859f@infradead.org>
 <20210511154232.GA17213@aus-x-yghannam.amd.com>
 <ed4953c7-542e-7d57-7787-9bb53dad71b4@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ed4953c7-542e-7d57-7787-9bb53dad71b4@infradead.org>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, May 11, 2021 at 09:13:56AM -0700, Randy Dunlap wrote:
> Cover letter seems good to me.

Cover letter gets lost and if we didn't have lore.kernel.org, it
would be a total waste of effort. I think if it is only a small,
acronym-mapping thing, the top of drivers/edac/mce_amd.c should be a
much better place.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
