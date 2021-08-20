Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D327A3F3554
	for <lists+linux-edac@lfdr.de>; Fri, 20 Aug 2021 22:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhHTUeg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 20 Aug 2021 16:34:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:57756 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230282AbhHTUeg (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 20 Aug 2021 16:34:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10082"; a="203983993"
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="203983993"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 13:33:57 -0700
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="463496452"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 13:33:57 -0700
Date:   Fri, 20 Aug 2021 13:33:56 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jue Wang <juew@google.com>, Ding Hui <dinghui@sangfor.com.cn>,
        naoya.horiguchi@nec.com, osalvador@suse.de,
        Youquan Song <youquan.song@intel.com>, huangcun@sangfor.com.cn,
        x86@kernel.org, linux-edac@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <20210820203356.GA1623896@agluck-desk2.amr.corp.intel.com>
References: <20210706190620.1290391-1-tony.luck@intel.com>
 <20210818002942.1607544-1-tony.luck@intel.com>
 <20210818002942.1607544-2-tony.luck@intel.com>
 <YR/m/8PCmCTbogey@zn.tnic>
 <20210820185945.GA1623421@agluck-desk2.amr.corp.intel.com>
 <YSACMCEoU6FxjDNh@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSACMCEoU6FxjDNh@zn.tnic>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Aug 20, 2021 at 09:27:44PM +0200, Borislav Petkov wrote:
> On Fri, Aug 20, 2021 at 11:59:45AM -0700, Luck, Tony wrote:
> As in: there was an MCE while trying to access this user memory, you
> should not do get_user anymore. You did add that
> 
>          * Return zero to pretend that this copy succeeded. This
>          * is counter-intuitive, but needed to prevent the code
>          * in lib/iov_iter.c from retrying and running back into
> 
> which you're removing with the last patch so I'm confused.

Forget to address this part in the earlier reply.

My original code that forced a zero return has a hack. It
allowed recovery to complete, but only because there was
going to be a SIGBUS.  There were some unplesant side effects.
E.g. on a write syscall the file size was updated as if the
write had succeeded. That would be very confusing for anyone
trying to clean up afterwards as the file would have good
data that was copied from the user up to the point where
the machine check interrupted things. Then NUL bytes after
(because the kernel clears pages that are allocated into
the page cache).

The new version (thanks to All fixing iov_iter.c) now does
exactly what POSIX says should happen.  If I have a buffer
with poison at offset 213, and I do this:

	ret = write(fd, buf, 512);

Then the return from write is 213, and the first 213 bytes
from the buffer appear in the file, and the file size is
incremented by 213 (assuming the write started with the lseek
offset at the original size of the file).

-Tony
