Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93B142937A
	for <lists+linux-edac@lfdr.de>; Mon, 11 Oct 2021 17:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237861AbhJKPgo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 11 Oct 2021 11:36:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:7814 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239229AbhJKPgl (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 11 Oct 2021 11:36:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10134"; a="226801165"
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="226801165"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 08:34:39 -0700
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="523873669"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 08:34:38 -0700
Date:   Mon, 11 Oct 2021 08:34:37 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Eric Badger <ebadger@purestorage.com>
Cc:     Meeta Saggi <msaggi@purestorage.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        "open list:EDAC-SBRIDGE" <linux-edac@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC/sb_edac: Fix top-of-high-memory value for
 Broadwell/Haswell
Message-ID: <YWRZjYTY7Mu1iK6L@agluck-desk2.amr.corp.intel.com>
References: <20211010170127.848113-1-ebadger@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211010170127.848113-1-ebadger@purestorage.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Oct 10, 2021 at 10:06:56AM -0700, Eric Badger wrote:
> The computation of TOHM is off by one bit. This missed bit results in
> too low a value for TOHM, which can cause errors in regular memory to
> incorrectly report:
> 
>   EDAC MC0: 1 CE Error at MMIOH area, on addr 0x000000207fffa680 on any memory
> 
> Reported-by: Meeta Saggi <msaggi@purestorage.com>
> Signed-off-by: Eric Badger <ebadger@purestorage.com>

Applied (with added Fixes: tag and Cc: stable).

Thanks

-Tony
