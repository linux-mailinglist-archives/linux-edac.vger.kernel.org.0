Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5601F20FA4
	for <lists+linux-edac@lfdr.de>; Thu, 16 May 2019 22:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfEPUfD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 May 2019 16:35:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50078 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbfEPUfD (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 16 May 2019 16:35:03 -0400
Received: from zn.tnic (p200300EC2F0D4A00D10F299FBE6A838D.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:4a00:d10f:299f:be6a:838d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 76A931EC0959;
        Thu, 16 May 2019 22:35:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1558038901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1ReQB9oiyFBKZIclgw+7DRudVx2rtCWprg9O8R4zH6Y=;
        b=R577fUqG8BAz6rKy0rkn6k+D0EJsy65AP2AWMI5cMdGp/VRhhDInwX/i1e6DW1ITPYmKLB
        NecJDNETwqsAjeyeqYmEz7BCq/oY5i8nwHZq1PibsL9PkVbSReag79LU4nzhymRZ7Fj7uW
        IHHRnRS0405t1OB6MueqazwH4ToD+fw=
Date:   Thu, 16 May 2019 22:34:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 5/6] x86/MCE: Save MCA control bits that get set in
 hardware
Message-ID: <20190516203456.GD21857@zn.tnic>
References: <20190430203206.104163-1-Yazen.Ghannam@amd.com>
 <20190430203206.104163-6-Yazen.Ghannam@amd.com>
 <20190516155202.GA11517@agluck-desk>
 <SN6PR12MB26397B30A120E3426184727FF80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190516165648.GB21857@zn.tnic>
 <SN6PR12MB26392B440ED735C26AA2C678F80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190516172117.GC21857@zn.tnic>
 <SN6PR12MB26394CD4E1BAC068B0B1AEF6F80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB26394CD4E1BAC068B0B1AEF6F80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, May 16, 2019 at 08:20:58PM +0000, Ghannam, Yazen wrote:
> We don't actually know if there are bits set in hardware until we read
> it back. So I don't think this is adding anything new.

Bah, of course. We need to read it first (pasting the whole function).
Now, __mcheck_cpu_init_clear_banks() gets called when we change
configuration too, in mce_cpu_restart() and if we do it this way, we'll
be rereading MCi_CTL each time but I don't see anything wrong with that.

Hmmm?

static void __mcheck_cpu_init_clear_banks(void)
{
        struct mce_bank *mce_banks = this_cpu_read(mce_banks_array);
        int i;

        for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
                struct mce_bank *b = &mce_banks[i];

                rdmsrl(msr_ops.ctl(i), b->ctl);

                /* Bank is initialized if bits are set in hardware. */
                b->init = !!b->ctl;
                if (b->init) {
                        wrmsrl(msr_ops.ctl(i), b->ctl);
                        wrmsrl(msr_ops.status(i), 0);
                }

        }
}

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
