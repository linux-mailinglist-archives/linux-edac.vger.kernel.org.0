Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D25E27816C
	for <lists+linux-edac@lfdr.de>; Fri, 25 Sep 2020 09:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgIYHXD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 25 Sep 2020 03:23:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54216 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbgIYHXD (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 25 Sep 2020 03:23:03 -0400
Received: from zn.tnic (p200300ec2f0b3a00d3756fc4b2470eaa.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:3a00:d375:6fc4:b247:eaa])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A5DB91EC0473;
        Fri, 25 Sep 2020 09:23:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601018581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Wjlu/ndJbxVTFlpp3T1F/epZ459T0Uni2kaVnS/ZU6M=;
        b=mdRVSHbtVf7FFy4Uxm049cBs2q8MUyePRVieH4Q2zgvP/UJJ2lw3FGflMQhwn7ofkbHP87
        fI72aMJ4JbJnrCMxtCQWMiPS1XD9Ou/DxYW4AIw0+ilKgEMheHz3cqJg7TvNyGG8QHg+i3
        gDZBrDnPEGIdqs77M5qk8wFH15Iqjl4=
Date:   Fri, 25 Sep 2020 09:22:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 8/8] x86/MCE/AMD Support new memory interleaving modes
 during address translation
Message-ID: <20200925072231.GC16872@zn.tnic>
References: <20200903200144.310991-1-Yazen.Ghannam@amd.com>
 <20200903200144.310991-9-Yazen.Ghannam@amd.com>
 <20200923082039.GB28545@zn.tnic>
 <20200923162510.GB1684790@yaz-nikka.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200923162510.GB1684790@yaz-nikka.amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Sep 23, 2020 at 11:25:10AM -0500, Yazen Ghannam wrote:
> I don't remember the original reason, and I was recently asked about
> this code living in a module. I did some looking after this ask, and I
> found that we should be using this translation to get a proper value for
> the memory error notifiers to use. So I think we still need to use this
> function some way with the core code even if the EDAC interface isn't
> used.

You'd need to be more specific here, you want to bypass amd64_edac to
decode errors? Judging by the current RAS activity coming from you guys,
I'm thinking firmware. But then wouldn't the firmware do the decoding
for us and then this function is not even needed?

> What do you think?

I think you should explain what the use case is first. :)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
