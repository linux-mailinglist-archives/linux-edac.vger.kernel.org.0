Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88559F38AF
	for <lists+linux-edac@lfdr.de>; Thu,  7 Nov 2019 20:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbfKGTej (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 7 Nov 2019 14:34:39 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52072 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbfKGTei (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 7 Nov 2019 14:34:38 -0500
Received: from zn.tnic (p200300EC2F0EAD0094343B71594E3CFE.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:ad00:9434:3b71:594e:3cfe])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 542881EC0CF0;
        Thu,  7 Nov 2019 20:34:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573155273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GenYAH9kQ7BwOZzZLD61Q4hP43MBwiw5oE3TXDHvPdQ=;
        b=DnHO5zxJqcw3UlGOo8wxx5KTfMQrz5Iyw78c2GbifobaR+bLZD/attNfId8h8/ht3i0LXT
        FKPnZ+8GMn73MhhpIPLWg9Q1v1+SxSajCe6ljfAcc0lkOfV0Si9hsAA80f3ltbbYEoM9Id
        93o7HehccAlz+u3ZfmOxbzcRSxOX8nM=
Date:   Thu, 7 Nov 2019 20:34:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] AMD64 EDAC: Check for nodes without memory, etc.
Message-ID: <20191107193429.GI19501@zn.tnic>
References: <20191106012448.243970-1-Yazen.Ghannam@amd.com>
 <20191106160607.GC28380@zn.tnic>
 <SN6PR12MB26398D9E617DF8C0ABE0252CF8790@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20191106195417.GF28380@zn.tnic>
 <20191107103857.GC19501@zn.tnic>
 <SN6PR12MB263984026F57EC7F3B33B2BFF8780@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20191107154006.GF19501@zn.tnic>
 <SN6PR12MB263925E6F18C3EDC8D398932F8780@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB263925E6F18C3EDC8D398932F8780@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Nov 07, 2019 at 07:20:25PM +0000, Ghannam, Yazen wrote:
> Yes, that's right. But it looks like future systems will re-use PCI IDs even
> across families and models. And the PCI IDs will be more closely related to
> hardware capabilities than family and model.
> 
> In any case, we can address that when we get there.

I'd be fine with it if this really is the case and we don't end up
having to keep adding PCI IDs like crazy again. That was a moderate
PITA, AFAIR, especially for distro kernels having to constantly pick up
enablement patches and people complaining about it.

So you need to make sure the PCI IDs will really get reused before
converting back...

> >         if (!ecc_en || !nb_mce_en)
> >                 return false;
> >         else
> 
> Right, I meant you can drop this else and just return true.
> 
> >                 return true;

I prefer the regular if-else way because it reads faster and it is
straight-forward when one skims over the code.

But I can drop if if you insist. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
