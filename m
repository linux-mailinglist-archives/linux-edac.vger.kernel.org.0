Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9B9988121
	for <lists+linux-edac@lfdr.de>; Fri,  9 Aug 2019 19:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406983AbfHIRZf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 9 Aug 2019 13:25:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:35903 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbfHIRZf (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 9 Aug 2019 13:25:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 10:25:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,366,1559545200"; 
   d="scan'208";a="180197881"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga006.jf.intel.com with ESMTP; 09 Aug 2019 10:25:34 -0700
Date:   Fri, 9 Aug 2019 10:25:33 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Stephen Douthit <stephend@silicom-usa.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC, pnd2: Fix ioremap() size in dnv_rd_reg()
Message-ID: <20190809172533.GA31823@agluck-desk2.amr.corp.intel.com>
References: <20190809141737.15580-1-stephend@silicom-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809141737.15580-1-stephend@silicom-usa.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Aug 09, 2019 at 02:18:02PM +0000, Stephen Douthit wrote:
> Depending on how BIOS has marked the reserved region containing the 32KB
> MCHBAR you can get warnings like:
> 
> resource sanity check: requesting [mem 0xfed10000-0xfed1ffff], which spans more than reserved [mem 0xfed10000-0xfed17fff]
> caller dnv_rd_reg+0xc8/0x240 [pnd2_edac] mapping multiple BARs
> 
> Not all of the mmio regions used in dnv_rd_reg() are the same size.  The
> MCHBAR window is 32KB and the sideband ports are 64KB.  Pass the correct
> size to ioremap() depending on which resource we're reading from.

Applied. Thanks.

-Tony

[Boris/Mauro: I pushed to edac-for-next branch in ras tree
 git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git]
