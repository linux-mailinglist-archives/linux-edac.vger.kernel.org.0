Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDE821D12
	for <lists+linux-edac@lfdr.de>; Fri, 17 May 2019 20:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfEQSGK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 May 2019 14:06:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:46547 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbfEQSGK (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 17 May 2019 14:06:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 May 2019 11:06:09 -0700
X-ExtLoop1: 1
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by orsmga001.jf.intel.com with ESMTP; 17 May 2019 11:06:08 -0700
Date:   Fri, 17 May 2019 11:06:07 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 5/6] x86/MCE: Save MCA control bits that get set in
 hardware
Message-ID: <20190517180607.GA21710@agluck-desk>
References: <SN6PR12MB26392B440ED735C26AA2C678F80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190516172117.GC21857@zn.tnic>
 <SN6PR12MB26394CD4E1BAC068B0B1AEF6F80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190516203456.GD21857@zn.tnic>
 <20190516205943.GA3299@agluck-desk>
 <20190517101006.GA32065@zn.tnic>
 <SN6PR12MB26391A0C3979030082EE38F8F80B0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190517163729.GE13482@zn.tnic>
 <20190517172648.GA18164@agluck-desk>
 <20190517174817.GG13482@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517174817.GG13482@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, May 17, 2019 at 07:48:17PM +0200, Borislav Petkov wrote:
> @@ -1562,15 +1567,21 @@ static void __mcheck_cpu_init_generic(void)
>  static void __mcheck_cpu_init_clear_banks(void)
>  {
>  	struct mce_bank *mce_banks = this_cpu_read(mce_banks_array);
> +	u64 msrval;
>  	int i;
>  
>  	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
>  		struct mce_bank *b = &mce_banks[i];
>  
> -		if (!b->init)
> -			continue;
> -		wrmsrl(msr_ops.ctl(i), b->ctl);
> -		wrmsrl(msr_ops.status(i), 0);
> +		if (b->init) {
> +			/* Check if any bits are implemented in h/w */
> +			wrmsrl(msr_ops.ctl(i), b->ctl);
> +			rdmsrl(msr_ops.ctl(i), msrval);
> +
> +			b->init = !!msrval;
> +
> +			wrmsrl(msr_ops.status(i), 0);
> +		}
>  	}
>  }

Am I misreading the diff here? It doesn't look like you
needed to drop the

	if (!b->init)
		continue;

and thus end up with that extra level on indent for the rest
of the function.

-Tony
