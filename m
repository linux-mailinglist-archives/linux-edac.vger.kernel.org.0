Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6F22CD48D
	for <lists+linux-edac@lfdr.de>; Thu,  3 Dec 2020 12:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgLCL2P (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Dec 2020 06:28:15 -0500
Received: from ozlabs.org ([203.11.71.1]:48791 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbgLCL2P (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 3 Dec 2020 06:28:15 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Cmtq71dWPz9sW0;
        Thu,  3 Dec 2020 22:27:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1606994852;
        bh=DhZJx6VS2S3i6rp5eGQb6lMVR2DlQIxOHgVG1xjGFrE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fZP6igB0dffXJpVPcdAMjoblQ8MgiPxVagbU9j32aVvdtENZ340u7asmb/zevIMam
         0Zljjs9YIrqkIlnKZNVdDT3NCKBiIziUjE/G02oMM1J4m1sbKNebe4IpqGKedl8RAl
         wU3n3OS6J1yqIJPH3Bqdx9iUtYQbs6Os7HVLNgJnO3GdxCQq3KYZC6ZG8wehxxixcr
         JXHk6z0kY89GyKR60cUw2IYC7ReC5nPHHRs4ESewl/BBx98TlPWJvt21tXRj3BqsPy
         THBPRrHyz/KN9pSs65pYUw6EGble1woG2YzV7nYVM6C9R1AvLrCykcMzvNV+MlRVnU
         V7fkwXYOLHmfg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Borislav Petkov <bp@alien8.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     Wang ShaoBo <bobo.shaobowang@huawei.com>, mchehab@kernel.org,
        james.morse@arm.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, huawei.libin@huawei.com,
        cj.chengjian@huawei.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] EDAC, mv64x60: Fix error return code in mv64x60_pci_err_probe()
In-Reply-To: <20201202112515.GC2951@zn.tnic>
References: <20201124063009.1529-1-bobo.shaobowang@huawei.com> <20201202112515.GC2951@zn.tnic>
Date:   Thu, 03 Dec 2020 22:27:25 +1100
Message-ID: <87pn3ruo2q.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:
> On Tue, Nov 24, 2020 at 02:30:09PM +0800, Wang ShaoBo wrote:
>> Fix to return -ENODEV error code when edac_pci_add_device() failed instaed
>> of 0 in mv64x60_pci_err_probe(), as done elsewhere in this function.
>> 
>> Fixes: 4f4aeeabc061 ("drivers-edac: add marvell mv64x60 driver")
>> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
>> ---
>>  drivers/edac/mv64x60_edac.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/drivers/edac/mv64x60_edac.c b/drivers/edac/mv64x60_edac.c
>> index 3c68bb525d5d..456b9ca1fe8d 100644
>> --- a/drivers/edac/mv64x60_edac.c
>> +++ b/drivers/edac/mv64x60_edac.c
>> @@ -168,6 +168,7 @@ static int mv64x60_pci_err_probe(struct platform_device *pdev)
>>  
>>  	if (edac_pci_add_device(pci, pdata->edac_idx) > 0) {
>>  		edac_dbg(3, "failed edac_pci_add_device()\n");
>> +		res = -ENODEV;
>>  		goto err;
>>  	}
>
> That driver depends on MV64X60 and I don't see anything in the tree
> enabling it and I can't select it AFAICT:
>
> config MV64X60
>         bool
>         select PPC_INDIRECT_PCI
>         select CHECK_CACHE_COHERENCY

It was selected by PPC_C2K, but that was dropped in:

  92c8c16f3457 ("powerpc/embedded6xx: Remove C2K board support")

> PPC folks, what do we do here?
>
> If not used anymore, I'd love to have one less EDAC driver.

It's dead code, so drop it.

I can send a patch if no one else wants to.

cheers
