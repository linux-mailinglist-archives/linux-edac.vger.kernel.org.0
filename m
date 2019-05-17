Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5B821C6B
	for <lists+linux-edac@lfdr.de>; Fri, 17 May 2019 19:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfEQR0u (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 May 2019 13:26:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:33548 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfEQR0u (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 17 May 2019 13:26:50 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 May 2019 10:26:49 -0700
X-ExtLoop1: 1
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by orsmga003.jf.intel.com with ESMTP; 17 May 2019 10:26:49 -0700
Date:   Fri, 17 May 2019 10:26:49 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 5/6] x86/MCE: Save MCA control bits that get set in
 hardware
Message-ID: <20190517172648.GA18164@agluck-desk>
References: <SN6PR12MB26397B30A120E3426184727FF80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190516165648.GB21857@zn.tnic>
 <SN6PR12MB26392B440ED735C26AA2C678F80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190516172117.GC21857@zn.tnic>
 <SN6PR12MB26394CD4E1BAC068B0B1AEF6F80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190516203456.GD21857@zn.tnic>
 <20190516205943.GA3299@agluck-desk>
 <20190517101006.GA32065@zn.tnic>
 <SN6PR12MB26391A0C3979030082EE38F8F80B0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190517163729.GE13482@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517163729.GE13482@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, May 17, 2019 at 06:37:29PM +0200, Borislav Petkov wrote:
> Now, the
> 
> 	wrmsrl(msr_ops.ctl(i), -1)
> 	rdmsrl(msr_ops.ctl(i), val);
> 
> method of throwing all 1s to see what sticks is what Intel wants, as
> Tony said. Is that going to be a problem on AMD?

It is what we want in general ...  but there is this:

        if (c->x86_vendor == X86_VENDOR_INTEL) {
                /*
                 * SDM documents that on family 6 bank 0 should not be written
                 * because it aliases to another special BIOS controlled
                 * register.
                 * But it's not aliased anymore on model 0x1a+
                 * Don't ignore bank 0 completely because there could be a
                 * valid event later, merely don't write CTL0.
                 */

                if (c->x86 == 6 && c->x86_model < 0x1A && cfg->banks > 0)
                        mce_banks[0].init = 0;

Which is a quirk for some models where we don't want to do
the "write all 1s and see what sticks"

-Tony
