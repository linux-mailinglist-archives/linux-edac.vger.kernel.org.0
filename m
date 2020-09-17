Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A017026E0F4
	for <lists+linux-edac@lfdr.de>; Thu, 17 Sep 2020 18:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgIQQl2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 17 Sep 2020 12:41:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38044 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728537AbgIQQk5 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 17 Sep 2020 12:40:57 -0400
Received: from zn.tnic (p200300ec2f105300c872f9f06eecfc48.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:5300:c872:f9f0:6eec:fc48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7182A1EC037C;
        Thu, 17 Sep 2020 18:40:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600360855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=x75byr5tRA3UvdckcFoWl2xo1AcldQR1ZS4h77zB560=;
        b=ls3G8vFnGCoEcczlb+o5Gph42paXYsTqnynDesCzz3riU8TMPZsusWinIIfZ7lovC+/Q93
        hsmlZPDcjnp63cD+I8ZwPtTa3ax+5yar2ZRPz7QO/F946l7zSKvPB8D1OpS+0XBohtMkck
        jTn/sD+qHwD4PnKMq582/NqqTcurWjw=
Date:   Thu, 17 Sep 2020 18:40:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 1/8] x86/CPU/AMD: Save NodeId on AMD-based systems
Message-ID: <20200917164048.GM31960@zn.tnic>
References: <20200903200144.310991-1-Yazen.Ghannam@amd.com>
 <20200903200144.310991-2-Yazen.Ghannam@amd.com>
 <20200909180647.GF12237@zn.tnic>
 <20200909201755.GB3014671@yaz-nikka.amd.com>
 <20200910101443.GC8357@zn.tnic>
 <20200914192039.GA39519@yaz-nikka.amd.com>
 <20200915083259.GC14436@zn.tnic>
 <20200916195152.GA3042858@yaz-nikka.amd.com>
 <20200917103720.GG31960@zn.tnic>
 <20200917162053.GA234735@yaz-nikka.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200917162053.GA234735@yaz-nikka.amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Sep 17, 2020 at 11:20:53AM -0500, Yazen Ghannam wrote:
> But newer systems support CPUID Leaf 0xB, so cpu_die_id will get
> explicitly set by detect_extended_topology(). The value set is
> different from the AMD NodeId. And at that point I shied away from
> doing any override or fixup.

Well, different how? Can you extract the node_id you need
from CPUID(0xb)? If yes, we can do an AMD-specific branch in
detect_extended_topology() but that better be future proof.

IOW, is information from CPUID(0xb) ever going to be needed in the
kernel?

Also, and independently, if its definition do not give you the
node_id you need, then you can just as well overwrite ->cpu_die_id in
detect_extended_topology() because that value - whatever that is, could
be garbage, just as well - is wrong on AMD anyway.

So it would be a fix for the leaf parsing, regardless of whether you
need it or not.

Makes sense?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
