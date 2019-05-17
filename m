Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C33E721BB8
	for <lists+linux-edac@lfdr.de>; Fri, 17 May 2019 18:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfEQQhd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 May 2019 12:37:33 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49620 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfEQQhd (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 17 May 2019 12:37:33 -0400
Received: from zn.tnic (p200300EC2F0C50007C4D1753FB652448.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:5000:7c4d:1753:fb65:2448])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E1381EC06AC;
        Fri, 17 May 2019 18:37:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1558111051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=R+DLA5iRGQqWnyGYcrpwBxvt4tXhyqLm8zmuwC1fXXw=;
        b=LeIHLkPlhv3/cBmM4ttLviR6CNztW9aHS4gyALN/6R0SGSUIJUoqbLM2K2cy0fFYI9xW7y
        z3uFEWqGq4pcOoCHnW5WVGXNyroLhWwqkqdjjddNIBp6V4rvSFk4KEAV1UQWDahTv/hqWu
        /U4bLKURpbilaUq4tRDd4MXirrl5+SE=
Date:   Fri, 17 May 2019 18:37:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 5/6] x86/MCE: Save MCA control bits that get set in
 hardware
Message-ID: <20190517163729.GE13482@zn.tnic>
References: <20190516155202.GA11517@agluck-desk>
 <SN6PR12MB26397B30A120E3426184727FF80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190516165648.GB21857@zn.tnic>
 <SN6PR12MB26392B440ED735C26AA2C678F80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190516172117.GC21857@zn.tnic>
 <SN6PR12MB26394CD4E1BAC068B0B1AEF6F80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190516203456.GD21857@zn.tnic>
 <20190516205943.GA3299@agluck-desk>
 <20190517101006.GA32065@zn.tnic>
 <SN6PR12MB26391A0C3979030082EE38F8F80B0@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB26391A0C3979030082EE38F8F80B0@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, May 17, 2019 at 03:46:07PM +0000, Ghannam, Yazen wrote:
> I think there are a couple of issues here.
> 1) The bank is being initialized without accounting for any quirks.

Almost. __mcheck_cpu_init_clear_banks() a little bit later corrects
that. I guess I can drop the

	wrmsrl(msr_ops.status(i), 0);

in here because __mcheck_cpu_init_clear_banks() does that too.

Now, the

	wrmsrl(msr_ops.ctl(i), -1)
	rdmsrl(msr_ops.ctl(i), val);

method of throwing all 1s to see what sticks is what Intel wants, as
Tony said. Is that going to be a problem on AMD?

> 2) The bank is being initialized without having set up any handler or
> other appropriate setup.

I'm afraid you're going to have to explain this in more detail...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
