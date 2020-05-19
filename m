Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CA91DA39D
	for <lists+linux-edac@lfdr.de>; Tue, 19 May 2020 23:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgESVa5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 19 May 2020 17:30:57 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59356 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgESVa5 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 19 May 2020 17:30:57 -0400
Received: from zn.tnic (p200300ec2f0b87001461a870af27ee92.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:8700:1461:a870:af27:ee92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BB1E71EC0116;
        Tue, 19 May 2020 23:30:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1589923855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SIFdEg6GcNVZI8m+o4nVBjfAN7p3vODxjCvJqV3wrjs=;
        b=elpzgzYGuUqgOZ3iYwPwU0vO4iNdx7ImGZaBt7EQOXNb+jjkafEqyQpW7/epigIv/Spf0K
        HPcTyH+9mfJ2d7vnUPk4cNe0LV9L1OU/87vuRpdk0aS+5+kFWhYU6Qs855zaKvaYwie5HC
        cAlV/DSXMwn0XqpSZmoKfGrJLjeeLGo=
Date:   Tue, 19 May 2020 23:30:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Matthias Brugger <mbrugger@suse.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] EDAC/ghes: Setup DIMM label from DMI and use it in
 error reports
Message-ID: <20200519213050.GE444@zn.tnic>
References: <20200518095852.28010-1-rrichter@marvell.com>
 <20200519202535.GC444@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200519202535.GC444@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, May 19, 2020 at 10:25:35PM +0200, Borislav Petkov wrote:
> but I'm guessing that dmi_memdev_name() doesn't give on my machine what
> it gives on yours.

IOW, this ontop:

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index c7d404629863..f84c117c4310 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -109,9 +109,9 @@ static void dimm_setup_label(struct dimm_info *dimm, u16 handle)
        if (bank && *bank && device && *device)
                snprintf(dimm->label, sizeof(dimm->label),
                        "%s %s", bank, device);
-       else
-               snprintf(dimm->label, sizeof(dimm->label),
-                       "unknown memory (handle: 0x%.4x)", handle);
+       /*
+        * else fallback to the EDAC default name.
+        */
 }
 
 static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
