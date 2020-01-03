Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 997B712FD37
	for <lists+linux-edac@lfdr.de>; Fri,  3 Jan 2020 20:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgACTqc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 3 Jan 2020 14:46:32 -0500
Received: from mga02.intel.com ([134.134.136.20]:5446 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728564AbgACTqc (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 3 Jan 2020 14:46:32 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2020 11:46:31 -0800
X-IronPort-AV: E=Sophos;i="5.69,391,1571727600"; 
   d="scan'208";a="421526212"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2020 11:46:31 -0800
Date:   Fri, 3 Jan 2020 11:46:29 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <jschoenh@amazon.de>
Cc:     Borislav Petkov <bp@alien8.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH v2 6/6] x86/mce: Dynamically register default MCE handler
Message-ID: <20200103194629.GA9334@agluck-desk2.amr.corp.intel.com>
References: <20200103150722.20313-1-jschoenh@amazon.de>
 <20200103150722.20313-7-jschoenh@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200103150722.20313-7-jschoenh@amazon.de>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jan 03, 2020 at 04:07:22PM +0100, Jan H. Schönherr wrote:
> +retry:
> +	if (has_notifiers)
> +		blocking_notifier_chain_unregister(&x86_mce_decoder_chain,
> +						   &mce_default_nb);
> +	else
> +		blocking_notifier_chain_cond_register(&x86_mce_decoder_chain,
> +						      &mce_default_nb);

I get a compile error here:

  CC      arch/x86/kernel/cpu/mce/core.o
arch/x86/kernel/cpu/mce/core.c: In function ‘update_default_notifier_registration’:
arch/x86/kernel/cpu/mce/core.c:616:3: error: implicit declaration of function ‘blocking_notifier_chain_cond_register’; did you mean ‘blocking_notifier_chain_unregister’? [-Werror=implicit-function-declaration]
   blocking_notifier_chain_cond_register(&x86_mce_decoder_chain,
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   blocking_notifier_chain_unregister

-Tony
