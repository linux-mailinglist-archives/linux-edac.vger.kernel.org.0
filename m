Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2CF23F148
	for <lists+linux-edac@lfdr.de>; Fri,  7 Aug 2020 18:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgHGQdy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 Aug 2020 12:33:54 -0400
Received: from mga07.intel.com ([134.134.136.100]:30233 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbgHGQdy (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 Aug 2020 12:33:54 -0400
IronPort-SDR: 9ahkTj/4SeFBm8PWnupV9gof4IpZlQFgEoLDId9hgHnOPEs/e1MnMnH7+ExyG+3Q/NXVaO2RBN
 yIp0eg8ICVkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9706"; a="217456576"
X-IronPort-AV: E=Sophos;i="5.75,446,1589266800"; 
   d="scan'208";a="217456576"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2020 09:33:53 -0700
IronPort-SDR: P3O3CYNi+/1HkZgOxOwghgo4E6FUS5SVD38aV2QwO80BJic9lU/U2BUR/qgV5qyflM1KViU76E
 pJ4R8+GRscJw==
X-IronPort-AV: E=Sophos;i="5.75,446,1589266800"; 
   d="scan'208";a="468286881"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2020 09:33:53 -0700
Date:   Fri, 7 Aug 2020 09:33:51 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Steve Wahl <steve.wahl@hpe.com>
Cc:     Kyle Meyer <kyle.meyer@hpe.com>, russ.anderson@hpe.com,
        bp@alien8.de, linux-edac@vger.kernel.org
Subject: Re: [PATCH] x86/MCE: Set the MCE's status and misc members
Message-ID: <20200807163351.GA28961@agluck-desk2.amr.corp.intel.com>
References: <20200807142750.270548-1-kyle.meyer@hpe.com>
 <20200807150548.GK4686@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807150548.GK4686@localhost.localdomain>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Aug 07, 2020 at 10:05:50AM -0500, Steve Wahl wrote:
> There's one small code change I suggest below.
> 
> But now it's time to think about the description.  We need to zoom out
> to the 10,000 ft. view.  IMHO, to understand what this patch does,
> your current description requires the reader to be more familiar with
> the involved functions than we should expect.

Maybe also travel back in time to why apei_mce_report_mem_error()
was created in the first place.

This was a workaround for a couple of Intel CPUs (Nehalem, Westmere)
that didn't provide a system address in MCi_ADDR. Since BIOS could figure
out the address, it was tasked with reporting to the OS suing APEI.

apei_mce_report_mem_error() did the minimum necessary to create
an error log that mcelog(8) daemon could process.

Jump forward in time to Sandybridge (and all successors) and the
reason for the workaround is gone. All of them provide a system
address in the machine check bank ... so this APEI path is a
poor substitute for getting the data from the machine check bank
(which will give you the channel, the corrected error count, and
perhaps other useful information).

So why are we applying band-aids to this decade old workaround?

-Tony
