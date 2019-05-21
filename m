Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F416025AA8
	for <lists+linux-edac@lfdr.de>; Wed, 22 May 2019 01:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfEUXI6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 21 May 2019 19:08:58 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39760 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfEUXI6 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 21 May 2019 19:08:58 -0400
Received: from cz.tnic (ip65-44-65-130.z65-44-65.customer.algx.net [65.44.65.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DC62D1EC0985;
        Wed, 22 May 2019 01:08:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1558480136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=EIdRJ7cchJzsPWh8oSXAVoiBUsWWI7yDYXgxiIhpyks=;
        b=c+DcKV1+rSvE2Q38daXtOHBxG2l0GNIbdFOl/CLuMqxlXh1bd0bzNx/9AS+Hv0wajENYrD
        Atz7iMEi8/uWurpgeOpu7o7IdxCdSJVZ4xQUZsshemzDUlLXPoTi6EB0kuvmHie/ehnyhG
        S9o6nciWAc+CC2dslomEGDzSOR9GjhI=
Date:   Wed, 22 May 2019 01:09:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 4/6] x86/MCE: Make number of MCA banks per_cpu
Message-ID: <20190521230927.GB2435@cz.tnic>
References: <20190430203206.104163-1-Yazen.Ghannam@amd.com>
 <20190430203206.104163-5-Yazen.Ghannam@amd.com>
 <20190518112530.GA26276@zn.tnic>
 <SN6PR12MB2639571E33EBC7342A0607F8F8070@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190521202902.GC7793@cz.tnic>
 <20190521204239.GA11029@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190521204239.GA11029@agluck-desk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, May 21, 2019 at 01:42:40PM -0700, Luck, Tony wrote:
> On Tue, May 21, 2019 at 10:29:02PM +0200, Borislav Petkov wrote:
> > 
> > Can we do instead:
> > 
> > -static DEFINE_PER_CPU_READ_MOSTLY(struct mce_bank *, mce_banks_array);
> > +static DEFINE_PER_CPU_READ_MOSTLY(struct mce_bank, mce_banks_array[MAX_NR_BANKS]);
> > 
> > which should be something like 9*32 = 288 bytes per CPU.
> > 
> 
> Where did you get the "9" from?  struct mce_bank looks to
> be over 50 bytes.

Patch 2/6 changes that:

 struct mce_bank {
        u64                     ctl;                    /* subevents to enable */
        bool                    init;                   /* initialise bank? */
+};
+static DEFINE_PER_CPU_READ_MOSTLY(struct mce_bank *, mce_banks_percpu);
+
+#define ATTR_LEN               16
+/* One object for each MCE bank, shared by all CPUs */
+struct mce_bank_dev {
        struct device_attribute attr;                   /* device attribute */
        char                    attrname[ATTR_LEN];     /* attribute name */
+       u8                      bank;                   /* bank number */
 };
+static struct mce_bank_dev mce_bank_devs[MAX_NR_BANKS];

> Still only 1.5K per cpu though.

Yah, I think that using static per-CPU memory should be better than
GFP_ATOMIC.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply. Srsly.
