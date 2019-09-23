Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7641BBF32
	for <lists+linux-edac@lfdr.de>; Tue, 24 Sep 2019 01:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503465AbfIWX5T (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 Sep 2019 19:57:19 -0400
Received: from mga06.intel.com ([134.134.136.31]:59161 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729276AbfIWX5T (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 23 Sep 2019 19:57:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Sep 2019 16:57:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,542,1559545200"; 
   d="scan'208";a="190837479"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga003.jf.intel.com with ESMTP; 23 Sep 2019 16:57:18 -0700
Date:   Mon, 23 Sep 2019 16:57:18 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Aristeu Rozanski <aris@redhat.com>, linux-edac@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] EDAC, skx: Retrieve and print retry_rd_err_log
 registers
Message-ID: <20190923235717.GA26746@agluck-desk2.amr.corp.intel.com>
References: <20190913221344.13055-1-tony.luck@intel.com>
 <20190913221344.13055-3-tony.luck@intel.com>
 <20190918075246.534d9d6c@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918075246.534d9d6c@coco.lan>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Sep 18, 2019 at 07:52:46AM -0300, Mauro Carvalho Chehab wrote:
> >  			break;
> > +		case ERRCHAN0: case ERRCHAN1: case ERRCHAN2:
> 
> I would place each case on a separate line, in order to make easier
> to read it, and to follow the Kernel coding style.

This follows the pattern in this driver a couple of lines
earlier:

		case CHAN0: case CHAN1: case CHAN2:

It's not explicitly disallowed by Documentation/process/coding-style.rst
which just says to indent the "case" at the same level as the "switch".
(Though the example does put each case on a new line).

> > +	pci_read_config_dword(edev, 0x154, &log0);
> > +	pci_read_config_dword(edev, 0x148, &log1);
> > +	pci_read_config_dword(edev, 0x150, &log2);
> > +	pci_read_config_dword(edev, 0x15c, &log3);
> > +	pci_read_config_dword(edev, 0x114, &log4);
> > +
> > +	dev_err(&edev->dev, "retry_rd_err_log[%.8x %.8x %.8x %.8x %.8x]\n",
> > +		log0, log1, log2, log3, log4);
> > +
> > +	pci_read_config_dword(edev, 0x104, &corr0);
> > +	pci_read_config_dword(edev, 0x108, &corr1);
> > +	pci_read_config_dword(edev, 0x10c, &corr2);
> > +	pci_read_config_dword(edev, 0x110, &corr3);
> > +
> > +	dev_err(&edev->dev, "correrrcnt[%.8x %.8x %.8x %.8x]\n",
> > +		corr0, corr1, corr2, corr3);
> 
> I would report both dev_err above via EDAC.

I was concerned about how big the buffer was ... but I see that
MSG_SIZE is 1024 ... so plenty of space for this extra information.
I will move this into the EDAC report in next version.

> Btw, can't those be output on a way that wouldn't require someone
> to look at the datasheet for the meaning of those registers? 
> "retry_rd_err_log" and "correrrcnt" sounds too obscure for me to
> understand what they mean without reading the entire driver's code and
> read the datasheets.

I did put a note about correrrcnt in the commit comment. Each
value contains a pair of 16-bit values for the per-rank corrected
error counters (max 8 with a pair of quad-rank DIMMs in a channel).
I suppose it would be better to print as 8 per-rank values instead
of 4 paired values.

Intel isn't keen on doing the detailed decode of the retry_rd_err_log
(it took some arm twisting to get folks to let me print them in hex).

-Tony
