Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306ED20672B
	for <lists+linux-edac@lfdr.de>; Wed, 24 Jun 2020 00:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387686AbgFWW1B (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Jun 2020 18:27:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:13800 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387502AbgFWW1B (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 23 Jun 2020 18:27:01 -0400
IronPort-SDR: yNLeDcZn8P2r+fcdYU3Rdnf60indNGOGg+xYGg2eQ3koaem973YmOura75NmBAAVXp87q0S1yi
 1u46npoeSdpQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="205752949"
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; 
   d="scan'208";a="205752949"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 15:27:00 -0700
IronPort-SDR: KivnWswfxnKY5P1q74x/ixCXTK2rkkNhH6XanVYnObNm5mLI9agHtMWJH61xmoW0H6+WKH/5At
 LcGyHppLm1kA==
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; 
   d="scan'208";a="452411863"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 15:27:00 -0700
Date:   Tue, 23 Jun 2020 15:26:58 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-edac@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jane Chu <jane.chu@oracle.com>
Subject: Re: [RFC] Make the memory failure blast radius more precise
Message-ID: <20200623222658.GA21817@agluck-desk2.amr.corp.intel.com>
References: <20200623201745.GG21350@casper.infradead.org>
 <20200623220412.GA21232@agluck-desk2.amr.corp.intel.com>
 <20200623221741.GH21350@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623221741.GH21350@casper.infradead.org>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jun 23, 2020 at 11:17:41PM +0100, Matthew Wilcox wrote:
> It might also be nice to have an madvise() MADV_ZERO option so the
> application doesn't have to look up the fd associated with that memory
> range, but we haven't floated that idea with the customer yet; I just
> thought of it now.

So the conversation between OS and kernel goes like this?

1) machine check
2) Kernel unmaps the 4K page surroundinng the poison and sends
   SIGBUS to the application to say that one cache line is gone
3) App says madvise(MADV_ZERO, that cache line)
4) Kernel says ... "oh, you know how to deal with this" and allocates
   a new page, copying the 63 good cache lines from the old page and
   zeroing the missing one. New page is mapped to user.

Do you have folks lined up to use that?  I don't know that many
folks are even catching the SIGBUS :-(

-Tony
