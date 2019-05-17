Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5955A21EBC
	for <lists+linux-edac@lfdr.de>; Fri, 17 May 2019 21:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfEQToG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 May 2019 15:44:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:41554 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbfEQToG (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 17 May 2019 15:44:06 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 May 2019 12:44:06 -0700
X-ExtLoop1: 1
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by fmsmga007.fm.intel.com with ESMTP; 17 May 2019 12:44:05 -0700
Date:   Fri, 17 May 2019 12:44:05 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 5/6] x86/MCE: Save MCA control bits that get set in
 hardware
Message-ID: <20190517194405.GA28795@agluck-desk>
References: <SN6PR12MB26394CD4E1BAC068B0B1AEF6F80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190516203456.GD21857@zn.tnic>
 <20190516205943.GA3299@agluck-desk>
 <20190517101006.GA32065@zn.tnic>
 <SN6PR12MB26391A0C3979030082EE38F8F80B0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190517163729.GE13482@zn.tnic>
 <20190517172648.GA18164@agluck-desk>
 <20190517174817.GG13482@zn.tnic>
 <20190517180607.GA21710@agluck-desk>
 <20190517193431.GI13482@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517193431.GI13482@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, May 17, 2019 at 09:34:31PM +0200, Borislav Petkov wrote:
> On Fri, May 17, 2019 at 11:06:07AM -0700, Luck, Tony wrote:
> > and thus end up with that extra level on indent for the rest
> > of the function.
> 
> Ok:
> 
> @@ -1569,7 +1575,13 @@ static void __mcheck_cpu_init_clear_banks(void)
>  
>  		if (!b->init)
>  			continue;
> +
> +		/* Check if any bits are implemented in h/w */
>  		wrmsrl(msr_ops.ctl(i), b->ctl);
> +		rdmsrl(msr_ops.ctl(i), msrval);
> +
> +		b->init = !!msrval;
> +
>  		wrmsrl(msr_ops.status(i), 0);
>  	}

Much neater :-)

Acked-by: Tony Luck <tony.luck@intel.com>
