Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE479481BC1
	for <lists+linux-edac@lfdr.de>; Thu, 30 Dec 2021 12:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238869AbhL3Lgs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 30 Dec 2021 06:36:48 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57882 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235195AbhL3Lgr (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 30 Dec 2021 06:36:47 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 436E51EC04FB;
        Thu, 30 Dec 2021 12:36:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640864202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=AVrysX5wSe1p4jfVYyywrt1X33OJViyHDBCWQ71sm6E=;
        b=sPkBnDbB411OC5zaCV34PbPt58vHOA4yIQ9+JL7+notweJCeXFZ8D+H3zBsYJLswxqN7eY
        OiFnpupneTNGz7IMQ5xqA0E2m8FndT1gzxeDigbg6cdcXQoF1TKxUdohKhhCYeJVCeFtyD
        yUkZXexBsvyiywJ3xJ7E1eTJbWmWDd4=
Date:   Thu, 30 Dec 2021 12:36:44 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com,
        william.roche@oracle.com
Subject: Re: [PATCH v2 1/2] EDAC/amd64: Check register values from all UMCs
Message-ID: <Yc2ZzMT+Mg5xCvjI@zn.tnic>
References: <20211215155309.2711917-1-yazen.ghannam@amd.com>
 <20211215155309.2711917-2-yazen.ghannam@amd.com>
 <YbotciKVDsH1Fl1H@zn.tnic>
 <YbtkcppejpW8gHqY@yaz-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YbtkcppejpW8gHqY@yaz-ubuntu>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Dec 16, 2021 at 04:08:18PM +0000, Yazen Ghannam wrote:
> No, that's a good question. And actually the assumption is incorrect. It is
> allowed to have different DIMM types in a system though all DIMMs on a single
> UMC must match.

Oh fun, really?!

So a single system can have DDR4 *and* DDR5 on the same board?!

So then that

	pvt->dram_type

is insufficient to store the DIMM type for a pvt. If you have multiple
UMCs on a pvt and all have different type DIMMs, then you need the
relevant DIMM type when you dump it in sysfs...

Which then means, you need ->dram_type to be per UMC...

And also, I'm assuming the hw already enforces that DIMMs on a single
UMC must match - it simply won't boot if they don't so you don't have to
enforce that, at least.

> Do you recommend a follow up patch or should this one be reworked?

This one is insufficient, I'm afraid.

One way to address this is, you could use pvt->umc at the places where
dram_type is used and assign directly to the dimm->mtype thing. But then
you'd need a way to map each struct dimm_info *dimm to the UMC so that
you can determine the correct DIMM type.

Which would make pvt->dram_type redundant and can be removed.

Or you might have a better idea...

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
