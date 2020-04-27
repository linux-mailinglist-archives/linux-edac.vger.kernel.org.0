Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09F91BAB16
	for <lists+linux-edac@lfdr.de>; Mon, 27 Apr 2020 19:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgD0RYJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Apr 2020 13:24:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:20457 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgD0RYJ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 27 Apr 2020 13:24:09 -0400
IronPort-SDR: KI+QSblsX4clCLDdctlfk6DDuBox++UdzurSoYnZku3EjXUNoWsLyQA1/iylYwVlSk/kVmA5ai
 JLYemdJFKGJw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 10:24:09 -0700
IronPort-SDR: t4+pw8a0fxZyPc1F3AXiaSD2C1lYZ9vgoM9lrl0bsUyiLHWf89FKzZOpBJiuDk9FkrbNPa/XTO
 ZUAL6LBPshgw==
X-IronPort-AV: E=Sophos;i="5.73,324,1583222400"; 
   d="scan'208";a="458457221"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 10:24:09 -0700
Date:   Mon, 27 Apr 2020 10:24:08 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Robert Richter <rrichter@marvell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Matthias Brugger <mbrugger@suse.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/10] EDAC/ghes: Remove local variable rdr_mask in
 ghes_edac_dmidecode()
Message-ID: <20200427172408.GA13177@agluck-desk2.amr.corp.intel.com>
References: <20200422115814.22205-1-rrichter@marvell.com>
 <20200422115814.22205-7-rrichter@marvell.com>
 <20200427070802.GA11036@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427070802.GA11036@zn.tnic>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Apr 27, 2020 at 09:08:02AM +0200, Borislav Petkov wrote:
> >  			if (entry->type_detail & BIT(6))
> >  				dimm->mtype = MEM_RMBS;
> > -			else if ((entry->type_detail & rdr_mask) == rdr_mask)
> > +			else if ((entry->type_detail & BIT(7)) &&
> > +				 (entry->type_detail & BIT(13)))
> 
> Well, "checks some bits" doesn't make it more telling than checking a
> descriptive name like "rdr_mask" but ok, since we're assigning MEM_RDR
> here, it is still clear what the check does.
> 
> Btw, please write it like this:
> 
> 			else if (entry->type_detail & (BIT(7) | BIT(13)))

That isn't the same. The previous version checked that BOTH bits
7 and 13 were set. Your version checks for either bit.

Looks like the original with the local variable was checking for both
bits set.

-Tony
