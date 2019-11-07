Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A697F3389
	for <lists+linux-edac@lfdr.de>; Thu,  7 Nov 2019 16:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbfKGPkN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 7 Nov 2019 10:40:13 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39036 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbfKGPkM (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 7 Nov 2019 10:40:12 -0500
Received: from zn.tnic (p200300EC2F0EAD0005075A6AC44F3288.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:ad00:507:5a6a:c44f:3288])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C44B21EC0CF7;
        Thu,  7 Nov 2019 16:40:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573141207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=eAnfQdd7N6fknAtquSRK+MKVOqjcPX9i2EkihseahM4=;
        b=J/uXnq5Opaxro9jWkn9QvvR3qjhsjqEEGuPEbRrhyszkuAqGWUIIrXfa8xW7KHg5a1f9+r
        EoM1yMK1zzZvt5Ja4YwfvNfdtDsUgMlvKhNms6CsqBVDjy1DxqlxCop/+XmGuD2U1w4eR5
        gaQx1BZ6lujT2pAXRmESrOE4ZsDuDhQ=
Date:   Thu, 7 Nov 2019 16:40:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] AMD64 EDAC: Check for nodes without memory, etc.
Message-ID: <20191107154006.GF19501@zn.tnic>
References: <20191106012448.243970-1-Yazen.Ghannam@amd.com>
 <20191106160607.GC28380@zn.tnic>
 <SN6PR12MB26398D9E617DF8C0ABE0252CF8790@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20191106195417.GF28380@zn.tnic>
 <20191107103857.GC19501@zn.tnic>
 <SN6PR12MB263984026F57EC7F3B33B2BFF8780@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB263984026F57EC7F3B33B2BFF8780@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Nov 07, 2019 at 01:47:53PM +0000, Ghannam, Yazen wrote:
> BTW, what do you think about loading based on PCI devices? The module
> used to do this. I ask because I'm starting to see that future systems may
> re-use PCI IDs, and this indicates the same level of hardware support.

The reason we switched to family-based autoloading was that almost
every new platform would add a new PCI device ID, which would require
enablement work...

> Just a nit, but this else seems unnecessary right?

Maybe it is easier if you look at the function end in the .c file directly as
diffs can be confusing:

static bool ecc_enabled(struct amd64_pvt *pvt)
{

	...

        amd64_info("Node %d: DRAM ECC %s.\n",
                   nid, (ecc_en ? "enabled" : "disabled"));

        if (!ecc_en || !nb_mce_en)
                return false;
        else
                return true;
}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
