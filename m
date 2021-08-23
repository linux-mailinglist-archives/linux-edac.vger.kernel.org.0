Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0FC3F4D6C
	for <lists+linux-edac@lfdr.de>; Mon, 23 Aug 2021 17:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhHWPZW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 Aug 2021 11:25:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:31009 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhHWPZW (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 23 Aug 2021 11:25:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10085"; a="278136554"
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="278136554"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 08:24:39 -0700
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="526100722"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 08:24:38 -0700
Date:   Mon, 23 Aug 2021 08:24:37 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jue Wang <juew@google.com>, Ding Hui <dinghui@sangfor.com.cn>,
        naoya.horiguchi@nec.com, osalvador@suse.de,
        Youquan Song <youquan.song@intel.com>, huangcun@sangfor.com.cn,
        x86@kernel.org, linux-edac@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <20210823152437.GA1637466@agluck-desk2.amr.corp.intel.com>
References: <20210706190620.1290391-1-tony.luck@intel.com>
 <20210818002942.1607544-1-tony.luck@intel.com>
 <20210818002942.1607544-2-tony.luck@intel.com>
 <YR/m/8PCmCTbogey@zn.tnic>
 <20210820185945.GA1623421@agluck-desk2.amr.corp.intel.com>
 <YSACMCEoU6FxjDNh@zn.tnic>
 <20210820203356.GA1623896@agluck-desk2.amr.corp.intel.com>
 <YSJjNlTJiBx1v1SS@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSJjNlTJiBx1v1SS@zn.tnic>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Aug 22, 2021 at 04:46:14PM +0200, Borislav Petkov wrote:
> On Fri, Aug 20, 2021 at 01:33:56PM -0700, Luck, Tony wrote:
> > The new version (thanks to All fixing iov_iter.c) now does
> > exactly what POSIX says should happen.  If I have a buffer
> > with poison at offset 213, and I do this:
> > 
> > 	ret = write(fd, buf, 512);
> > 
> > Then the return from write is 213, and the first 213 bytes
> > from the buffer appear in the file, and the file size is
> > incremented by 213 (assuming the write started with the lseek
> > offset at the original size of the file).
> 
> ... and the user still gets a SIGBUS so that it gets a chance to handle
> the encountered poison? I.e., not retry the write for the remaining 512
> - 213 bytes?

Whether the user gets a SIGBUS depends on what they do next.  In a typical
user loop trying to do a write:

	while (nbytes) {
		ret = write(fd, buf, nbytes);
		if (ret == -1)
			return ret;
		buf += ret;
		nbytes -= ret;
	}

The next iteration after the short write caused by the machine check
will return ret == -1, errno = EFAULT.

Andy Lutomirski convinced me that the kernel should not send a SIGBUS
to an application when the kernel accesses the poison in user memory.

If the user tries to access the page with the poison directly they'll
get a SIGBUS (page was unmapped so user gets a #PF, but the x86 fault
handler sees that the page was unmapped because of poison, so sends a
SIGBUS).

> If so, do we document that somewhere so that application writers can
> know what they should do in such cases?

Applications see a failed write ... they should do whatever they would
normally do for a failed write.

-Tony
